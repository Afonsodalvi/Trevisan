// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exemplos de Funções em Solidity
/// @dev Este contrato demonstra o uso de funções `external`, `internal`, `public`, `view`, `pure` e `payable`.
contract FuncoesExemplo {
    // ------------------------------
    // Variáveis
    // ------------------------------

    /// @notice Armazena um número dividido por dois.
    uint256 public numero;

    /// @notice Armazena um nome.
    string public nome;

    /// @notice Armazena uma mensagem.
    string public mensagem;

    /// @dev Variável privada para armazenar um valor (não visível fora do contrato).
    uint256 private valor;

    // ------------------------------
    // Funções para Demonstrar os Modificadores
    // ------------------------------

    /// @notice Define o nome e atualiza o número.
    /// @dev Função `external` só pode ser chamada externamente (por EOAs ou outros contratos).
    /// @param _meunome O nome a ser definido.
    /// @param _numero O número que será dividido por dois.
    function setNomeNum(string memory _meunome, uint256 _numero) external {
        nome = _meunome; // Atualiza o nome
        subNum(_numero); // Chama a função interna
        setMsg("chamou pelo contrato"); // Atualiza a mensagem usando a função pública
    }

    /// @notice Divide um número por dois e atualiza a variável `numero`.
    /// @dev Função `internal` só pode ser chamada dentro deste contrato ou por contratos derivados.
    /// @param _numeroSub O número a ser dividido.
    function subNum(uint256 _numeroSub) internal {
        uint256 subNumero = _numeroSub / 2;
        numero = subNumero; // Atualiza a variável global
    }

    /// @notice Define uma mensagem.
    /// @dev Função `public` pode ser chamada internamente ou externamente.
    /// @param _msg A mensagem a ser definida.
    function setMsg(string memory _msg) public {
        mensagem = _msg; // Atualiza a mensagem
    }

    // ------------------------------
    // Funções com Modificadores Específicos
    // ------------------------------

    /// @notice Define um valor.
    /// @dev Função `external` armazena o valor passado na variável privada `valor`.
    /// @param _valor O valor a ser armazenado.
    function setValor(uint256 _valor) external {
        valor = _valor;
    }

    /// @notice Retorna o valor armazenado.
    /// @dev Função `view` só pode ler o estado do contrato, sem modificá-lo.
    /// @return O valor armazenado.
    function getValor() external view returns (uint256) {
        return valor;
    }

    /// @notice Multiplica dois números sem acessar o estado do contrato.
    /// @dev Função `pure` não lê nem altera o estado do contrato.
    /// @param x O primeiro número.
    /// @param y O segundo número.
    /// @return O resultado da multiplicação.
    function multiplicar(uint256 x, uint256 y) external pure returns (uint256) {
        return x * y;
    }

    /// @notice Permite enviar Ether para o contrato.
    /// @dev Função `payable` permite que a função receba Ether.
    function payEther() external payable {}

    /// @notice Retorna o saldo do contrato em Ether.
    /// @dev Função `view` usada para verificar o saldo sem alterar o estado.
    /// @return O saldo do contrato em wei.
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
