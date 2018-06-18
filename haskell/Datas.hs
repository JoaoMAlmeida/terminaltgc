module Datas where

data Card = Card {
nome :: String,
ataque :: Int,
vida :: Int,
poder :: String,
bool :: Bool
} deriving(Show)


data Jogador = Jogador{
nomeJogador :: String,
vidaJogador :: Int,
cartasTabuleiro :: [Card],
mao :: [Card]
}  deriving(Show)

data Tabuleiro = Tabuleiro{
cartasJogador2 :: [Card]
}deriving(Show)

data Baralho = Baralho{
cartas :: [Card]
}deriving(Show)
