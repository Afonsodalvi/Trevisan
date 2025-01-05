// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Exemplos de Uso de Libraries em Solidity
/// @dev Este contrato demonstra como usar a biblioteca `Math` para operações matemáticas seguras.

/// ------------------------------
/// Definição da Biblioteca Math
/// ------------------------------

/// @notice Biblioteca contendo funções matemáticas seguras e utilitárias.
library Math {
    /// @notice Tenta somar dois números sem causar overflow.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return Sucesso da operação e o resultado.
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /// @notice Tenta subtrair dois números sem causar underflow.
    /// @param a Minuendo.
    /// @param b Subtraendo.
    /// @return Sucesso da operação e o resultado.
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /// @notice Tenta multiplicar dois números sem causar overflow.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return Sucesso da operação e o resultado.
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /// @notice Tenta dividir dois números, verificando divisão por zero.
    /// @param a Dividendo.
    /// @param b Divisor.
    /// @return Sucesso da operação e o resultado.
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /// @notice Retorna o maior entre dois números.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return O maior número.
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /// @notice Retorna o menor entre dois números.
    /// @param a Primeiro número.
    /// @param b Segundo número.
    /// @return O menor número.
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
}

/// ------------------------------
/// Contrato que Usa a Biblioteca
/// ------------------------------

contract TestLibrary {
    /// @notice Declara o uso da biblioteca Math para tipos `uint256`.
    using Math for uint256;

    /// @notice Um valor armazenado para demonstração.
    uint256 public value = 10;

    /// @notice Testa a divisão de dois números usando a biblioteca Math.
    /// @param a Dividendo.
    /// @param b Divisor.
    /// @return Sucesso da operação e o resultado.
    function testDiv(uint256 a, uint256 b) external pure returns (bool, uint256) {
        return Math.tryDiv(a, b); // Chamando diretamente a função da biblioteca.
    }

    /// @notice Testa a função `min` usando a sintaxe da biblioteca `using for`.
    /// @param _value Valor a ser comparado com `value`.
    /// @return O menor valor entre `value` e `_value`.
    function testMin(uint256 _value) external view returns (uint256) {
        return value.min(_value); // Usando a biblioteca diretamente em `uint256`.
    }

    /// @notice Testa a função `max` usando a sintaxe da biblioteca `using for`.
    /// @param _value Valor a ser comparado com `value`.
    /// @return O maior valor entre `value` e `_value`.
    function testMax(uint256 _value) external view returns (uint256) {
        return value.max(_value); // Usando a biblioteca diretamente em `uint256`.
    }
}
