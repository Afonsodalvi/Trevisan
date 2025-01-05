// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Contrato de Supply Chain com Enum Avançado
/// @dev Demonstra o uso de enums, structs e métodos de controle no Solidity.

contract SupplyChain {
    // ------------------------------
    // Definição de Tipos e Enums
    // ------------------------------

    /// @notice Enum para representar o status de uma mercadoria na cadeia de suprimentos.
    enum Status {
        Criado, // 0
        Processado, // 1
        Enviado, // 2
        Entregue, // 3
        Cancelado // 4

    }

    /// @notice Estrutura para armazenar informações sobre uma mercadoria.
    struct Mercadoria {
        uint256 id;
        string descricao;
        address remetente;
        address destinatario;
        uint256 preco;
        Status status;
    }

    // ------------------------------
    // Variáveis e Mapeamentos
    // ------------------------------

    uint256 public mercadoriaCounter; // Contador global para IDs de mercadorias.
    mapping(uint256 => Mercadoria) public mercadorias; // Mapeia ID para a mercadoria.

    address public owner; // Proprietário do contrato.

    // ------------------------------
    // Modificadores
    // ------------------------------

    /// @notice Garante que apenas o proprietário do contrato possa executar a função.
    modifier onlyOwner() {
        require(msg.sender == owner, "Apenas o owner pode executar esta funcao.");
        _;
    }

    /// @notice Verifica se uma mercadoria existe pelo ID.
    /// @param _id ID da mercadoria.
    modifier mercadoriaExiste(uint256 _id) {
        require(_id > 0 && _id <= mercadoriaCounter, "Mercadoria nao encontrada.");
        _;
    }

    // ------------------------------
    // Eventos
    // ------------------------------

    event MercadoriaCriada(uint256 id, string descricao, address remetente, address destinatario, uint256 preco);
    event StatusAtualizado(uint256 id, Status novoStatus);

    // ------------------------------
    // Construtor
    // ------------------------------

    /// @notice Inicializa o contrato com o endereço do proprietário.
    constructor() {
        owner = msg.sender;
    }

    // ------------------------------
    // Funções Principais
    // ------------------------------

    /// @notice Cria uma nova mercadoria na cadeia de suprimentos.
    /// @param _descricao Descrição da mercadoria.
    /// @param _destinatario Endereço do destinatário.
    /// @param _preco Preço da mercadoria.
    function criarMercadoria(string memory _descricao, address _destinatario, uint256 _preco) public onlyOwner {
        require(bytes(_descricao).length > 0, "Descricao invalida.");
        require(_destinatario != address(0), "Endereco do destinatario invalido.");
        require(_preco > 0, "Preco deve ser maior que zero.");

        mercadoriaCounter++;
        mercadorias[mercadoriaCounter] = Mercadoria({
            id: mercadoriaCounter,
            descricao: _descricao,
            remetente: msg.sender,
            destinatario: _destinatario,
            preco: _preco,
            status: Status.Criado
        });

        emit MercadoriaCriada(mercadoriaCounter, _descricao, msg.sender, _destinatario, _preco);
    }

    /// @notice Atualiza o status de uma mercadoria.
    /// @param _id ID da mercadoria.
    /// @param _novoStatus Novo status da mercadoria.
    function atualizarStatus(uint256 _id, Status _novoStatus) public mercadoriaExiste(_id) onlyOwner {
        require(_novoStatus != Status.Criado, "Status invalido para atualizacao.");

        Mercadoria storage mercadoria = mercadorias[_id];
        mercadoria.status = _novoStatus;

        emit StatusAtualizado(_id, _novoStatus);
    }

    /// @notice Consulta o status de uma mercadoria.
    /// @param _id ID da mercadoria.
    /// @return O status atual da mercadoria.
    function consultarStatus(uint256 _id) public view mercadoriaExiste(_id) returns (Status) {
        return mercadorias[_id].status;
    }

    /// @notice Permite que o destinatário confirme a entrega da mercadoria.
    /// @param _id ID da mercadoria.
    function confirmarEntrega(uint256 _id) public mercadoriaExiste(_id) {
        Mercadoria storage mercadoria = mercadorias[_id];
        require(msg.sender == mercadoria.destinatario, "Apenas o destinatario pode confirmar a entrega.");
        require(mercadoria.status == Status.Enviado, "Mercadoria nao foi enviada.");

        mercadoria.status = Status.Entregue;

        emit StatusAtualizado(_id, Status.Entregue);
    }
}
