// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exemplos de Arrays em Solidity
/// @dev Este contrato demonstra arrays fixos, dinâmicos e multidimensionais com exemplos práticos.
contract ExemplosArrays {
    // ------------------------------
    // Declaração de Variáveis
    // ------------------------------

    /// @notice Array fixo com tamanho de 4 para armazenar nomes de alunos.
    string[4] public alunos;

    /// @notice Array dinâmico para armazenar nomes de disciplinas.
    string[] public disciplinas;


    // MATRIZ DE ARRAYS
    //+-----------------------------------------+
    //|                                         |
    //|  Linha 0:  [ "Matemática" , "Prof. João" ]  <- Cada linha é um array com 2 elementos  
    //|                                         |
    //|  Linha 1:  [ "Português"  , "Prof. Maria" ]  
    //|                                         |
    //|  Linha 2:  [ "História"   , "Prof. Carlos" ]  
    //|                                         |
    //+-----------------------------------------+


    /// @notice Array multidimensional para armazenar disciplinas e seus professores.
    /// @dev Cada entrada é uma matriz onde:
    /// - Índice 0: Nome da disciplina.
    /// - Índice 1: Nome do professor.
    string[][] private matrizesDiscProf;

    // ------------------------------
    // Funções para Manipular Arrays
    // ------------------------------

    /// @notice Adiciona uma nova disciplina ao array dinâmico.
    /// @param nomeDisciplina O nome da disciplina a ser adicionada.
    function definirDisciplina(string memory nomeDisciplina) external {
        disciplinas.push(nomeDisciplina);
    }

    /// @notice Remove uma disciplina do array dinâmico pelo índice.
    /// @dev O valor no índice será substituído por uma string vazia.
    /// @param indiceDisciplina O índice da disciplina a ser removida.
    function deletarDisciplina(uint256 indiceDisciplina) external {
        require(indiceDisciplina < disciplinas.length, "Indice invalido!");
        delete disciplinas[indiceDisciplina];
    }

    /// @notice Define o nome de um aluno em um array fixo.
    /// @param indice O índice do aluno no array fixo (0 a 3).
    /// @param nomeAluno O nome do aluno a ser inserido.
    function definirAluno(uint8 indice, string memory nomeAluno) external {
        require(indice < alunos.length, "Indice invalido! Maximo permitido: 3");
        alunos[indice] = nomeAluno;
    }

    /// @notice Adiciona uma disciplina e um professor ao array multidimensional.
    /// @param disciplina O nome da disciplina.
    /// @param professor O nome do professor responsável.
    function definirDisciplinaEProfessor(string memory disciplina, string memory professor) external {
        matrizesDiscProf.push([disciplina, professor]);
    }

    /// @notice Retorna o nome de uma disciplina ou professor de acordo com o índice.
    /// @dev Para acessar:
    /// - `indiceDisciplina`: O índice da gaveta (linha).
    /// - `indiceInformacao`: 0 para disciplina, 1 para professor.
    /// @param indiceDisciplina O índice da gaveta.
    /// @param indiceInformacao 0 (disciplina) ou 1 (professor).
    /// @return O nome da disciplina ou professor.
    function retornarDisciplinaOuProfessor(uint256 indiceDisciplina, uint256 indiceInformacao)
        external
        view
        returns (string memory)
    {
        require(indiceDisciplina < matrizesDiscProf.length, "Indice de disciplina invalido!");
        require(indiceInformacao < 2, "Indice de informacao invalido! Use 0 ou 1");
        return matrizesDiscProf[indiceDisciplina][indiceInformacao];
    }

    // ------------------------------
    // Funções Auxiliares para Consulta
    // ------------------------------

    /// @notice Retorna todas as disciplinas armazenadas.
    /// @return Um array com os nomes das disciplinas.
    function retornarTodasDisciplinas() external view returns (string[] memory) {
        return disciplinas;
    }

    /// @notice Retorna o número total de disciplinas armazenadas.
    /// @return A quantidade de disciplinas no array dinâmico.
    function totalDisciplinas() external view returns (uint256) {
        return disciplinas.length;
    }

    /// @notice Retorna o número total de combinações de disciplina e professor.
    /// @return A quantidade de pares disciplina-professor armazenados.
    function totalDisciplinaProfessor() external view returns (uint256) {
        return matrizesDiscProf.length;
    }
}
