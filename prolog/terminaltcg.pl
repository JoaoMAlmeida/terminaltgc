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
                              espectroNegro("Espectro Negro", 1, 1, "Ataque duplo", false),
                              cartaNula("", 0, 0, "", false)])).

jogadorMaker(1):- assert(jogador1("Jogador1",10,3,3,true)).
jogadorMaker(2):- assert(jogador2("Jogador2",10,3,3,true)).

imprimeTopo():-
  jogador1(_,VidaJogador1,_,_,_),
  jogador2(_,VidaJogador2,_,_,_),
  write("-----------------------------------------"),nl,
  write("Vida Jogador 1= "),write(VidaJogador1),write(" | "),write("Vida Jogador 2="),write(VidaJogador2),nl.


imprimeEmelento(I,Element):-
  nth0(I,Element,Att),
  write(Att).

imprimeTab(CardsTab):-
  nth0(0,CardsTab,Card),
  nth0(1,CardsTab,Card1),
  nth0(2,CardsTab,Card2),
  nth0(3,CardsTab,Card3),
  nth0(4,CardsTab,Card4),
  nth0(5,CardsTab,Card5),
  write("----------------Tabuleiro: Jogador 1----------"),nl,
  write("Carta 1: Nome: ") ,imprimeEmelento(0,Card), write(" Ataque: "),imprimeEmelento(1,Card),write(" Vida: "),imprimeEmelento(2,Card),write(" Poder: "),imprimeEmelento(3,Card),nl,
  write("Carta 2: Nome: ") ,imprimeEmelento(0,Card1), write(" Ataque: "),imprimeEmelento(1,Card1),write(" Vida: "),imprimeEmelento(2,Card1),write(" Poder: "),imprimeEmelento(3,Card1),nl,
  write("Carta 3: Nome: ") ,imprimeEmelento(0,Card2), write(" Ataque: "),imprimeEmelento(1,Card2),write(" Vida: "),imprimeEmelento(2,Card2),write(" Poder: "),imprimeEmelento(3,Card2),nl,
  write("----------------Tabuleiro: Jogador 2----------"),nl,
  write("Carta 1: Nome: ") ,imprimeEmelento(0,Card3), write(" Ataque: "),imprimeEmelento(1,Card3),write(" Vida: "),imprimeEmelento(2,Card3),write(" Poder: "),imprimeEmelento(3,Card3),nl,
  write("Carta 2: Nome: ") ,imprimeEmelento(0,Card4), write(" Ataque: "),imprimeEmelento(1,Card4),write(" Vida: "),imprimeEmelento(2,Card4),write(" Poder: "),imprimeEmelento(3,Card4),nl,
  write("Carta 3: Nome: ") ,imprimeEmelento(0,Card5), write(" Ataque: "),imprimeEmelento(1,Card5),write(" Vida: "),imprimeEmelento(2,Card5),write(" Poder: "),imprimeEmelento(3,Card5),nl.


  maojogador(1, CardsMao):-
  nth0(0,CardsMao,Card),
  nth0(1,CardsMao,Card1),
  nth0(2,CardsMao,Card2),
  write("---------------Mao: Jogador 1---------------"),nl,
  write("Carta 1: Nome: ") ,imprimeEmelento(0,Card), write(" Ataque: "),imprimeEmelento(1,Card),write(" Vida: "),imprimeEmelento(2,Card),write(" Poder: "),imprimeEmelento(3,Card),nl,
  write("Carta 2: Nome: ") ,imprimeEmelento(0,Card1), write(" Ataque: "),imprimeEmelento(1,Card1),write(" Vida: "),imprimeEmelento(2,Card1),write(" Poder: "),imprimeEmelento(3,Card1),nl,
  write("Carta 3: Nome: ") ,imprimeEmelento(0,Card2), write(" Ataque: "),imprimeEmelento(1,Card2),write(" Vida: "),imprimeEmelento(2,Card2),write(" Poder: "),imprimeEmelento(3,Card2),nl,
  write("-------------------------------------------"),nl,
  write("Turno: Jogador 1:"),nl.

  maojogador(2, CardsMao):-
  nth0(3,CardsMao,Card),
  nth0(4,CardsMao,Card1),
  nth0(5,CardsMao,Card2),
  write("---------------Mao: Jogador 2---------------"),nl,
  write("Carta 1: Nome: ") ,imprimeEmelento(0,Card), write(" Ataque: "),imprimeEmelento(1,Card),write(" Vida: "),imprimeEmelento(2,Card),write(" Poder: "),imprimeEmelento(3,Card),nl,
  write("Carta 2: Nome: ") ,imprimeEmelento(0,Card1), write(" Ataque: "),imprimeEmelento(1,Card1),write(" Vida: "),imprimeEmelento(2,Card1),write(" Poder: "),imprimeEmelento(3,Card1),nl,
  write("Carta 3: Nome: ") ,imprimeEmelento(0,Card2), write(" Ataque: "),imprimeEmelento(1,Card2),write(" Vida: "),imprimeEmelento(2,Card2),write(" Poder: "),imprimeEmelento(3,Card2),nl,
  write("-------------------------------------------"),nl,
  write("Turno: Jogador 2:"),nl.

  menu(Jog, CardsTab, CardsMao):-
  write("1 - Jogar Carta | 2 - Atacar Jogador | 3 - Atacar Carta | 4 - Finalizar Turno"),nl,
  read(Opcao),
  opcoes(Opcao, Jog, CardsTab, CardsMao).

opcoes(1, Jog, CardsTab, CardsMao):-
write("JOGANDO CARTA"),nl.

opcoes(2, Jog, CardsTab, CardsMao):-
write("ATACANDO JOGADOR"),nl.

opcoes(3, Jog, CardsTab, CardsMao):-
write("ATACANDO CARTA"),nl.

opcoes(4, Jog, CardsTab, CardsMao):-
  (((Jog =:= 1) -> turno(2, CardsTab, CardsMao));
  turno(1, CardsTab, CardsMao)).


atacaJog(Jog, Dano) :-(
  (Jog =:= 2) ->  jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2),
  NovaVida is (VidaJogador2 - Dano),
  (retract(jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2))),
  (NovaVida > 0) -> assert(jogador2(NomeJogador2, NovaVida, CartasTabuleiro2, Mao2, JogarCarta2));

  (Jog =:= 1) ->  jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1),
  NovaVida is (VidaJogador1 - Dano),
  (retract(jogador2(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1))),
  (NovaVida > 0) -> assert(jogador1(NomeJogador1, NovaVida, CartasTabuleiro1, Mao1, JogarCarta1))).


turno(Jog,CardsTab, CardsMao) :-
  shell(clear), nl,
  imprimeTopo(),
  imprimeTab(CardsTab),
  maojogador(Jog, CardsMao),
  menu(Jog, CardsTab, CardsMao).



main:-
  jogadorMaker(1),
  jogadorMaker(2),

  reiDaMontanhaMaker(1),
  loboCelesteMaker(1),
  espectroNegroMaker(1),

  cardsMaker(1),
  CardsTab =[
    ["Rei da Montanha", 3, 2, "Iniciativa"],
    ["Lobo Celeste", 2, 1, "Nenhum"],
    ["Espectro Negro", 1, 1, "Ataque duplo"],
    ["", 0, 0, "", false],
    ["", 0, 0, "", false],
    ["", 0, 0, "", false]],nl,

  CardsMao = [
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false]
  ],

  imprimeTopo(),
  read(INPUT),
  turno(INPUT,CardsTab, CardsMao),
  main.
