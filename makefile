FILE  =	tictactoe
FILE2 = drawboard
all: $(FILE)

$(FILE): $(FILE).asm
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	gcc -m64 -o $(FILE) $(FILE).o

two: $(FILE).asm $(FILE6).c
	nasm -f elf64 -l $(FILE).lst $(FILE).asm
	gcc -c  $(FILE2).c -o $(FILE2).o
	gcc -m64 -o $(FILE) $(FILE2).o $(FILE).o -lm 

run: $(FILE)
	./$(FILE)

clean: 
	rm *.o  *.lst

