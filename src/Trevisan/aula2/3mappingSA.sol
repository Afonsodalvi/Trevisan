// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Mapeamento com Structs Avançados
/// @dev Demonstra como usar mappings dentro de structs para organizar dados complexos.
contract MappingWithStructsArrays {
    // ------------------------------
    // Structs e Mappings
    // ------------------------------

    /// @notice Representa um usuário com saldo, status e notas de diferentes professores.
    struct Usuario {
        uint256 saldo; // Saldo do usuário
        bool ativo; // Indica se o usuário está ativo
        mapping(address => uint256) notasPorProfessor; // Notas atribuídas por diferentes professores
    }

    /// @notice Mapeia endereços para a estrutura do `Usuario`.
    mapping(address => Usuario) private usuarios;

    /// @notice Armazena a lista de endereços inseridos para facilitar consultas sequenciais.
    address[] private contas;

    // ------------------------------
    // Funções do Contrato
    // ------------------------------

    /// @notice Adiciona um novo usuário ao sistema.
    /// @param conta O endereço do usuário.
    /// @param saldoInicial O saldo inicial do usuário.
    function adicionarUsuario(address conta, uint256 saldoInicial) external {
        require(usuarios[conta].ativo == false, "Usuario ja cadastrado!");

        // Atualiza os dados do usuário
        Usuario storage usuario = usuarios[conta];
        usuario.saldo = saldoInicial;
        usuario.ativo = true;

        // Adiciona à lista de contas
        contas.push(conta);
    }

    /// @notice Atribui uma nota a um usuário, associada ao professor (chamador).
    /// @param aluno O endereço do aluno.
    /// @param nota A nota atribuída ao aluno.
    function atribuirNota(address aluno, uint256 nota) external {
        require(usuarios[aluno].ativo, "Usuario nao encontrado!");
        require(nota <= 100, "Nota maxima e 100!");

        // Adiciona a nota no mapping dentro do struct
        usuarios[aluno].notasPorProfessor[msg.sender] = nota;
    }

    /// @notice Consulta a nota de um aluno atribuída por um professor específico.
    /// @param aluno O endereço do aluno.
    /// @param professor O endereço do professor.
    /// @return A nota atribuída pelo professor.
    function consultarNota(address aluno, address professor) external view returns (uint256) {
        require(usuarios[aluno].ativo, "Usuario nao encontrado!");
        return usuarios[aluno].notasPorProfessor[professor];
    }

    /// @notice Atualiza o saldo de um usuário.
    /// @param conta O endereço do usuário.
    /// @param novoSaldo O novo saldo a ser definido.
    function atualizarSaldo(address conta, uint256 novoSaldo) external {
        require(usuarios[conta].ativo, "Usuario nao encontrado!");
        usuarios[conta].saldo = novoSaldo;
    }

    /// @notice Consulta o saldo de um usuário.
    /// @param conta O endereço do usuário.
    /// @return O saldo atual do usuário.
    function consultarSaldo(address conta) external view returns (uint256) {
        require(usuarios[conta].ativo, "Usuario nao encontrado!");
        return usuarios[conta].saldo;
    }

    /// @notice Retorna todos os endereços armazenados.
    /// @return A lista de endereços cadastrados.
    function listarContas() external view returns (address[] memory) {
        return contas;
    }
}
