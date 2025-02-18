// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Bank - Um contrato simples para depósito e saque de Ether.
/// @notice Este contrato demonstra o uso de mapeamentos, modifiers, erros customizados e funções administrativas.
contract Bank {
    // -------------------------------------------------------------------
    // Variáveis de Estado
    // -------------------------------------------------------------------
    
    /// @notice Mapeamento para armazenar os saldos dos usuários.
    /// Cada endereço (user) possui um saldo (em wei) associado.
    mapping(address => uint256) private balances;

    /// @notice Mapeamento para armazenar quais endereços estão aprovados para operações restritas (ex.: saque).
    /// Se approveAddr[endereço] for true, o endereço está autorizado a sacar.
    mapping(address => bool) public approveAddr;

    /// @notice Endereço do proprietário (owner) do contrato.
    /// Este valor é definido na implantação e não pode ser alterado.
    address public immutable owner;

    /// @notice Variável para armazenar uma quantidade genérica.
    /// OBS: Atualmente, essa variável é utilizada para somar os valores depositados.
    /// Sugestão: Se desejar contar o número total de depósitos, pode-se criar uma variável separada, ex.: depositCount.
    uint256 public quantity;

    // -------------------------------------------------------------------
    // Erros Customizados
    // -------------------------------------------------------------------

    /// @notice Erro para saldo insuficiente durante o saque.
    error InsufficientBalance(uint256 requested, uint256 available);

    /// @notice Erro para acesso não autorizado a funções administrativas.
    error UnauthorizedAccess(address caller);

    /// @notice Erro para mensagens customizadas.
    error Message(string message);

    // -------------------------------------------------------------------
    // Construtor e Modifiers
    // -------------------------------------------------------------------

    /// @notice Construtor do contrato que define o proprietário (owner).
    /// @param _owner Endereço que será definido como owner.
    constructor(address _owner) {
        owner = _owner;
    }

    /// @notice Modifier que restringe o acesso apenas ao owner do contrato.
    modifier OnlyOwner(){
        require(msg.sender == owner, "is not a owner");
        _;
    }

    /// @notice Modifier que restringe o acesso apenas a endereços aprovados.
    modifier OnlyApproved(){
        require(approveAddr[msg.sender], "is not approved");
        _;
    }

    // -------------------------------------------------------------------
    // Funções Principais
    // -------------------------------------------------------------------

    /// @notice Função para depositar fundos no banco.
    /// @dev A função é payable para aceitar Ether. Se o depósito for bem-sucedido, o saldo do usuário é atualizado e o usuário é automaticamente aprovado.
    function deposit() external payable {
        // Verifica se o valor enviado é maior que zero.
        if (msg.value <= 0) revert Message({message: "You must deposit some ether"});
        // Atualiza o saldo do usuário com o valor enviado.
        balances[msg.sender] += msg.value;
        // Marca o endereço do usuário como aprovado para operações restritas.
        approveAddr[msg.sender] = true;
        // Atualiza a variável 'quantity' somando o valor depositado.
        // OBS: Essa variável pode ser usada para monitorar o total de Ether depositado pelos usuários.
        quantity += msg.value;
    }

    /// @notice Função que recebe depósitos diretamente para o contrato.
    /// @dev Essa função não altera os saldos dos usuários no mapeamento.
    /// Ela serve para demonstrar o uso da função receive().
    function depositBank() external payable {
        // Transfere o Ether enviado para o próprio contrato.
        // OBS: Como o Ether enviado já fica no contrato, esta linha não é estritamente necessária.
        payable(address(this)).transfer(msg.value);
    }

    /// @notice Função receive para receber Ether quando nenhuma outra função é chamada.
    receive() external payable {
        // Ao receber Ether, o saldo do contrato é atualizado automaticamente.
    }

    /// @notice Função para sacar fundos do banco.
    /// @dev Apenas endereços aprovados (ver modifier OnlyApproved) podem realizar saques.
    /// Uma taxa de 2% do valor sacado é cobrada e transferida para o owner.
    /// @param amount Valor a ser sacado (em wei).
    function withdraw(uint256 amount) external OnlyApproved {
        // Obtém o saldo do usuário que está tentando sacar.
        uint256 userBalance = balances[msg.sender];

        // Calcula uma taxa de 2% que será transferida para o owner do contrato.
        uint256 feeBank = amount * 2 / 100;
        // Calcula o valor final que o usuário receberá após a dedução da taxa.
        uint256 calculateUser = amount - feeBank;

        // Verifica se o usuário possui saldo suficiente para o saque.
        if (amount > userBalance) {
            revert InsufficientBalance({requested: amount, available: userBalance});
        }

        // Atualiza o saldo do usuário antes de realizar a transferência para evitar reentrância.
        balances[msg.sender] -= amount;

        // Transfere o valor (após dedução da taxa) para o usuário.
        payable(msg.sender).transfer(calculateUser);
        // Transfere a taxa para o owner do contrato.
        payable(owner).transfer(feeBank);
    }

    /// @notice Função para consultar o saldo do usuário que chama a função.
    /// @return O saldo do usuário (em wei).
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice Função administrativa para acessar o saldo de um usuário específico.
    /// @dev Apenas um endereço específico (administrador) pode utilizar essa função.
    /// @param user Endereço do usuário cujo saldo se deseja consultar.
    /// @return O saldo do usuário (em wei).
    function getUserBalance(address user) external view returns (uint256) {
        // Verifica se o chamador é o endereço autorizado.
        if (msg.sender != address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)) {
            revert UnauthorizedAccess({caller: msg.sender});
        }
        return balances[user];
    }

    /// @notice Função de teste para demonstrar o comportamento de overflow em Solidity 0.8+
    /// @dev uint8 suporta valores até 255. Ao adicionar 1, o contrato reverterá automaticamente.
    function testOverFlow() external pure {
        uint8 a = 255;
        a += 1; // Isto causará um erro de overflow e reverterá a transação.
    }

    // -------------------------------------------------------------------
    // Funções Adicionais Sugeridas
    // -------------------------------------------------------------------

    /// @notice Função para o owner aprovar manualmente um endereço, permitindo que ele realize saques.
    /// @dev Essa função pode ser útil para gerenciar permissões sem depender apenas do depósito.
    /// @param user Endereço a ser aprovado.
    function approveUser(address user) external OnlyOwner {
        approveAddr[user] = true;
    }

    /// @notice Função para o owner revogar a aprovação de um endereço.
    /// @dev Dessa forma, o owner pode impedir que um usuário não autorizado realize saques.
    /// @param user Endereço a ter a aprovação revogada.
    function revokeApproval(address user) external OnlyOwner {
        approveAddr[user] = false;
    }

    /// @notice Função para consultar o saldo total de Ether armazenado no contrato.
    /// @dev Útil para monitorar os fundos totais mantidos pelo contrato.
    /// @return Saldo total do contrato (em wei).
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /// @notice Função para permitir que o owner retire todos os fundos do contrato em uma situação de emergência.
    /// @dev Apenas o owner pode chamar esta função.
    function emergencyWithdraw() external OnlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds available");
        payable(owner).transfer(contractBalance);
    }
}
