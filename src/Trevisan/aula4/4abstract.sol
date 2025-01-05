// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/// @title Exemplos de Contratos Abstratos em Solidity
/// @dev Este exemplo demonstra como usar contratos abstratos e suas funções.

/// ------------------------------
/// Contrato Abstrato
/// ------------------------------

/// @notice Contrato abstrato que define a estrutura e os comportamentos básicos de `Dados`.
/// @dev Não pode ser implantado diretamente e não exige que todas as funções sejam implementadas pelos contratos filhos.
abstract contract Dados {
    // ------------------------------
    // Variáveis
    // ------------------------------

    string public name; // Nome do indivíduo.
    uint256 public age; // Idade do indivíduo.

    // ------------------------------
    // Funções Virtuais
    // ------------------------------

    /// @notice Define o nome.
    /// @dev Deve ser implementado ou sobrescrito em um contrato derivado.
    /// @param _name O nome a ser definido.
    function setName(string memory _name) external virtual {
        name = _name;
    }

    /// @notice Define a idade.
    /// @dev Pode ser sobrescrita em um contrato derivado.
    /// @param _age A idade a ser definida.
    function setAge(uint256 _age) public virtual {
        age = _age;
    }

    /// @notice Retorna os dados armazenados (nome e idade).
    /// @return O nome e a idade.
    function getDados() public view virtual returns (string memory, uint256) {
        return (name, age);
    }
}

/// ------------------------------
/// Contrato Filho
/// ------------------------------

/// @notice Contrato que herda de `Dados` e adiciona funcionalidade extra.
contract SetInformation is Dados {
    // ------------------------------
    // Funções Específicas
    // ------------------------------

    /// @notice Define a idade diretamente no contrato base.
    /// @param _age A idade a ser definida.
    function setAgeInDados(uint256 _age) external {
        setAge(_age);
    }

    /// @notice Obtém os dados armazenados no contrato base.
    /// @return O nome e a idade.
    function getDadosFromAbstract() external view returns (string memory, uint256) {
        return getDados();
    }
}
