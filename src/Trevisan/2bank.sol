// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Bank {
    // Mapeamento para armazenar os saldos dos usuários.
    mapping(address => uint256) private balances;
    //armazenamento do owner
    address public immutable owner;

    // Erros customizados para reverter operações com mensagens claras.
    error InsufficientBalance(uint256 requested, uint256 available);
    error UnauthorizedAccess(address caller);
    error Message(string message);

    constructor(address _owner) {
        owner = _owner;
    }

    // Depósito de fundos no banco.
    function deposit() external payable {
        if (msg.value <= 0) revert Message({message: "You must deposit some ether"});
        balances[msg.sender] += msg.value;
    }

    // Saque de fundos.
    function withdraw(uint256 amount) external {
        uint256 userBalance = balances[msg.sender];

        // Usando `if` para verificar condições e reverter com erros customizados.
        if (amount > userBalance) {
            revert InsufficientBalance({requested: amount, available: userBalance});
        }

        // Atualizando saldo antes de transferir para prevenir reentrância.
        balances[msg.sender] -= amount;

        // Transferindo os fundos para o chamador.
        payable(msg.sender).transfer(amount);
    }

    // Consulta do saldo atual.
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Função administrativa para acessar saldos de outros usuários.
    function getUserBalance(address user) external view returns (uint256) {
        // Apenas o endereço 0xAdmin pode acessar.
        if (msg.sender != address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)) {
            revert UnauthorizedAccess({caller: msg.sender});
        }
        return balances[user];
    }

    function testOverFlow() external pure {
        uint8 a = 255;
        a += 1; // Reverte automaticamente
    }
}
