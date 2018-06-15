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
mao :: [Card]
}  deriving(Show)

data Tabuleiro = Tabuleiro{
cartasJogador1 :: [Card],
cartasJogador2 :: [Card]
}deriving(Show)

data Baralho = Baralho{
cartas :: [Card]
}deriving(Show)
