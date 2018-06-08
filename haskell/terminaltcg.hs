

fac 0 = 1
fac n = n * fac (n-1)

jogador1 = do
    putStrLn "Menu do jogador1"
    putStrLn "vida"
    putStrLn "cartas"
    putStrLn "tabuleiro"
    main 2

jogador2 = do
    putStrLn "Menu do jogador2"
    putStrLn "vida"
    putStrLn "cartas"
    putStrLn "tabuleiro"
    main 1

main2 n =
    if n == 1
      then jogador1
      else jogador2
main
  main2 1
