// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/// @title Exemplos de Operadores em Solidity
/// @dev Este contrato demonstra o uso de operadores aritméticos, lógicos e relacionais.

contract ExemploOperadores {
    /// @notice Armazena um valor global.
    uint256 private valor;

    // ------------------------------
    // Funções com operadores aritméticos
    // ------------------------------

    /// @notice Calcula a média de dois números.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return A média dos dois números.
    function calcularMedia(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 media = (a + b) / 2; // Operador de soma e divisão.
        return media;
    }

    /// @notice Calcula o dobro da soma de dois números.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return O resultado da soma multiplicado por 2.
    function calcularMultiplicar(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 multiplicar = (a + b) * 2; // Soma e multiplicação.
        return multiplicar;
    }

    // ------------------------------
    // Funções com operadores lógicos
    // ------------------------------

    /// @notice Verifica se ambas as condições são verdadeiras (AND lógico).
    /// @param a Primeira condição.
    /// @param b Segunda condição.
    /// @return `true` se ambas forem verdadeiras, caso contrário, `false`.
    function verificarVerdadeiro(bool a, bool b) public pure returns (bool) {
        return a && b; // AND lógico: verdadeiro apenas se ambos forem verdadeiros.
    }

    /// @notice Verifica se pelo menos uma condição é verdadeira (OR lógico).
    /// @param a Primeira condição.
    /// @param b Segunda condição.
    /// @return `true` se pelo menos uma for verdadeira, caso contrário, `false`.
    function verificarCondicional(bool a, bool b) public pure returns (bool) {
        return a || b; // OR lógico: verdadeiro se pelo menos um for verdadeiro.
    }

    // ------------------------------
    // Funções com operadores relacionais
    // ------------------------------

    /// @notice Verifica se o primeiro número é maior que o segundo.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return `true` se `a` for maior que `b`, caso contrário, `false`.
    function verificarMaior(uint256 a, uint256 b) public pure returns (bool) {
        return a > b; // Retorna verdadeiro se "a" for maior que "b".
    }

    /// @notice Verifica se dois números são iguais.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return `true` se forem iguais, caso contrário, `false`.
    function verificarSeIgual(uint256 a, uint256 b) public pure returns (bool) {
        return a == b; // Retorna verdadeiro se "a" for igual a "b".
    }

    /// @notice Verifica se dois números são diferentes.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return `true` se forem diferentes, caso contrário, `false`.
    function verificarSeDiferente(uint256 a, uint256 b) public pure returns (bool) {
        return a != b; // Retorna verdadeiro se "a" for diferente de "b".
    }

    // ------------------------------
    // Funções para manipular a variável global
    // ------------------------------

    /// @notice Define o valor global com base em uma condição.
    /// @param novoValor O novo valor a ser armazenado.
    /// @dev Se o valor for menor que 10, ele será armazenado como zero.
    function setValor(uint256 novoValor) public {
        if (novoValor >= 10) {
            valor = novoValor; // Atualiza o valor se for maior ou igual a 10.
        } else {
            valor = 0; // Define como 0 caso contrário.
        }
    }

    /// @notice Obtém o valor global armazenado.
    /// @return O valor atualmente armazenado.
    function getValor() public view returns (uint256) {
        return valor; // Retorna o valor armazenado.
    }
}
