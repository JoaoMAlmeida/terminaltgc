import System.IO.Unsafe
import Data.List
import Datas
import InstanceType
import System.Process


main :: IO()
main = do
  inicio 1 jogador1 jogador2


inicio :: Int -> Jogador -> Jogador -> IO()
inicio n jogador1 jogador2 = do
  --limpa tela
  system "clear"
  --printa o topo
  printTopo jogador1 jogador2
  -- printa o tabuleiro dos dois jogadores
  printTabuleiro jogador1 jogador2
  -- se for o jogador 1 printa a mao do jogador1
  if n == 1
    then opcaoJogador1 jogador1 jogador2
    else opcaoJogador2 jogador1 jogador2



printTopo :: Jogador -> Jogador ->IO()
printTopo jogador1 jogador2 = do
  putStrLn("----------------------------------------")
  putStrLn("Vida Jogador 1= " ++ (show (vidaJogador jogador1)) ++ " | Vida Jogador 2= " ++ (show (vidaJogador jogador2)))

printTabuleiro ::Jogador -> Jogador-> IO()
printTabuleiro jogador1 jogador2= do
  putStrLn("----------------Tabuleiro: Jogador 1----------")
  printaCarta 1 ((cartasTabuleiro jogador1) !! 0)
  printaCarta 2 ((cartasTabuleiro jogador1) !! 1)
  printaCarta 3 ((cartasTabuleiro jogador1) !! 2)
  putStrLn("----------------Tabuleiro: Jogador 2----------")
  printaCarta 1 ((cartasTabuleiro jogador2) !! 0)
  printaCarta 2 ((cartasTabuleiro jogador2) !! 1)
  printaCarta 3 ((cartasTabuleiro jogador2) !! 2)

printaCarta :: Int ->Card ->IO()
printaCarta n carta = do
  putStrLn("Carta :"++ (show (n)) ++" nome: "++ (show (nome carta)) ++" Ataque: "++ (show (ataque carta)) ++" Vida :"++ (show (vida carta)) ++" Poder :"++ (show (poder carta)))

opcaoJogador1 :: Jogador -> Jogador -> IO()
opcaoJogador1 jogador1 jogador2 = do
  printMao jogador1
  printOpcao jogador1
  --ler as opções apos o fim da funcao acima
  opcao <- getLine
  escolhaOpcao 2 (opcao) jogador1 jogador2

opcaoJogador2 :: Jogador -> Jogador -> IO()
opcaoJogador2 jogador1 jogador2 = do
  printMao jogador2
  printOpcao jogador2
  --ler as opções apos o fim da funcao acima
  opcao <- getLine
  escolhaOpcao 1 (opcao) jogador1 jogador2


printMao :: Jogador -> IO()
printMao jogador = do
  putStrLn("---------------Mao:" ++ (show(nomeJogador jogador)) ++ "---------------")
  printaCarta 1 ((mao jogador) !! 0)
  printaCarta 2 ((mao jogador) !! 1)
  printaCarta 3 ((mao jogador) !! 2)
  putStrLn("------------------------------------")

printOpcao :: Jogador -> IO()
printOpcao jogador = do
  putStrLn("Turno: "++ (show (nomeJogador jogador)) ++": ")
  putStrLn("Menssagem:")
  putStrLn("JC - Jogar Carta | AJ - Atacar Jogador | AC - Atacar Carta | FT - Finalizar Turno")

escolhaOpcao:: Int -> String -> Jogador -> Jogador -> IO()
escolhaOpcao n opcao jogador1 jogador2
    | opcao == "JC" = putStrLn("Jogou Carta") -- função equivalente
    | opcao == "AJ" = do
      cartaEscolhida <- getLine
      (atacarJogador n cartaEscolhida jogador1 jogador2)
    | opcao == "AC" = putStrLn("Atacou Carta") -- função equivalente
    | opcao == "FT" = (finalizarTurno n jogador1 jogador2)
    | otherwise = putStrLn("comando errado")

finalizarTurno:: Int -> Jogador -> Jogador -> IO()
finalizarTurno n jogador1 jogador2 = do
  inicio n jogador1 jogador2
  putStrLn("")

  atacarJogador:: Int -> Int -> Jogador -> Jogador -> IO()
  atacarJogador n nCarta jogador1 jogador2 = do
    if n == 1
      then
        vidaF = (vidaJogador jogador2) - ( ataque ((cartasTabuleiro jogador1) !! nCarta))
        (vidaJogador jogador2) = vidaF
      else
        vidaF = (vidaJogador jogador1) - ( ataque ((cartasTabuleiro jogador2 !! nCarta))
        (vidaJogador jogador1) = vidaF
