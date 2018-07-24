
dynamic reiDaMontanha(Nome, Ataque, Vida, Poder, Bool).
dynamic loboCeleste(Nome, Ataque, Vida, Poder, Bool).
dynamic espectroNegro(Nome, Ataque, Vida, Poder, Bool).
dynamic reiDaMontanha(Nome, Ataque, Vida, Poder, Bool).
dynamic loboCeleste(Nome, Ataque, Vida, Poder, Bool).
dynamic espectroNegro(Nome, Ataque, Vida, Poder, Bool).
dynamic fortex(Nome, Ataque, Vida, Poder, Bool).
dynamic ogroNegro(Nome, Ataque, Vida, Poder, Bool).
dynamic dellOFort(Nome, Ataque, Vida, Poder, Bool).
dynamic hPn01(Nome, Ataque, Vida, Poder, Bool).
dynamic javas(Nome, Ataque, Vida, Poder, Bool).
dynamic cPlusivel(Nome, Ataque, Vida, Poder, Bool).
dynamic antonelaASereia(Nome, Ataque, Vida, Poder, Bool).
dynamic nokiaTijolao(Nome, Ataque, Vida, Poder, Bool).
dynamic zeDaPeixeira(Nome, Ataque, Vida, Poder, Bool).
dynamic mosntroDonATAL(Nome, Ataque, Vida, Poder, Bool).
dynamic ogroAlbino(Nome, Ataque, Vida, Poder, Bool).
dynamic deadLine(Nome, Ataque, Vida, Poder, Bool).
dynamic cortanaAAntipatica(Nome, Ataque, Vida, Poder, Bool).
dynamic mercurioAlado(Nome, Ataque, Vida, Poder, Bool).
dynamic ciriAEngracada(Nome, Ataque, Vida, Poder, Bool).
dynamic cartaNula(Nome, Ataque, Vida, Poder, Bool).

dynamic jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1).
dynamic jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2).

dynamic cards([reiDaMontanha(),loboCeleste(),espectroNegro()]).

reiDaMontanhaMaker(1):- assert(reiDaMontanha("Rei da Montanha", 3, 2, "Iniciativa", true)).
loboCelesteMaker(1):- assert(loboCeleste("Lobo Celeste", 2, 1, "Nenhum", false)).
espectroNegroMaker(1):- assert(espectroNegro("Espectro Negro", 1, 1, "Ataque duplo", false)).

cardsMaker(1):- assert(cards([reiDaMontanha("Rei da Montanha", 3, 2, "Iniciativa", true),
                              loboCeleste("Lobo Celeste", 2, 1, "Nenhum", false),
                              espectroNegro("Espectro Negro", 1, 1, "Ataque duplo", false)])).

jogadorMaker(1):- assert(jogador1("Jogador1",10,3,3,true)).
jogadorMaker(2):- assert(jogador2("Jogador2",10,3,3,true)).


imprimeTopo():-
  jogador1(_,VidaJogador1,_,_,_),
  jogador2(_,VidaJogador2,_,_,_),
  write("-----------------------------------------"),nl,
  write("Vida Jogador 1= "),write(VidaJogador1),write(" | "),write("Vida Jogador 2="),write(VidaJogador2),nl.

:- set_prolog_flag(verbose, silent).
:- initialization main.

main :-
  shell(clear), nl,
  jogadorMaker(1),
  jogadorMaker(2),

  reiDaMontanhaMaker(1),
  loboCelesteMaker(1),
  espectroNegroMaker(1),

  cardsMaker(1),

  cards([Card1,Card2,Card3]),
  write(Card1),nl,
  write(Card2),nl,
  write(Card3),nl,


  imprimeTopo(),

  write("----------------Tabuleiro: Jogador 1----------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("----------------Tabuleiro: Jogador 2----------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("---------------Mao: Jogador 1---------------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("-------------------------------------------"),nl,
  write("Turno: Jogador 1:"),nl,
  write("Menssagem: "),nl,
  write("JC - Jogar Carta | AJ - Atacar Jogador | AC - Atacar Carta | FT - Finalizar Turno"),nl,
  write("aaabbb"),nl,
  read(Nome),nl,
  write(Nome),nl.
  % shell(clear),
  %
  % current_prolog_flag(argv, Argv),
  % format('Hello World, argv:~w\n', [Argv]),
  % halt(0).
