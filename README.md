# tictactoe-nasmx86-64
tictactoe game with easy mode and hard mode (incomplete)


The Problem
In this project, you will be developing a game of tic tac toe where the human will be playing against a computer. Unlike regular titactoe, our game will be played on a 4x4 board.

This should be a menu driven game. The main menu options can be found below:

a - Easy:
Computer plays in easy mode. See Computer Play Easy description below.

b - Hard: 
Computer plays in hard mode. See Computer Play Hard description below.

q - Quit game:
The user can quit the game during play.


In addition to the main menu items your game should have the following features:

Who goes first: 
Human player always goes first and thus always plays with character ‘x’. The computer always plays with the character ‘o’.

Computer play Easy:
This is the easy level of computer play. In this level, the computer picks a random spot on the board and if it is empty it places the appropriate character there.

Computer Play Hard:
In this level, the computer scans the board to see if the human can win on their next move. If there is a possibility that they can win, the computer should block it. If there is no place where the human can win the computer picks a random spot to play.

Game Play:
The game will be played in the following way:
The  program should present the main menu to the user and take their input.
Once an option is selected, the game begins with an empty board being displayed and a request to the user to enter a location they want to play (1-16).
Once they enter a location the board prints out the user’s play, and a second board showing the computer play. The cycle begins again until there is a winner or if there is a draw.
A winner is declared when they have four characters in a line(horizontal, vertical or diagonal)..

Once a game ends, it resets back to the main menu. The only way to end the program should be when the user enters the quit option.
