
<h1 align="center"> Roteiro para jogo da vida em  Haskell</h1>  

Passo a passo para compilar e executar a versão modificada do jogo da vida de John Conway. 
O Makefile está configurado para compilar e executar o programa de forma simplificada.

***
## Pré-requisitos

Certifique-se de ter o GHC (Glasgow Haskell Compiler) instalado em sua máquina. Caso não tenha, você pode baixá-lo e instalá-lo a partir do site oficial do [Haskell Platform](https://www.haskell.org/platform/).

## Como usar o Makefile

Através do terminal executar a sequencia de comandos abaixo:

###1. Compilar 
#### `make build` ou `make`

###2. Executar
#### `make run`

***

## Roteiro do Jogo

###Exemplos de Entrada:
Ao executar o programa, ele solicitará as entradas da seguinte forma:

`Digite os valores para o tabuleiro (formato: [[1,2],[2,0]] ou [[0,0,0],[1,1,1],[2,2,2]], etc.):`

Exemplos de entrada:

ex1: 
`[[0,0],[0,1]]`

ex2:
`[[1,0,1],[0,1,0],[0,1,2]]`


ex3:`[[2,1,0,1],[2,0,1,0],[0,1,0,0],[1,1,1,0]]`


Após inserir a grade do tabuleiro, o jogo solicitará a quantidade de iterações que deseja realizar da seguinte forma:
`Digite a quantidade de rodadas:`

ex1. 
`2`

ex2. 
`3`


***
##Jogo se incial no passo 1, 
###1ª iteração será no passo 2
###Saidas Esperadas

ex.1
  1 iteração: `{[[0,0],[0,0]]`

ex.2
 2 iteração ` [[0,2,0],[2,2,2],[0,2,2]]`
 
ex.3
  3 iteração ` [[2,2,2,0],[2,2,2,0],[2,2,0,0],[2,2,2,0]]`
 

***

Este README foi formatado usando Markdown para realçar as diferentes seções e instruções de forma clara e le
