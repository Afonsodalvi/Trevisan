// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Exemplos de Interfaces em Solidity
/// @dev Este exemplo demonstra o uso de interfaces para padronizar interações entre contratos.

/// ------------------------------
/// Contrato Base: Counter
/// ------------------------------

/// @notice Contrato que mantém um contador e permite incrementá-lo.
contract Counter {
    uint256 public count;

    /// @notice Incrementa o contador em 1.
    function increment() external {
        count += 1;
    }
}

/// ------------------------------
/// Interface para o Contrato Counter
/// ------------------------------

/// @notice Interface que padroniza as funções do contrato `Counter`.
interface ICounter {
    function count() external view returns (uint256); // Retorna o valor atual do contador.
    function increment() external; // Incrementa o contador.
}

/// ------------------------------
/// Contrato que Usa a Interface Counter
/// ------------------------------

/// @notice Contrato que interage com um contrato `Counter` usando sua interface.
contract MyContract {
    /// @notice Incrementa o contador de um contrato `Counter` fornecido.
    /// @param _counter O endereço do contrato `Counter`.
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment(); // Chama a função `increment` do contrato via interface.
    }

    /// @notice Obtém o valor atual do contador de um contrato `Counter`.
    /// @param _counter O endereço do contrato `Counter`.
    /// @return O valor atual do contador.
    function getCount(address _counter) external view returns (uint256) {
        return ICounter(_counter).count(); // Chama a função `count` do contrato via interface.
    }
}

/// ------------------------------
/// Exemplo com Uniswap
/// ------------------------------

/// @notice Interface da fábrica de pares da Uniswap.
interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address pair); // Retorna o endereço do par.
}

/// @notice Interface do par de tokens da Uniswap.
interface UniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast); // Retorna as reservas dos tokens.
}

/// @notice Contrato que interage com a Uniswap para obter reservas de tokens.
contract UniswapExample {
    address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f; // Endereço da fábrica da Uniswap.
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F; // Endereço do token DAI.
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; // Endereço do token WETH.

    /// @notice Obtém as reservas de DAI e WETH do par na Uniswap.
    /// @return As reservas de DAI e WETH.
    function getTokenReserves() external view returns (uint256, uint256) {
        address pair = UniswapV2Factory(factory).getPair(dai, weth); // Obtém o endereço do par DAI-WETH.
        (uint256 reserve0, uint256 reserve1,) = UniswapV2Pair(pair).getReserves(); // Obtém as reservas do par.
        return (reserve0, reserve1);
    }
}
