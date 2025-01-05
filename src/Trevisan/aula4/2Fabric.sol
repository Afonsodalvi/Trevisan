// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Fabricação de Contratos com Solidity
/// @dev Este exemplo demonstra como criar novos contratos dinamicamente usando um contrato fábrica.

/// @notice Representa um contrato de Carro.
contract Car {
    address public owner; // Proprietário do carro.
    string public model; // Modelo do carro.
    address public carAddr; // Endereço do contrato Car.

    /// @notice Construtor que inicializa o contrato Car.
    /// @param _owner Endereço do proprietário do carro.
    /// @param _model Modelo do carro.
    constructor(address _owner, string memory _model) payable {
        owner = _owner; // Define o proprietário.
        model = _model; // Define o modelo do carro.
        carAddr = address(this); // Armazena o endereço do contrato.
    }
}

/// @notice Contrato fábrica para criar e gerenciar contratos `Car`.
contract CarFactory {
    /// @notice Lista de contratos Car criados.
    Car[] public cars;

    // ------------------------------
    // Funções de Criação de Contratos
    // ------------------------------

    /// @notice Cria um novo contrato Car.
    /// @param _owner Endereço do proprietário do carro.
    /// @param _model Modelo do carro.
    function create(address _owner, string memory _model) public {
        // Cria um novo contrato Car e armazena a referência.
        Car car = new Car(_owner, _model);
        cars.push(car); // Adiciona o contrato à lista.
    }

    /// @notice Cria um contrato Car e transfere Ether para ele.
    /// @param _owner Endereço do proprietário do carro.
    /// @param _model Modelo do carro.
    function createAndSendEther(address _owner, string memory _model) public payable {
        require(msg.value > 0, "Deve enviar Ether!");
        // Cria o contrato Car e transfere o Ether enviado.
        Car car = (new Car){value: msg.value}(_owner, _model);
        cars.push(car); // Adiciona o contrato à lista.
    }

    // ------------------------------
    // Funções Auxiliares
    // ------------------------------

    /// @notice Consulta informações de um contrato Car criado.
    /// @param _index Índice do contrato Car na lista.
    /// @return owner Proprietário do carro.
    /// @return model Modelo do carro.
    /// @return carAddr Endereço do contrato Car.
    /// @return balance Saldo de Ether no contrato Car.
    function getCar(uint256 _index)
        public
        view
        returns (address owner, string memory model, address carAddr, uint256 balance)
    {
        require(_index < cars.length, "Indice invalido!");
        Car car = cars[_index]; // Obtém o contrato Car pelo índice.
        return (car.owner(), car.model(), car.carAddr(), address(car).balance);
    }

    /// @notice Retorna a quantidade de carros criados.
    /// @return O número total de contratos Car criados.
    function getTotalCars() public view returns (uint256) {
        return cars.length;
    }
}
