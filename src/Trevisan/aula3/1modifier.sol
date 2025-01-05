// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exemplos de Modifiers em Solidity
/// @dev Este contrato demonstra o uso de modifiers para controle de acesso e prevenção de reentrância.
contract FuncoesModifier {
    // ------------------------------
    // Variáveis
    // ------------------------------

    /// @notice Endereço do proprietário do contrato.
    address public owner;

    /// @notice Valor armazenado para demonstração de modificadores.
    uint256 public x = 10;

    /// @notice Booleano usado para evitar reentrância.
    bool public locked;

    // ------------------------------
    // Construtor
    // ------------------------------

    /// @notice Define o deployer do contrato como o proprietário.
    constructor() {
        owner = msg.sender; // Quem realiza o deploy se torna o dono do contrato.
    }

    // ------------------------------
    // Modifiers
    // ------------------------------

    /// @notice Restrição para permitir apenas que o proprietário chame a função.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    /// @notice Valida se o endereço fornecido não é o endereço zero.
    /// @param _addr O endereço a ser validado.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Invalid address");
        _;
    }

    /// @notice Impede que uma função seja chamada enquanto já está em execução.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    // ------------------------------
    // Funções com Modifiers
    // ------------------------------

    /// @notice Permite que o proprietário mude o endereço de propriedade.
    /// @dev Usa os modificadores `onlyOwner` e `validAddress` para controle de acesso e validação.
    /// @param _newOwner O novo endereço do proprietário.
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    /// @notice Realiza uma operação de decremento, protegida contra reentrância.
    /// @dev A função chama a si mesma (recursiva) até que `i` seja 1.
    /// @param i O valor a ser subtraído recursivamente.
    function decrement(uint256 i) public noReentrancy {
        x -= i; // Subtrai `i` do valor atual de `x`.

        if (i > 1) {
            decrement(i - 1); // Chama recursivamente a função com `i - 1`.
        }
    }
}
