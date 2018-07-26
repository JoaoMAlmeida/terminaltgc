:- style_check(-singleton).
:- initialization (main).

%
% dynamic reiDaMontanha(Nome, Ataque, Vida, Poder, Bool).
% dynamic loboCeleste(Nome, Ataque, Vida, Poder, Bool).
% dynamic espectroNegro(Nome, Ataque, Vida, Poder, Bool).
% dynamic reiDaMontanha(Nome, Ataque, Vida, Poder, Bool).
% dynamic loboCeleste(Nome, Ataque, Vida, Poder, Bool).
% dynamic espectroNegro(Nome, Ataque, Vida, Poder, Bool).
% dynamic fortex(Nome, Ataque, Vida, Poder, Bool).
% dynamic ogroNegro(Nome, Ataque, Vida, Poder, Bool).
% dynamic dellOFort(Nome, Ataque, Vida, Poder, Bool).
% dynamic hPn01(Nome, Ataque, Vida, Poder, Bool).
% dynamic javas(Nome, Ataque, Vida, Poder, Bool).
% dynamic cPlusivel(Nome, Ataque, Vida, Poder, Bool).
% dynamic antonelaASereia(Nome, Ataque, Vida, Poder, Bool).
% dynamic nokiaTijolao(Nome, Ataque, Vida, Poder, Bool).
% dynamic zeDaPeixeira(Nome, Ataque, Vida, Poder, Bool).
% dynamic mosntroDonATAL(Nome, Ataque, Vida, Poder, Bool).
% dynamic ogroAlbino(Nome, Ataque, Vida, Poder, Bool).
% dynamic deadLine(Nome, Ataque, Vida, Poder, Bool).
% dynamic cortanaAAntipatica(Nome, Ataque, Vida, Poder, Bool).
% dynamic mercurioAlado(Nome, Ataque, Vida, Poder, Bool).
% dynamic ciriAEngracada(Nome, Ataque, Vida, Poder, Bool).
% dynamic cartaNula(Nome, Ataque, Vida, Poder, Bool).

% Cards = [
%   ["Rei da Montanha", 3, 2, "Iniciativa"],
%   ["Lobo Celeste", 2, 1, "Nenhum"],
%   ["Espectro Negro", 1, 1, "Ataque duplo"]
% ].

dynamic jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1).
dynamic jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2).

reiDaMontanhaMaker(1):- assert(reiDaMontanha("Rei da Montanha", 3, 2, "Iniciativa", true)).
loboCelesteMaker(1):- assert(loboCeleste("Lobo Celeste", 2, 1, "Nenhum", false)).
espectroNegroMaker(1):- assert(espectroNegro("Espectro Negro", 1, 1, "Ataque duplo", false)).

cardsMaker(1):- assert(cards([reiDaMontanha("Rei da Montanha", 3, 2, "Iniciativa", true),
                              loboCeleste("Lobo Celeste", 2, 1, "Nenhum", false),
                              espectroNegro("Espectro Negro", 1, 1, "Ataque duplo", false)])).

jogadorMaker(1):- assert(jogador1("Jogador1",10,3,3,true)).
jogadorMaker(2):- assert(jogador2("Jogador2",10,3,3,true)).

imprimeTopo():-
  write(Nome),nl,
  jogador1(_,VidaJogador1,_,_,_),
  jogador2(_,VidaJogador2,_,_,_),
  write("-----------------------------------------"),nl,
  write("Vida Jogador 1= "),write(VidaJogador1),write(" | "),write("Vida Jogador 2="),write(VidaJogador2),nl.


imprimeTab:-
  write("----------------Tabuleiro: Jogador 1----------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("----------------Tabuleiro: Jogador 2----------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl.


  maojogador(1):-
  write("---------------Mao: Jogador 1---------------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("-------------------------------------------"),nl,
  write("Turno: Jogador 1:"),nl.

  maojogador(2):-
  write("---------------Mao: Jogador 2---------------"),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("CartaJog 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("Carta 1: Nome:  Ataque: 0 Vida: 0 Poder: "),nl,
  write("-------------------------------------------"),nl,
  write("Turno: Jogador 2:"),nl.

  opcoes:-
  write("JC - Jogar Carta | AJ - Atacar Jogador | AC - Atacar Carta | FT - Finalizar Turno"),nl.


atacaJog(Jog, Dano) :-(
  (Jog =:= 2) ->  jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2),
  NovaVida is (VidaJogador2 - Dano),
  (retract(jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2))),
  (NovaVida > 0) -> assert(jogador2(NomeJogador2, NovaVida, CartasTabuleiro2, Mao2, JogarCarta2));

  (Jog =:= 1) ->  jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1),
  NovaVida is (VidaJogador1 - Dano),
  (retract(jogador2(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1))),
  (NovaVida > 0) -> assert(jogador1(NomeJogador1, NovaVida, CartasTabuleiro1, Mao1, JogarCarta1))).


turno(Jog) :-
  shell(clear), nl,
  imprimeTopo(),
  imprimeTab,
  write("PRINTA 1 AQUI ABAIXO:"),nl,
  write(Jog),nl,
  maojogador(Jog),
  opcoes.



main:-
  jogadorMaker(1),
  jogadorMaker(2),

  reiDaMontanhaMaker(1),
  loboCelesteMaker(1),
  espectroNegroMaker(1),


  imprimeTopo(),
  read(INPUT),
  turno(INPUT),
  main.
