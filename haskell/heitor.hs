import System.IO.Unsafe
import Data.List
import Datas
import InstanceType
import System.Process


main :: IO()
main = do
  inicio 0 1 novoJogador1 novoJogador2
  where
    novoJogador1 = sacaMao 0 jogador1
    novoJogador2 = sacaMao 4 jogador2


inicio :: Int -> Int -> Jogador -> Jogador -> IO()
inicio contador n jogador1 jogador2 = do
  --limpa tela
  system "clear"
  --printa o topo
  printTopo jogador1 jogador2
  -- printa o tabuleiro dos dois jogadores
  printTabuleiro jogador1 jogador2
  -- se for o jogador 1 printa a mao do jogador1
  let novoContador = if(contador == 7) then 0 else contador + 1

  if n == 1
    then opcaoJogador1 novoContador jogador1 jogador2
    else opcaoJogador2 novoContador jogador1 jogador2




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

opcaoJogador1 :: Int-> Jogador -> Jogador -> IO()
opcaoJogador1 contador jogador1 jogador2 = do
  printMao jogador1
  printOpcao jogador1
  --ler as opções apos o fim da funcao acima
  opcao <- getLine
  escolhaOpcao contador 2 (opcao) jogador1 jogador2

opcaoJogador2 :: Int -> Jogador -> Jogador -> IO()
opcaoJogador2 contador jogador1 jogador2 = do
  printMao jogador2
  printOpcao jogador2
  --ler as opções apos o fim da funcao acima
  opcao <- getLine
  escolhaOpcao contador 1 (opcao) jogador1 jogador2


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

puxaCarta:: Int -> Jogador -> Jogador
puxaCarta contador (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador}) =
  Jogador nome vida tab novaMao where novaMao = puxaCartaRecursivo contador maoJogador


puxaCartaRecursivo:: Int -> [Card] -> [Card]
puxaCartaRecursivo contador (x:xs)
  | x == cartaNula = (novaCarta contador):xs
  | otherwise = x:puxaCartaRecursivo contador xs

novaCarta:: Int -> Card
novaCarta contador = (getCartas derk) !! contador

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

selecionaCarta:: Int-> Int -> Jogador -> Jogador -> IO()
selecionaCarta contador n jogador1 jogador2 = do
  putStrLn("Escolha a carta a jogar (1, 2 ou 3)")
  posicao <- getLine
  if(n == 2) then inicio contador 1 (jogaCarta posicao jogador1) jogador2 else inicio contador 2 jogador1 (jogaCarta posicao jogador2)

escolhaOpcao:: Int-> Int -> String -> Jogador -> Jogador -> IO()
escolhaOpcao contador n opcao jogador1 jogador2
  | opcao == "JC" = (selecionaCarta contador n jogador1 jogador2)
  | opcao == "AJ" = putStrLn("Atacou Jogador") -- função equivalente
  | opcao == "AC" = putStrLn("Atacou Carta") -- função equivalente
  | opcao == "FT" = (finalizarTurno contador n jogador1 jogador2)
  | otherwise = putStrLn("comando errado") >> if(n == 1) then inicio contador 2 jogador1 jogador2 else inicio contador 1 jogador1 jogador2

finalizarTurno:: Int-> Int -> Jogador -> Jogador -> IO()
finalizarTurno contador n jogador1 jogador2 = do
  putStrLn("")
  if n == 2
    then inicio contador n novoJogador1 jogador2
    else inicio contador n jogador1 novoJogador2
  where
    novoJogador1 = puxaCarta contador jogador1
    novoJogador2 = puxaCarta contador jogador2
