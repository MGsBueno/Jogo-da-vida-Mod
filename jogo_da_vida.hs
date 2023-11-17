import Control.Concurrent (threadDelay)
import System.Process (system)
import System.Info (os)

type Pos = (Int, Int)
type Grade = [(Pos, Int)]

-- Constantes para representar os estados
morto :: Int
morto = 0

vivo :: Int
vivo = 1

zumbi :: Int
zumbi = 2


-- Função para aguardar um determinado tempo em segundos
delay :: Int -> IO ()
delay n = threadDelay (n * 1000000) -- Convertendo segundos para microssegundos

-- Limpa a tela
limparTela :: IO ()
limparTela = do
    let comandoLimpar = if os == "mingw32" || os == "windows" then "cls" else "clear"
    _ <- system comandoLimpar
    return ()

-- Função para imprimir o tabuleiro
printGrade :: Grade -> Int -> Int -> IO ()
printGrade b rows cols = mapM_ (\y -> printLinha b cols y) [0..rows-1]

-- Imprime uma linha do tabuleiro
printLinha :: Grade -> Int -> Int -> IO ()
printLinha b cols y = do
    let row = map (\x -> showState (getCellState (x, y) b)) [0..cols-1]
    putStrLn row


-- Obtém o estado de uma célula
getCellState :: Pos -> Grade -> Int
getCellState pos grade = case lookup pos grade of
    Just state -> state
    Nothing -> morto

-- Imprime o estado de uma célula
showState :: Int -> Char
showState state
    | state == morto = '0'
    | state == vivo = '1'
    | state == zumbi = '2'
    | otherwise = '.'




-- Obtém todos os vizinhos de uma célula
vizinhos :: Pos -> Int -> Int -> [Pos]
vizinhos (x, y) linhas cols = filter (\(x', y') -> x' >= 0 && y' >= 0 && x' < linhas && y' < cols && (x', y') /= (x, y)) 
    [(x', y') | x' <- [x - 1..x + 1], y' <- [y - 1..y + 1]]

--Conta Vizinhos vivos
countVizinhosVivos :: Pos -> Grade -> Int -> Int -> Int
countVizinhosVivos pos b linhas cols = length $ filter (\p -> getCellState p b == vivo) (vizinhos pos linhas cols)

-- Mudança do tabuleiro em uma iteração
atualiza :: Grade -> Int -> Int -> Int -> Grade
atualiza b linhas cols n =
    let candidates = [(x, y) | x <- [0..linhas - 1], y <- [0..cols - 1]]
        newCellState pos =
            case getCellState pos b of
                _ | getCellState pos b == morto && countVizinhosVivos pos b linhas cols == 3 -> (pos, vivo) -- Reprodução        
                  | getCellState pos b == vivo && any (\p -> getCellState p b == zumbi) (vizinhos pos linhas cols) -> (pos, zumbi) -- Infecção
                  | getCellState pos b == vivo && countVizinhosVivos pos b linhas cols > 3 -> (pos, morto) -- Superpopulação
                  | getCellState pos b == vivo && countVizinhosVivos pos b linhas cols < 2 -> (pos, morto) -- Subpopulação
                  | getCellState pos b == zumbi && countVizinhosVivos pos b linhas cols == 0 -> (pos, morto) -- Inanição
                  | otherwise -> (pos, getCellState pos b)
    in map newCellState candidates


-- Execução do jogo
runGame :: Grade -> Int -> Int -> Int -> IO ()
runGame b 0 _ _ = return ()
runGame b n linhas cols = do
    limparTela
    printGrade b linhas cols
    delay 2
    let novaGrade = atualiza b linhas cols n
    runGame novaGrade (n - 1) linhas cols



-- Converte uma lista de listas de inteiros em um Grade
initializaGrade :: [[Int]] -> Grade
initializaGrade matriz = [((x, y), val) | (y, linha) <- zip [0..] matriz, (x, val) <- zip [0..] linha]


-- Função principal
main :: IO ()
main = do
    putStrLn "Digite os valores para o tabuleiro (formato: [[1,2],[2,0]] ou [[0,0,0],[1,1,1],[2,2,2]], etc.):"
    input <- getLine
    let parsedInput = read input :: [[Int]]
        linhas = length parsedInput
        cols = length (head parsedInput)
        grade = initializaGrade parsedInput

    putStrLn "Digite a quantidade de rodadas:"
    roundsInput <- getLine
    let rounds = read roundsInput :: Int

    runGame grade rounds linhas cols