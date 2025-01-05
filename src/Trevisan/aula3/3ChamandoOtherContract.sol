// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Exemplos de Interação entre Contratos
/// @dev Demonstra como chamar funções de outro contrato, passar parâmetros e enviar Ether.

/// @notice Contrato que será chamado (Callee).
contract Callee {
    uint256 public x; // Armazena um número.
    uint256 public value; // Armazena o valor enviado em wei.

    /// @notice Define o valor de `x`.
    /// @param _x O valor a ser armazenado em `x`.
    /// @return O valor de `x` após ser atualizado.
    function setX(uint256 _x) public returns (uint256) {
        x = _x; // Atualiza o valor de `x`.
        return x;
    }

    /// @notice Define o valor de `x` e registra o Ether enviado.
    /// @param _x O valor a ser armazenado em `x`.
    /// @return O valor de `x` e o Ether enviado.
    function setXandSendEther(uint256 _x) public payable returns (uint256, uint256) {
        x = _x; // Atualiza o valor de `x`.
        value = msg.value; // Registra o valor enviado.
        return (x, value);
    }
}

/// @notice Contrato que chama funções do contrato `Callee`.
contract CallerFunctions {
    /// @notice Chama a função `setX` do contrato `Callee`.
    /// @param _callee A instância do contrato `Callee`.
    /// @param _x O valor a ser definido em `x` no contrato `Callee`.
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x); // Chama a função `setX` do contrato `Callee`.
        require(x == _x, "Falha ao atualizar o valor de x"); // Validação opcional.
    }

    /// @notice Chama a função `setX` em um contrato `Callee` pelo endereço.
    /// @param _addr O endereço do contrato `Callee`.
    /// @param _x O valor a ser definido em `x`.
    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr); // Cria uma instância do contrato usando o endereço.
        uint256 x = callee.setX(_x); // Chama a função `setX`.
        require(x == _x, "Falha ao atualizar o valor de x"); // Validação opcional.
    }

    /// @notice Chama a função `setXandSendEther` do contrato `Callee` enviando Ether.
    /// @param _callee A instância do contrato `Callee`.
    /// @param _x O valor a ser definido em `x`.
    function setXandSendEther(Callee _callee, uint256 _x) public payable {
        require(msg.value > 0, "Deve enviar Ether!"); // Validação para garantir que Ether foi enviado.
        (uint256 x, uint256 value) = _callee.setXandSendEther{value: msg.value}(_x); // Chama a função e envia Ether.

        require(x == _x, "Falha ao atualizar o valor de x");
        require(value == msg.value, "O valor enviado nao corresponde!");
    }
}
