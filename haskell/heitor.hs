import System.IO.Unsafe
import Data.List
import Datas
import InstanceType
import System.Process


main :: IO()
main = do
  inicio 1 novoJogador1 novoJogador2
  where
    novoJogador1 = sacaMao 0 jogador1
    novoJogador2 = sacaMao 4 jogador2


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

sacaMao:: Int -> Jogador -> Jogador
sacaMao n (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador}) = Jogador nome vida tab novaMao where novaMao = sacaRecursivo $ 2+n

sacaRecursivo:: Int -> [Card]
sacaRecursivo y
  | y == (-1) || y == 3 = []
  | otherwise = cartas !! y : sacaRecursivo (y-1) where cartas = getCartas derk

getCartas:: Baralho -> [Card]
getCartas (Baralho {cartas = cards}) = cards

puxaCarta:: Jogador -> Jogador
puxaCarta (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador}) =
  Jogador nome vida tab novaMao where novaMao = puxaCartaRecursivo maoJogador


puxaCartaRecursivo:: [Card] -> [Card]
puxaCartaRecursivo (x:xs)
  | x == cartaNula = novaCarta:xs
  | otherwise = x:puxaCartaRecursivo xs

novaCarta:: Card
novaCarta = (getCartas derk) !! 5;

jogaCarta:: String -> Jogador -> Jogador
jogaCarta posicao (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador})
  | posicao == "1" = Jogador nome vida novoTab1 novaMao1
  | posicao == "2" = Jogador nome vida novoTab2 novaMao2
  | posicao == "3" = Jogador nome vida novoTab3 novaMao3
  | otherwise = Jogador nome vida tab maoJogador
  where
    novoTab1 = jogaCartaNoTabuleiro (maoJogador !! 0) tab 3
    novaMao1 = removeCartaDaMao (maoJogador !! 0) maoJogador
    novoTab2 = jogaCartaNoTabuleiro (maoJogador !! 1) tab 3
    novaMao2 = removeCartaDaMao (maoJogador !! 1) maoJogador
    novoTab3 = jogaCartaNoTabuleiro (maoJogador !! 2) tab 3
    novaMao3 = removeCartaDaMao (maoJogador !! 2) maoJogador

jogaCartaNoTabuleiro:: Card -> [Card] -> Int -> [Card]
jogaCartaNoTabuleiro carta (x:xs) index
  | x == cartaNula = carta:xs
  | (index == 0) && (x /= cartaNula) = x:xs
  | otherwise = x:jogaCartaNoTabuleiro carta xs (index - 1)

removeCartaDaMao:: Card -> [Card] -> [Card]
removeCartaDaMao carta (x:xs)
  | x == carta = cartaNula:xs
  | otherwise = x:removeCartaDaMao carta xs

selecionaCarta:: Int -> Jogador -> Jogador -> IO()
selecionaCarta n jogador1 jogador2 = do
  putStrLn("Escolha a carta a jogar (1, 2 ou 3)")
  posicao <- getLine
  if(n == 2) then inicio 1 (jogaCarta posicao jogador1) jogador2 else inicio 2 jogador1 (jogaCarta posicao jogador2)

escolhaOpcao:: Int -> String -> Jogador -> Jogador -> IO()
escolhaOpcao n opcao jogador1 jogador2
  | opcao == "JC" = (selecionaCarta n jogador1 jogador2)
  | opcao == "AJ" = putStrLn("Atacou Jogador") -- função equivalente
  | opcao == "AC" = putStrLn("Atacou Carta") -- função equivalente
  | opcao == "FT" = (finalizarTurno n jogador1 jogador2)
  | otherwise = putStrLn("comando errado")

finalizarTurno:: Int -> Jogador -> Jogador -> IO()
finalizarTurno n jogador1 jogador2 = do
  putStrLn("")
  if n == 2
    then inicio n novoJogador1 jogador2
    else inicio n jogador1 novoJogador2
  where
    novoJogador1 = puxaCarta jogador1
    novoJogador2 = puxaCarta jogador2
