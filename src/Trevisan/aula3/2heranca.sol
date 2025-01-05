// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exemplos de Herança em Solidity
/// @dev Este contrato demonstra herança múltipla, construtores e substituições de funções.

/// ------------------------------
/// Contratos Base para Demonstração
/// ------------------------------

/// @notice Contrato base `X`, armazena um nome.
contract X {
    string public name;

    /// @notice Construtor que inicializa o nome.
    /// @param _name Nome a ser armazenado.
    constructor(string memory _name) {
        name = _name;
    }
}

/// @notice Contrato base `Y`, armazena um texto.
contract Y {
    string public text;

    /// @notice Construtor que inicializa o texto.
    /// @param _text Texto a ser armazenado.
    constructor(string memory _text) {
        text = _text;
    }
}

/// ------------------------------
/// Contratos Derivados com Inicialização
/// ------------------------------

/// @notice Contrato `B` inicializa diretamente os contratos base com valores fixos.
contract B is X("Input to X"), Y("Input to Y") {}

/// @notice Contrato `C` permite passar parâmetros no construtor.
contract C is X, Y {
    /// @notice Inicializa os contratos base `X` e `Y` com valores fornecidos.
    /// @param _name Nome a ser armazenado em `X`.
    /// @param _text Texto a ser armazenado em `Y`.
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

/// @notice Contrato `D` demonstra a ordem de chamada dos construtores.
contract D is X, Y {
    /// @notice Inicializa os contratos base com mensagens fixas.
    /// @dev Construtores dos contratos base são chamados na ordem de herança, independentemente da ordem no código.
    constructor() X("X foi chamado") Y("Y foi chamado") {}
}

/// ------------------------------
/// Demonstração de Substituições de Funções
/// ------------------------------

/// @notice Contrato base `A` com uma função `foo` que pode ser sobrescrita.
contract A {
    /// @notice Função virtual que retorna "A".
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

/// @notice Contrato `F` que sobrescreve a função `foo` de `A`.
contract F is A {
    /// @notice Retorna "F".
    function foo() public pure virtual override returns (string memory) {
        return "F";
    }
}

/// @notice Contrato `O` que sobrescreve a função `foo` de `A`.
contract O is A {
    /// @notice Retorna "O".
    function foo() public pure virtual override returns (string memory) {
        return "O";
    }
}

/// @notice Contrato `J` combina `F` e `O` e define qual implementação de `foo` será usada.
contract J is F, O {
    /// @notice Sobrescreve `foo` de `F` e `O`, retornando o último na ordem da herança.
    /// @dev Ordem importa: `O` é o contrato mais à direita e sua implementação será usada.
    function foo() public pure override(F, O) returns (string memory) {
        return super.foo();
    }
}

/// @notice Contrato `Z` combina `O` e `F` com ordem invertida.
contract Z is O, F {
    /// @notice Sobrescreve `foo` de `O` e `F`, retornando "F".
    function foo() public pure override(O, F) returns (string memory) {
        return super.foo();
    }
}

/// @notice Contrato `L` demonstra a importância da ordem de herança.
contract L is A, F {
    /// @notice Sobrescreve `foo` de `A` e `F`.
    /// @dev Ordem deve ser da base para a derivada: `A` antes de `F`.
    function foo() public pure override(A, F) returns (string memory) {
        return super.foo();
    }
}
