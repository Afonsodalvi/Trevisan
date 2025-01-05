// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/// @title Exemplos de Mappings em Solidity
/// @dev Este contrato demonstra como usar mappings para criar relações semelhantes a dicionários.
contract NovaTurmaMapping {
    // ------------------------------
    // Declaração de Mappings
    // ------------------------------

    /// @notice Relaciona uma palavra com seu significado, como um dicionário.
    mapping(string => string) public dicionario;

    /// @notice Relaciona o nome de um aluno com seu número de presença.
    mapping(string => uint256) public presencaNumero;

    /// @notice Relaciona um endereço (aluno) com sua presença (true ou false).
    mapping(address => bool) public presenca;

    /// @notice Relaciona o endereço de um professor com um mapping de alunos e suas respectivas notas.
    mapping(address => mapping(address => uint256)) public notaProfAluno;

    // ------------------------------
    // Constructor
    // ------------------------------

    /// @notice Inicializa o contrato com alguns valores predefinidos.
    /// @dev Usado para demonstrar como inicializar mappings no deployment.
    constructor() {
        dicionario["Solidity"] = "Linguagem de programacao para contratos inteligentes";
        presencaNumero["Joao"] = 1;
        presenca[0x000000000000000000000000000000000000dEaD] = true; // Exemplo fictício
    }

    // ------------------------------
    // Funções para Manipular Mappings
    // ------------------------------

    /// @notice Atualiza o dicionário com uma nova palavra e seu significado.
    /// @param palavra A palavra a ser adicionada ou atualizada.
    /// @param significado O significado da palavra.
    function setarPalavrasAoDicio(string memory palavra, string memory significado) external {
        dicionario[palavra] = significado;
    }

    /// @notice Define o número de presença de um aluno.
    /// @param numeroChegada O número da chegada do aluno.
    /// @param nomeDoAluno O nome do aluno.
    function setarNumpresenca(uint256 numeroChegada, string memory nomeDoAluno) external {
        require(numeroChegada > 0, "O numero de chegada deve ser maior que zero!");
        presencaNumero[nomeDoAluno] = numeroChegada;
    }

    /// @notice Marca a presença do chamador (msg.sender).
    function setarPresenca() external {
        presenca[msg.sender] = true;
    }

    /// @notice Define a nota de um aluno associada ao professor chamador.
    /// @param aluno O endereço do aluno.
    /// @param nota A nota atribuída ao aluno.
    function setarNotaAluno(address aluno, uint256 nota) external {
        require(nota <= 100, "A nota maxima e 100!");
        notaProfAluno[msg.sender][aluno] = nota;
    }

    // ------------------------------
    // Funções Auxiliares para Consulta
    // ------------------------------

    /// @notice Consulta a nota de um aluno atribuída por um professor.
    /// @param professor O endereço do professor.
    /// @param aluno O endereço do aluno.
    /// @return A nota do aluno atribuída pelo professor.
    function consultarNota(address professor, address aluno) external view returns (uint256) {
        return notaProfAluno[professor][aluno];
    }

    /// @notice Verifica se um endereço marcou presença.
    /// @param aluno O endereço do aluno.
    /// @return Verdadeiro se o aluno marcou presença, falso caso contrário.
    function verificarPresenca(address aluno) external view returns (bool) {
        return presenca[aluno];
    }
}
