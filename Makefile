# Comando para compilar o programa Haskell
compile:
	ghc -o jogo_da_vida jogo_da_vida.hs

# Comando para limpar arquivos temporários gerados pela compilação
clean:
	rm -f jogo_da_vida *.o *.hi

# Regra padrão ao chamar "make" sem argumentos
all: compile

# Regra para executar o programa
run:
	./jogo_da_vida

.PHONY: clean run
