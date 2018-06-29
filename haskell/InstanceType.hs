module InstanceType where

import Datas

reiDaMontanha = Card "Rei da Montanha" 3 2 "Iniciativa" False
loboCeleste = Card "Lobo Celeste" 2 1 "Nenhum" False
espectroNegro = Card "Espectro Negro" 1 1 "Ataque Duplo" False
fortex = Card "Fortex" 0 5 "Provocar" False
ogroNegro =  Card "Ogro Negro" 2 1 "Ataque Duplo" False
dellOFort = Card "Dell O Fort" 2 2 "Nenhum" False
hPn01 = Card "HPn01" 3 6 "Nenhum" False
javas = Card "Javas" 1 1 "Nenhum" False
cPlusivel = Card "C Plusivel" 1 7 "Nenhum" False
antonelaASereia = Card "Antonela A Sereia" 5 3 "Nenhum" False
nokiaTijolao = Card "NokiaTi jolao" 15 0 "Provocar" False
zeDaPeixeira = Card "Ze Da Peixeira" 2 6 "Nenhum" False
mosntroDonATAL = Card "Mosntro DonATAL" 2 2 "Ataque Duplo" False
ogroAlbino = Card "ogro Albino" 2 2 "Ataque Duplo" False
deadLine = Card "Dead Line" 2 6 "Nenhum" False
cortanaAAntipatica = Card "Cortana A Antipatica" 4 1 "Provocar" False
mercurioAlado = Card "Mercurio Alado" 3 2 "Iniciativa" False
ciriAEngracada = Card "Ciri A Engracada" 1 3 "Nenhum" False
cartaNula = Card "" 0 0 "Nenhum" False


--                  nome     vida tabuleiro mao
jogador1 = Jogador "Jogador1" 10 [cartaNula, cartaNula, cartaNula] [] True
jogador2 = Jogador "Jogador2" 10 [cartaNula, cartaNula, cartaNula] [] True

derk = Baralho [reiDaMontanha, loboCeleste, espectroNegro, fortex,
 reiDaMontanha, cortanaAAntipatica, ciriAEngracada, ciriAEngracada,
 ogroNegro,dellOFort,hPn01,javas,
 cPlusivel,antonelaASereia, nokiaTijolao,zeDaPeixeira,
 mosntroDonATAL,ogroAlbino, deadLine]
