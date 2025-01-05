// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exemplos de Variáveis em Smart Contracts
/// @dev Este contrato demonstra diferentes tipos de variáveis em Solidity e como utilizá-las.

contract ExemplosVariaveis {
    // ------------------------------
    // Declaração de variáveis públicas
    // ------------------------------

    /// @notice Um número máximo permitido (uint8 pode armazenar valores de 0 a 255).
    uint8 public maxPermit = 255;

    /// @notice Um número para testar limites de uint8.
    uint8 public testLimit;

    /// @notice O número maximo do uint256.
    uint256 public maxUint = type(uint256).max;

    /// @notice Um exemplo de número negativo (int256 suporta números positivos e negativos).
    int256 public negativo = -1;

    /// @notice Um número sem sinal (uint256 armazena apenas números positivos).
    uint256 public numero;

    /// @notice Um número com sinal (int256 armazena positivos e negativos).
    int256 public numeroNegativo;

    // ------------------------------
    // Variáveis booleanas, endereços e strings
    // ------------------------------

    /// @notice Controla permissões (verdadeiro ou falso).
    bool public permissao;

    /// @notice Um endereço registrado na blockchain.
    address public contaRegistrada;

    /// @notice Um nome armazenado como string.
    string public nome;

    /// @notice Armazena dados binários como bytes.
    bytes public Meusbytes;

    // ------------------------------
    // Funções de manipulação de variáveis
    // ------------------------------

    /// @notice Insere um número para testar o limite de uint8.
    /// @dev Se `_numero` exceder 255, a transação será revertida.
    /// @param _numero O número a ser inserido.
    function inserirMaxUint(uint8 _numero) external {
        testLimit = _numero;
    }

    /// @notice Armazena um número sem sinal (uint256).
    /// @param _numero O número a ser armazenado.
    function inserirNum(uint256 _numero) external {
        numero = _numero;
    }

    /// @notice Realiza uma operação com números negativos e retorna o resultado.
    /// @param _numero Um número negativo de entrada.
    /// @return O resultado da subtração do número negativo armazenado e `_numero`.
    function calcularNegativo(int256 _numero) external view returns (int256) {
        int256 somaDosNegativos = negativo - _numero; // Negativo - Negativo = Positivo
        return somaDosNegativos;
    }

    /// @notice Altera o estado da permissão.
    /// @param _estado Verdadeiro ou falso para alterar a permissão.
    function mudarPermissao(bool _estado) external {
        permissao = _estado;
    }

    /// @notice Registra um endereço fornecido como parâmetro.
    /// @param _endereco O endereço a ser registrado.
    function registrarEndereco(address _endereco) external {
        contaRegistrada = _endereco;
    }

    /// @notice Registra o endereço do chamador (msg.sender) e um nome.
    /// @param _meuNome O nome a ser registrado.
    function registrarEnderecoENome(string memory _meuNome) external {
        contaRegistrada = msg.sender;
        nome = _meuNome;
    }

    /// @notice Armazena dados binários (bytes).
    /// @param _dados Os dados a serem armazenados.
    function armazenarDados(bytes memory _dados) public {
        Meusbytes = _dados;
    }

    /// @notice Converte uma string para bytes32.
    /// @param _frase A string a ser convertida.
    /// @return A versão em bytes32 da string.
    function converterStringParaBytes(string memory _frase) external pure returns (bytes32) {
        return bytes32(bytes(_frase));
    }

    /// @notice Retorna o tamanho (em bytes) dos dados armazenados.
    /// @return O tamanho dos dados armazenados.
    function obterTamanhoDados() public view returns (uint256) {
        return Meusbytes.length;
    }
}
