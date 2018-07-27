:- style_check(-singleton).
:- initialization (main).

dynamic jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1).
dynamic jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2).

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

menu(Jog,Cards, CardsTab, CardsMao):-
write("1 - Jogar Carta | 2 - Atacar Jogador | 3 - Atacar Carta | 4 - Finalizar Turno"),nl,
read(Opcao),
opcoes(Opcao, Jog,Cards, CardsTab, CardsMao).

opcoes(1, Jog,Cards, CardsTab, CardsMao):-
  write("Escolha uma carta (1, 2 ou 3)"), nl,
  read(CardIndex),
  CardIndex1 is CardIndex - 1,
  CardIndex2 is (CardIndex + 2),
  ((Jog =:= 1 -> jogaCarta(Jog, Cards, CardsTab, CardsMao, CardIndex1));
  jogaCarta(Jog, Cards, CardsTab, CardsMao, CardIndex2)).

opcoes(2, Jog,Cards, CardsTab, CardsMao):-
write("ATACANDO JOGADOR"),nl.

opcoes(3, Jog,Cards, CardsTab, CardsMao):-
write("ATACANDO CARTA"),nl.

opcoes(4, Jog,Cards, CardsTab, CardsMao):-
  (((Jog =:= 1) -> setMaoJogador(2,Cards,CardsTab));
  setMaoJogador(1,Cards,CardsTab)).

atacaJog(Jog, Dano) :-(
  (Jog =:= 2) ->  jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2),
  NovaVida is (VidaJogador2 - Dano),
  (retract(jogador2(NomeJogador2, VidaJogador2, CartasTabuleiro2, Mao2, JogarCarta2))),
  (NovaVida > 0) -> assert(jogador2(NomeJogador2, NovaVida, CartasTabuleiro2, Mao2, JogarCarta2));

  (Jog =:= 1) ->  jogador1(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1),
  NovaVida is (VidaJogador1 - Dano),
  (retract(jogador2(NomeJogador1, VidaJogador1, CartasTabuleiro1, Mao1, JogarCarta1))),
  (NovaVida > 0) -> assert(jogador1(NomeJogador1, NovaVida, CartasTabuleiro1, Mao1, JogarCarta1))).

jogaCarta(Jog, Cards, CardsTab, CardsMao, CardIndex) :-
  CartaNula = ["", 0, 0, "", false],
  write("entrei"), nl, write(CardIndex), nl,
  ((Jog =:= 1 -> ((nth0(0,CardsTab,Card1),
  write(Card1), nl,
  cartasIguais(CartaNula, Card1),
  nth0(CardIndex,CardsMao,CardMao1),
  swapElem(0, CardMao1, CardsTab, ResultTab1),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao1),
  turno(Jog, Cards, ResultTab1, ResultMao1));
  (nth0(1,CardsTab,Card2),
  cartasIguais(CartaNula, Card2),
  nth0(CardIndex,CardsMao,CardMao2),
  swapElem(1, CardMao2, CardsTab, ResultTab2),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao2),
  turno(1, Cards, ResultTab2, ResultMao2));
  (nth0(2,CardsTab,Card3),
  cartasIguais(CartaNula, Card3),
  nth0(CardIndex,CardsMao,CardMao3),
  swapElem(2, CardMao3, CardsTab, ResultTab3),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao3),
  turno(1, Cards, ResultTab3, ResultMao3))));
  write(CardsMao),
  (Jog =:= 2 -> ((nth0(3,CardsTab,Card4),
  cartasIguais(CartaNula, Card4),
  nth0(CardIndex,CardsMao,CardMao4),
  swapElem(3, CardMao4, CardsTab, ResultTab4),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao4),
  turno(2, Cards, ResultTab4, ResultMao4));
  (nth0(4,CardsTab,Card5),
  cartasIguais(CartaNula, Card5),
  nth0(CardIndex,CardsMao,CardMao5),
  swapElem(4, CardMao5, CardsTab, ResultTab5),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao5),
  turno(2, Cards, ResultTab5, ResultMao5));
  (nth0(5,CardsTab,Card6),
  cartasIguais(CartaNula, Card6),
  nth0(CardIndex,CardsMao,CardMao6),
  swapElem(5, CardMao6, CardsTab, ResultTab6),
  swapElem(CardIndex, CartaNula, CardsMao, ResultMao6),
  turno(2, Cards, ResultTab6, ResultMao6)))));
  turno(Jog, Cards, CardsTab, CardsMao).

setMaoJogador(Jog,Cards,CardsTab):-
  random(0,19,X),nth0(X,Cards,Card1),
  random(0,19,Y),nth0(Y,Cards,Card2),
  random(0,19,Z),nth0(Z,Cards,Card3),
  random(0,19,A),nth0(A,Cards,Card4),
  random(0,19,B),nth0(B,Cards,Card5),
  random(0,19,C),nth0(C,Cards,Card6),

  % write(Card1).
  CardsMao = [
      Card1,
      Card2,
      Card3,
      Card4,
      Card5,
      Card6
  ],

  turno(Jog,Cards,CardsTab, CardsMao).

turno(Jog,Cards,CardsTab, CardsMao) :-
  shell(clear), nl,
  imprimeTopo(),
  imprimeTab(CardsTab),
  maojogador(Jog, CardsMao),
  menu(Jog,Cards, CardsTab, CardsMao).

main:-
  jogadorMaker(1),
  jogadorMaker(2),

  Cards =[
    ["Rei da Montanha", 3, 2, "Nenhum",false],
    ["Lobo Celeste", 2, 1, "Nenhum",false],
    ["Espectro Negro", 1, 1, "Nenhum",false],
    ["rei Da Montanha", 3, 1, "Nenhum", false],
    ["fortex", 2, 5, "Nenhum", false],
    ["Ogro Negro", 5, 2, "Nenhum", false],
    ["dell O Fort", 1, 4, "Nenhum", false],
    ["hPn01", 1, 3, "Nenhum", false],
    ["javas", 2, 8, "Nenhum", false],
    ["cPlusivel", 5, 2, "Nenhum", false],
    ["antonela A Sereia", 1, 6, "Nenhum", false],
    ["nokia Tijolao", 7, 3, "Nenhum", false],
    ["ze Da Peixeira", 3, 2, "Nenhum", false],
    ["Mosntro Do nATAL", 8, 1, "Nenhum", false],
    ["Ogro Albino", 1, 8, "Nenhum", false],
    ["DeadLine", 1, 9, "Nenhum", false],
    ["Cortana A Antipatica", 9, 1, "Nenhum", false],
    ["Mercurio Alado", 2, 2, "Nenhum", false],
    ["Ciri A Engracada", 5, 5, "Nenhum", false]],nl,

  CardsTab = [
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false]
  ],

  CardsMao = [
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false],
      ["", 0, 0, "", false]
  ],

  % imprimeTopo(),
  % read(INPUT),
  setMaoJogador(1,Cards,CardsMao),
  % turno(1,Cards,CardsTab, CardsMao),
  main.

  % Adiciona um elemento numa dada posicao
  addElem(0, Elem, Y, [Elem|Y]).
  addElem(Index, Elem, [Head|Tail], [Head|Result]) :-
    NewIndex is Index - 1,
    addElem(NewIndex, Elem, Tail, Result).

  %Substitui um elem numa certa posicao
  swapElem(0, Elem, [_|Tail], [Elem|Tail]).
  swapElem(Index, Elem, [Head|Tail], [Head|Result]) :-
    NewIndex is Index - 1,
    swapElem(NewIndex, Elem, Tail, Result).

  cartasIguais([Nome,_,_,_,Bool], [Nome2,_,_,_,Bool2]) :-
    Nome = Nome2,
    Bool = Bool2.
