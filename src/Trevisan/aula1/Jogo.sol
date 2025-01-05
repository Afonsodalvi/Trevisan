// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title Máquina de Pontos Competitiva
/// @dev Jogadores competem inserindo pontos, e o owner define o fim do jogo.
contract MaquinaDePontosCompetitiva {
    address public owner; // Endereço do professor (owner)
    mapping(address => uint256) public pontosJogadores; // Pontuação individual de cada jogador
    address[] public jogadores; // Lista de jogadores
    uint256 public somaTotalPontos; // Soma de todos os pontos inseridos
    bool public jogoAtivo; // Indica se o jogo está ativo

    // ------------------------------
    // Eventos
    // ------------------------------

    event JogoIniciado();
    event PontosInseridos(address indexed jogador, uint256 pontos);
    event JogoEncerrado(address vencedor, string mensagem);
    event JogoReiniciado();

    // ------------------------------
    // Modificadores
    // ------------------------------

    modifier apenasOwner() {
        require(msg.sender == owner, "Somente o owner pode executar esta acao!");
        _;
    }

    modifier jogoDeveEstarAtivo() {
        require(jogoAtivo, "O jogo nao esta ativo!");
        _;
    }

    // ------------------------------
    // Construtor
    // ------------------------------

    constructor() {
        owner = msg.sender; // Define o endereço do owner como o criador do contrato
        jogoAtivo = true; // O jogo começa ativo
        emit JogoIniciado();
    }

    // ------------------------------
    // Funções do Jogo
    // ------------------------------

    /// @notice Jogadores inserem pontos na competição.
    /// @param pontos Quantidade de pontos a ser adicionada.
    function inserirPontos(uint256 pontos) public jogoDeveEstarAtivo {
        require(pontos > 0, "Pontos devem ser maiores que zero!");
        if (pontosJogadores[msg.sender] == 0) {
            jogadores.push(msg.sender); // Adiciona à lista de jogadores apenas na primeira interação
        }

        pontosJogadores[msg.sender] += pontos; // Atualiza os pontos do jogador
        somaTotalPontos += pontos; // Atualiza a soma total
        emit PontosInseridos(msg.sender, pontos);
    }

    /// @notice O owner encerra o jogo e decide o vencedor.
    function encerrarJogo() public apenasOwner jogoDeveEstarAtivo {
        jogoAtivo = false;

        if (somaTotalPontos % 5 == 0) {
            emit JogoEncerrado(address(0), "Jogadores venceram! A soma e divisivel por 5!");
        } else {
            emit JogoEncerrado(owner, "Owner venceu! A soma nao e divisivel por 5!");
        }
    }

    /// @notice O owner pode reiniciar o jogo para uma nova rodada.
    function reiniciarJogo() public apenasOwner {
        require(!jogoAtivo, "O jogo ja esta ativo!");

        // Reseta todas as variáveis relacionadas ao jogo
        for (uint256 i = 0; i < jogadores.length; i++) {
            pontosJogadores[jogadores[i]] = 0; // Reseta a pontuação dos jogadores
        }
        delete jogadores; // Limpa a lista de jogadores
        somaTotalPontos = 0; // Reseta a soma total de pontos
        jogoAtivo = true; // Ativa o jogo novamente

        emit JogoReiniciado();
    }

    // ------------------------------
    // Funções de Consulta
    // ------------------------------

    /// @notice Obtém a pontuação de um jogador específico.
    /// @param jogador Endereço do jogador.
    /// @return A pontuação do jogador.
    function obterPontosJogador(address jogador) public view returns (uint256) {
        return pontosJogadores[jogador];
    }

    /// @notice Obtém a lista de jogadores que participaram.
    /// @return A lista de endereços dos jogadores.
    function obterJogadores() public view returns (address[] memory) {
        return jogadores;
    }
}
