// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Exercício Didático: If, Else e For Loop no Solidity
/// @dev Este contrato demonstra o uso de if/else para decisões lógicas e loops for para repetição.
contract IfElseAndForExample {
    /// @notice Determina o tipo de número fornecido.
    /// @param _number O número a ser avaliado.
    /// @return Um texto que descreve se o número é positivo, negativo ou zero.
    function checkNumber(int256 _number) public pure returns (string memory) {
        if (_number > 0) {
            return "O numero e positivo.";
        } else if (_number < 0) {
            return "O numero e negativo.";
        } else {
            return "O numero e zero.";
        }
    }

    /// @notice Avalia a idade fornecida para determinar o grupo de idade.
    /// @param _age A idade a ser avaliada.
    /// @return Um texto que descreve o grupo de idade.
    function checkAge(uint256 _age) public pure returns (string memory) {
        if (_age < 13) {
            return "Crianca.";
        } else if (_age < 20) {
            return "Adolescente.";
        } else if (_age < 60) {
            return "Adulto.";
        } else {
            return "Idoso.";
        }
    }

    /// @notice Avalia um número para determinar se é par ou ímpar.
    /// @param _number O número a ser avaliado.
    /// @return Um texto que descreve se o número é par ou ímpar.
    function checkEvenOdd(uint256 _number) public pure returns (string memory) {
        if (_number % 2 == 0) {
            return "O numero e par.";
        } else {
            return "O numero e impar.";
        }
    }

    /// ------------------------------
    /// Exemplos com For Loop
    /// ------------------------------

    /// @notice Soma os primeiros `n` números inteiros positivos.
    /// @param n O número até o qual a soma será calculada.
    /// @return A soma dos números de 1 a `n`.
    function sumOfNumbers(uint256 n) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 1; i <= n; i++) {
            sum += i; // Adiciona o valor de `i` à soma total.
        }
        return sum;
    }

    /*
    Como funciona?

    Imagine que você tem uma pilha de blocos numerados: 1, 2, 3, 4, 5... 
    até o número que você escolher. Que seria o 'n' inputado na função.
    A função pega esses blocos e soma todos eles.

    Exemplo para uma criança:

    Vamos dizer que você tem os números de 1 a 3 (valor de 'n' seria o 3):

    Primeiro, começamos com 0 (porque ainda não somamos nada).
    Depois somamos:
    0 + 1 = 1 (agora temos 1).
    1 + 2 = 3 (agora temos 3).
    3 + 3 = 6 (agora temos 6).
    A soma final de 1, 2 e 3 é 6!

    Imagina que você tem uma caixa. 
    Cada vez que colocamos um blocos nela, contamos o total de blocos. 
    No final, sabemos quantos blocos temos somados.
    */

    /// @notice Gera a soma de todos os números pares até `n`.
    /// @param n O número até o qual os pares serão somados.
    /// @return A soma de todos os números pares até `n`.
    function sumOfEvenNumbers(uint256 n) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 1; i <= n; i++) {
            if (i % 2 == 0) {
                sum += i; // Adiciona o número par à soma.
            }
        }
        return sum;
    }

    /*
    Como funciona?

    Agora imagine que só queremos somar os números pares 
    (números que você pode dividir em dois grupos iguais, como 2, 4, 6...). 
    A função olha para cada número e, se ele for par, adiciona à soma.

    Exemplo:

    Vamos dizer que você tem os números de 1 a 6:

    Primeiro, começamos com 0.
    Depois olhamos para cada número:
    O número 1 não é par (não fazemos nada).
    O número 2 é par: 0 + 2 = 2.
    O número 3 não é par (não fazemos nada).
    O número 4 é par: 2 + 4 = 6.
    O número 5 não é par (não fazemos nada).
    O número 6 é par: 6 + 6 = 12.
    A soma final dos números pares (2, 4 e 6) é 12!

    Imagina que estamos jogando um jogo. 
    Cada vez que vemos um número que pode ser dividido em dois grupos iguais (número par), 
    ganhamos pontos e adicionamos na nossa pontuação final.
    */

    /// @notice Cria uma lista de números de 1 até `n` como exemplo de loop.
    /// @param n O número até o qual a lista será criada.
    /// @return Um array contendo os números de 1 a `n`.
    function createNumberList(uint256 n) public pure returns (uint256[] memory) {
        uint256[] memory numbers = new uint256[](n); // Cria um array com tamanho `n`.
        for (uint256 i = 0; i < n; i++) {
            numbers[i] = i + 1; // Preenche o array com números de 1 a `n`.
        }
        return numbers;
    }
}

/*
    Explicacao

    Lista de Números (createNumberList):
    Cria um array dinâmico para armazenar números de 1 a n.
    Demonstra como inicializar e preencher arrays em Solidity.
    */
