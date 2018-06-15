module InstanceType where

import Datas

reiDaMontanha = Card "Rei da Montanha" 3 2 "Iniciativa" False
loboCeleste = Card "Lobo Celeste" 2 1 "Nenhum" False
espectroNegro = Card "Espectro Negro" 1 1 "Ataque Duplo" False
fortex = Card "Fortex" 5 0 "Provocar" False
cortanaAAntipatica = Card "Cortana A Antipatica" 4 1 "Provocar" False
mercurioAlado = Card "Mercurio Alado" 3 2 "Iniciativa" False
ciriAEngracada = Card "Ciri A Engracada" 1 3 "Nenhum" False



jogador1 = Jogador "Jogador1" 10 []
jogador2 = Jogador "Jogador2" 10 []

derk = Baralho [reiDaMontanha, loboCeleste, espectroNegro, fortex, reiDaMontanha, cortanaAAntipatica, mercurioAlado, ciriAEngracada]
