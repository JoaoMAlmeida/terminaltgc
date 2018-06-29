import System.IO.Unsafe
import Data.List
import Datas
import InstanceType
import System.Process
import System.Exit


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
  --verifica condicao de vitoria
  if (vidaJogador (jogador1)) <= 0
    then fimDeJogo 2 else putStrLn("")
  if (vidaJogador (jogador2)) <= 0
    then fimDeJogo 1 else putStrLn("")
  --printa o topo
  printTopo jogador1 jogador2
  -- printa o tabuleiro dos dois jogadores
  printTabuleiro jogador1 jogador2
  -- contador para puxar carta
  let novoContador = if(contador == 7) then 0 else contador + 1
  -- se for o jogador 1 printa a mao do jogador1
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
sacaMao n (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador, jogarCarta = jogaCarta1}) =
  Jogador nome vida tab novaMao jogaCarta1
  where
    novaMao = sacaRecursivo $ 2+n

sacaRecursivo:: Int -> [Card]
sacaRecursivo y
  | y == (-1) || y == 3 = []
  | otherwise = cartas !! y : sacaRecursivo (y-1) where cartas = getCartas derk

getCartas:: Baralho -> [Card]
getCartas (Baralho {cartas = cards}) = cards

puxaCarta:: Int -> Jogador -> Jogador
puxaCarta contador (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador, jogarCarta = jogaCarta1}) =
  Jogador nome vida tab novaMao jogaCarta1
  where
    novaMao = puxaCartaRecursivo contador maoJogador


puxaCartaRecursivo:: Int -> [Card] -> [Card]
puxaCartaRecursivo contador (x:xs)
  | x == cartaNula = (novaCarta contador):xs
  | otherwise = x:puxaCartaRecursivo contador xs

novaCarta:: Int -> Card
novaCarta contador = (getCartas derk) !! contador

jogaCarta:: String -> Jogador -> Jogador
jogaCarta posicao (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = maoJogador, jogarCarta = jogaCarta1})
  | read(posicao) <= 3 && read(posicao) >= 1 = Jogador nome vida novoTab novaMao False
  | otherwise = Jogador nome vida tab maoJogador jogaCarta1
  where
    novoTab = jogaCartaNoTabuleiro (verificaIniciativa (maoJogador !! (read posicao - 1))) tab
    novaMao = removeCartaDaMao (maoJogador !! (read posicao - 1)) maoJogador

jogaCartaNoTabuleiro:: Card -> [Card] -> [Card]
jogaCartaNoTabuleiro carta [] = []
jogaCartaNoTabuleiro carta [x] =
  if (x == cartaNula)
    then [carta]
    else [x]
jogaCartaNoTabuleiro carta (x:xs)
  | x == cartaNula = carta:xs
  | otherwise = x:jogaCartaNoTabuleiro carta xs

verificaIniciativa:: Card -> Card
verificaIniciativa (Card {nome = nome1, ataque = ataque1, vida = vida1, poder = poder1, bool = bool1}) =
  if (poder1 == "Iniciativa")
    then Card nome1 ataque1 vida1 poder1 True
    else Card nome1 ataque1 vida1 poder1 False

removeCartaDaMao:: Card -> [Card] -> [Card]
removeCartaDaMao carta (x:xs)
  | x == carta = cartaNula:xs
  | otherwise = x:removeCartaDaMao carta xs

selecionaCarta:: Int-> Int -> Jogador -> Jogador -> IO()
selecionaCarta contador n jogador1 jogador2 = do
  putStrLn("Escolha a carta a jogar (1, 2 ou 3)")
  posicao <- getLine
  if(n == 2)
    then
      if(jogarCarta jogador1)
        then inicio contador 1 (jogaCarta posicao jogador1) jogador2
        else inicio contador 1 jogador1 jogador2
    else
      if(jogarCarta jogador2)
        then inicio contador 2 jogador1 (jogaCarta posicao jogador2)
        else inicio contador 2 jogador1 jogador2

escolhaOpcao:: Int-> Int -> String -> Jogador -> Jogador -> IO()
escolhaOpcao contador n opcao jogador1 jogador2
  | opcao == "JC" = (selecionaCarta contador n jogador1 jogador2)
  | opcao == "AJ" = (atacarJogadorInicio contador n jogador1 jogador2)
  | opcao == "AC" = (atacarCartaInicio contador n jogador1 jogador2)
  | opcao == "FT" = (finalizarTurno contador n jogador1 jogador2)
  | otherwise = putStrLn("comando errado") >> if(n == 1) then inicio contador 2 jogador1 jogador2 else inicio contador 1 jogador1 jogador2

finalizarTurno:: Int -> Int -> Jogador -> Jogador -> IO()
finalizarTurno contador n jogador1 jogador2 = do
  putStrLn("")
  if n == 2
    then inicio contador n novoJogador1 jogador2
    else inicio contador n jogador1 novoJogador2
  where
    novoJogador1 = puxaCarta contador (habilitaJogarCarta (habilitaAtaqueCartasInicio jogador1))
    novoJogador2 = puxaCarta contador (habilitaJogarCarta (habilitaAtaqueCartasInicio jogador2))

habilitaAtaqueCartasInicio:: Jogador -> Jogador
habilitaAtaqueCartasInicio (Jogador {nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tab, mao = mao1, jogarCarta = jogaCarta1}) =
  Jogador nome vida novoTab mao1 jogaCarta1
  where
    novoTab = habilitaAtaqueCartas tab

habilitaAtaqueCartas:: [Card] -> [Card]
habilitaAtaqueCartas [x] =
  if(x == cartaNula)
    then [x]
    else [Card (nome x) (ataque x) (vida x) (poder x) True]
habilitaAtaqueCartas [] = []
habilitaAtaqueCartas (x:xs)
  | x == cartaNula = cartaNula:(habilitaAtaqueCartas xs)
  | otherwise = novaCarta:(habilitaAtaqueCartas xs) where
    novaCarta = Card (nome x) (ataque x) (vida x) (poder x) True


habilitaJogarCarta:: Jogador -> Jogador
habilitaJogarCarta jogador = Jogador (nomeJogador jogador) (vidaJogador jogador) (cartasTabuleiro jogador) (mao jogador) True

atacarJogadorInicio:: Int -> Int -> Jogador -> Jogador -> IO()
atacarJogadorInicio contador n jogador1 jogador2 = do
  putStrLn("Escolha uma carta sua para atacar (1, 2 ou 3)")
  posicao <- getLine
  if (n == 1) then inicio contador 2 (atacarJogador posicao jogador2 jogador1) jogador2 else inicio contador 1 jogador1 (atacarJogador posicao jogador1 jogador2)

atacarJogador:: String -> Jogador -> Jogador -> Jogador
atacarJogador posicao (Jogador {cartasTabuleiro = tabJogador}) (Jogador {nomeJogador = nome, vidaJogador = vidaInimigo, cartasTabuleiro = tab, mao = maoJogador, jogarCarta = jogaCarta1})
  | posicao <= "3" && posicao >="1" && poder (tabJogador !! (read posicao -1)) == "Ataque Duplo" && (not (verificaProvocar tab)) = Jogador nome novaVida2 tab maoJogador jogaCarta1
  | posicao <= "3" && posicao >="1" && (not (verificaProvocar tab)) = Jogador nome novaVida tab maoJogador jogaCarta1
  | otherwise = Jogador nome vidaInimigo tab maoJogador jogaCarta1
  where
    novaVida = vidaInimigo - ataque (tabJogador !! (read posicao -1))
    novaVida2 = vidaInimigo - (ataque (tabJogador !! (read posicao -1)) *2)

atacarCartaInicio:: Int -> Int -> Jogador -> Jogador -> IO()
atacarCartaInicio contador n jogador1 jogador2 = do
  putStrLn("Escolha uma carta sua para atacar (1, 2 ou 3)")
  posicao <- getLine
  putStrLn("Escolha a carta inimiga que deseja atacar (1, 2 ou 3)")
  posicaoInimiga <- getLine
  if (n == 1) then inicio contador 2 (atacarCarta posicao posicaoInimiga jogador2 jogador1) jogador2 else inicio contador 1 jogador1 (atacarCarta posicao posicaoInimiga jogador1 jogador2)

trocarCarta:: Card -> Card -> [Card] -> [Card]
trocarCarta cartaAntiga cartaNova (x:xs)
  | x == cartaAntiga = cartaNova:xs
  | otherwise = x:trocarCarta cartaAntiga cartaNova xs

atualizarHPCarta:: Card -> Card -> Card
atualizarHPCarta (Card {ataque = ataqueJogador, poder = poderJogador}) (Card {nome = nomeInimigo, ataque = ataqueInimigo, vida = vidaInimigo, poder = poderInimigo, bool = boolInimigo})
  | novaVida > 0 && poderJogador == "Ataque Duplo" = Card nomeInimigo ataqueInimigo novaVida2  poderInimigo boolInimigo
  | novaVida > 0 = Card nomeInimigo ataqueInimigo novaVida  poderInimigo boolInimigo
  | otherwise = cartaNula
  where
    novaVida = vidaInimigo - ataqueJogador
    novaVida2 = vidaInimigo - (ataqueJogador *2)

atacarCarta:: String -> String -> Jogador -> Jogador -> Jogador
atacarCarta posicao posicaoInimiga (Jogador {cartasTabuleiro = tabJogador}) (Jogador{nomeJogador = nome, vidaJogador = vida, cartasTabuleiro = tabInimiga, mao = maoInimiga, jogarCarta = jogaCartaInimigo})
  | posicao <= "3" && posicao >="1" && posicaoInimiga <= "3" && posicaoInimiga >= "1" && (not (verificaProvocar tabInimiga)) = Jogador nome vida novoTab maoInimiga jogaCartaInimigo
  | otherwise = Jogador nome vida tabInimiga maoInimiga jogaCartaInimigo
  where
    novoTab = trocarCarta (tabInimiga !! (read posicaoInimiga -1)) (atualizarHPCarta (tabJogador !! (read posicao -1)) (tabInimiga !! (read posicaoInimiga -1))) tabInimiga

verificaProvocar:: [Card] -> Bool
verificaProvocar (x:xs)
  | poder x == "Provocar" = True
  | xs == [] = False
  | otherwise = verificaProvocar xs

fimDeJogo:: Int -> IO()
fimDeJogo vencedor = do
  putStrLn("O jogo acabou:")
  putStrLn("O jogador " ++ show vencedor ++ " venceu.")
  exitSuccess
