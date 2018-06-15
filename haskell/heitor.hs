import System.IO.Unsafe

import Data.List

import Datas
import InstanceType






main :: IO()
main = do
  topo 10 10
  tabuleiro



topo :: Int -> Int ->IO()
topo vidaJogador1 vidaJogador2 = do
  putStrLn("----------------------------------------")
  print("Vida Jogador 1= " ++ (show vidaJogador1) ++ " | Vida Jogador 2= " ++ (show vidaJogador2))

tabuleiro :: IO()
tabuleiro = do
  putStrLn("----------------Tabuleiro: Jogador 1----------")
  printaCarta (derk)

  putStrLn("----------------Tabuleiro: Jogador 2----------")
  -- printaCarta 4 "testeCarta1" 40 10 "nenhum"
  -- printaCarta 5 "testeCarta2" 50 20 "nenhum"
  -- printaCarta 6 "testeCarta3" 60 30 "nenhum"

printaCarta :: Baralho ->IO()
printaCarta carta =
  print(show carta)
  -- print("Carta:"++ (show numero)++" nome: "++ nome ++" Ataque: "++ (show ataque)++" Vida "++ (show vida)++" Poder: "++ poder)
