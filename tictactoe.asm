

; Declare needed C  functions
        extern  printf          ; the C function, to be called
        extern  scanf
	extern	drawboard

        section .data           ; Data section, initialized variables
msg:    db "Welcome to TIC-TAC-ASSEMBLY:", 0 ; C string needs 0
msg2:	db "Pick an option from the menu below:", 0
msg3:	db "a - Easy", 0
msg4:	db "b - Hard", 0
msg5:	db "q - quit", 0

msg6:	db "Enter a location on the board 1-16", 0
msg7:	db "This is not an empty space. Try again!", 0
msg8:	db "Computer turn", 0

msg9:	db "YOU WIN", 0
msg10:	db "COMPUTER WIN", 0
msg11:	db "Segmentation fault (core dumped). I'm sorry this program is a big mess.", 0
msg12:	db "It's a draw!", 0
new_line db	10

fmt:    	db "%s", 10, 0          ; The printf format, "\n",'0'
fmt_scan:	db "%d",0
fmt3:   db "The result is %d ", 10, 0
fmt_scan2:	db "%s",0

lettera	db	"a", 0
letterb	db	"b", 0
letterx	db	"x", 0
lettero	db	"o", 0
letterc db	"c", 0
letterq	db	"q", 0
ez	db	"ez mode",0
hardm	db	"hard mode",0
invalid	db	"Invalid Input!",0

        section .bss
choice	resq  1
num	resq  1
empt 	resq  16 

        section .text           ; Code section.

        global main             ; the standard gcc entry point
main:                           ; the program label for the entry point
        push    rbp             ; set up stack frame, must be aligned

	start:
	mov	r15, 0	;count
	print_menu:
	call 	menu_promt

	;scan for mode option
	mov     rdi,fmt_scan2
        mov     rsi,choice
        mov     rax,0 
        call    scanf


	mov	r8b, [lettera]
	cmp	r8b, [choice]
	je	_easymode

	mov	r9b, [letterb]
	cmp	r9b, [choice]
	je	_hardmode
	

	mov	r10b, [letterq]
	cmp	r10b, [choice]
	je	exit
	
	mov	r14b, [letterc]
	cmp	r14b, [choice]
	je	check_egg
	jmp	print_invalid

	check_egg:
	inc	r15
	cmp	r15, 4
	je	egg
	
	print_invalid:
	mov     rdi,fmt         
        mov     rsi,invalid         
        mov     rax,0           
        call    printf
	jmp	print_menu

	exit:
	pop     rbp
        mov     rax,0           ; normal, no error, return value
        ret                     ; return

_easymode:
	call	empty_board
	mov	rdi, empt
	call	drawboard
	
	while_loop_ez:
	call	get_input_user
	mov	rdi, [letterx]
	call	check_row
	cmp	rax, 100 
	je	exit_ez

	mov	rdi, [letterx]
	call	check_col
	cmp	rax, 100
	je	exit_ez	

	mov	rdi, [letterx]
	call	check_diag
	cmp	rax, 100
	je	exit_ez	

	mov	rdi, [letterx]
	call	check_rediag
	cmp	rax, 100
	je	exit_ez	

	call 	check_draW
	cmp	rax, 25
	je	exit_ez

	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg8         
        mov     rax,0           
        call    printf   
	pop	rbp

	call	get_input_computer
	mov	rdi, [lettero]
	call	check_row
	cmp	rax, 100
	je	exit_ez


	mov	rdi, [lettero]
	call	check_col
	cmp	rax, 100
	je	exit_ez	

	mov	rdi, [letterx]
	call	check_diag
	cmp	rax, 100
	je	exit_ez	
	
	mov	rdi, [letterx]
	call	check_rediag
	cmp	rax, 100
	je	exit_ez	

	call 	check_draW
	cmp	rax, 25
	je	exit_ez

	jmp	while_loop_ez
	exit_ez:
	jmp 	start
_hardmode:
	call	empty_board
	mov	rdi, empt
	call	drawboard
	
	while_loop_hard:
	call	get_input_user

	mov	rdi, [letterx]
	call	check_row
	cmp	rax, 100 
	je	exit_hard

	mov	rdi, [letterx]
	call	check_col
	cmp	rax, 100
	je	exit_hard

	mov	rdi, [letterx]
	call	check_diag
	cmp	rax, 100
	je	exit_hard

	mov	rdi, [letterx]
	call	check_rediag
	cmp	rax, 100
	je	exit_hard
	
	call 	check_draW
	cmp	rax, 25
	je	exit_hard

	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg8         
        mov     rax,0           
        call    printf   
	pop	rbp

	;if block-> all set
	;not block -> call random
	
	call	col_block
	cmp	rax, 20
	je	printo

	call	row_block
	cmp 	rax, 20
	je	printo	
	
	call	block_diag
	cmp 	rax, 20
	je	printo	
	
	call	block_rediag
	cmp 	rax, 20
	je	printo	

	call	get_input_computer
	jmp	checko
	
	printo:
	call	print_board

	checko:
	mov	rdi, [lettero]
	call	check_row
	cmp	rax, 100
	je	exit_hard

	mov	rdi, [lettero]
	call	check_col
	cmp	rax, 100
	je	exit_hard	

	mov	rdi, [letterx]
	call	check_diag
	cmp	rax, 100
	je	exit_hard
	
	mov	rdi, [letterx]
	call	check_rediag
	cmp	rax, 100
	je	exit_hard

	call 	check_draW
	cmp	rax, 25
	je	exit_hard

	jmp	while_loop_hard
	exit_hard:
	jmp 	start
menu_promt:                
	mov     rdi,fmt         
        mov     rsi,msg         
        mov     rax,0           
        call    printf                  
	mov     rdi,fmt         
        mov     rsi,msg2         
        mov     rax,0           
        call    printf            	                     
	mov     rdi,fmt         
        mov     rsi,msg3         
        mov     rax,0           
        call    printf                               
	mov     rdi,fmt         
        mov     rsi,msg4         
        mov     rax,0           
        call    printf          
	push    rbp                     
	mov     rdi,fmt         
        mov     rsi,msg5         
        mov     rax,0           
        call    printf              	
	ret


empty_board:
	mov	r10, 32
	mov	[empt]  , r10
	mov	[empt+1], r10
	mov	[empt+2], r10
	mov	[empt+3], r10
	mov	[empt+4], r10
	mov	[empt+5], r10
	mov	[empt+6], r10
	mov	[empt+7], r10
	mov	[empt+8],  r10
	mov	[empt+9],  r10
	mov	[empt+10], r10
	mov	[empt+11], r10
	mov	[empt+12], r10
	mov	[empt+13], r10
	mov	[empt+14], r10
	mov	[empt+15], r10
	ret


print_board:
	mov	rdi, empt
	call	drawboard
	ret

get_input_user:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg6         
        mov     rax,0           
        call    printf   	

	while_loop:
	scan:
	mov     rdi,fmt_scan
        mov     rsi,num
        mov     rax,0 
        call    scanf
	
	
	mov	r10b, [letterx]
	mov	r9b, [lettero]
	xor	r14, r14
	mov	r14, [num]
	dec	r14

	cmp	[empt+r14], r10b	
	je	error
	cmp	[empt+r14], r9b
	je	error

	mov	[empt+r14], r10b
	call	print_board
	jmp	endloop

	error:
	;print error message
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg7         
        mov     rax,0           
        call    printf
	pop     rbp 
	jmp     while_loop

	endloop:
	pop     rbp 
	ret




get_input_computer:
	mov	r12b, [letterx]
	mov	r13b, [lettero]
	random:
	call 	rnd
	mov	r14, rax
	dec	r14
	
	cmp	[empt+r14], r12b	
	je	random
	cmp	[empt+r14], r13b
	je	random

	mov	[empt+r14], r13b
	call	print_board 
	ret

rnd:				;random generator function
	xor	r8, r8
	RDRAND 	r8
	mov	r9, 1		; r9  = min
	mov	r10, 17		; r10 = max
	; random number [1, 16] = r8 % (MAX - MIN + 1) + MIN
	inc 	r9		;MIN + 1
	sub 	r10, r9		;MAX - MIN + 1
	xor 	rdx, rdx
	mov	rax, r8		;RDX:RAX = r8 is dividend
	div	r10		;r10 is divisor, rax = quotient, rdx remainder
	mov	rax, rdx		
	add	rax, r9		
	ret

check_row:
	call	row_1
	cmp	rax, 100
	je	found
	call	row_2
	cmp	rax, 100
	je	found
	call	row_3
	cmp	rax, 100
	je	found
	call	row_4
	found:
	ret

row_1:
	
	mov	rax, 0
	mov	r14b, dil
	cmp 	[empt], r14b
	je	r1b
	jmp	noteq

	r1b:
	cmp 	[empt+1], r14b
	je	r1c
	jmp	noteq
		
		r1c:
		cmp 	[empt+2], r14b
		je	r1d
		jmp	noteq

			r1d:
			cmp 	[empt+3], r14b
			je	winner_r1
			jmp	noteq

	winner_r1:
	cmp	r14b, [letterx]
	je	xwinr1
	jmp	owinr1

	xwinr1:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	noteq
	
	owinr1:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	noteq:
	ret
	
row_2:
	
	mov	rax, 0
	mov	r14b, dil
	cmp 	[empt+4], r14b
	je	r2b
	jmp	noteq2

	r2b:
	cmp 	[empt+5], r14b
	je	r2c
	jmp	noteq2
		
		r2c:
		cmp 	[empt+6], r14b
		je	r2d
		jmp	noteq2

			r2d:
			cmp 	[empt+7], r14b
			je	winner_r2
			jmp	noteq2

	winner_r2:
	cmp	r14b, [letterx]
	je	xwinr2
	jmp	owinr2

	xwinr2:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	noteq2
	
	owinr2:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	noteq2:
	ret

row_3:
	
	mov	rax, 0
	mov	r14b, dil
	cmp 	[empt+8], r14b
	je	r3b
	jmp	noteq3

	r3b:
	cmp 	[empt+9], r14b
	je	r3c
	jmp	noteq3
		
		r3c:
		cmp 	[empt+10], r14b
		je	r3d
		jmp	noteq3

			r3d:
			cmp 	[empt+11], r14b
			je	winner_r3
			jmp	noteq3

	winner_r3:
	cmp	r14b, [letterx]
	je	xwinr3
	jmp	owinr3

	xwinr3:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	noteq3
	
	owinr3:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	noteq3:
	ret

row_4:
	
	mov	rax, 0
	mov	r14b, dil
	cmp 	[empt+12], r14b
	je	r4b
	jmp	noteq4

	r4b:
	cmp 	[empt+13], r14b
	je	r4c
	jmp	noteq4
		
		r4c:
		cmp 	[empt+14], r14b
		je	r4d
		jmp	noteq4

			r4d:
			cmp 	[empt+15], r14b
			je	winner_r4
			jmp	noteq4

	winner_r4:
	cmp	r14b, [letterx]
	je	xwinr4
	jmp	owinr4

	xwinr4:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	noteq4
	
	owinr4:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	noteq4:
	ret



check_col:
	call	col_1
	cmp	rax, 100
	je	foundcol
	call	col_2
	cmp	rax, 100
	je	foundcol
	call	col_3
	cmp	rax, 100
	je	foundcol
	call	col_4
	foundcol:
	ret

col_1:
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt], r15b
	je	c1b
	jmp	note1

	c1b:
	cmp 	[empt+4], r15b
	je	c1c
	jmp	note1
		
		c1c:
		cmp 	[empt+8], r15b
		je	c1d
		jmp	note1

			c1d:
			cmp 	[empt+12], r15b
			je	winner_c1
			jmp	note1

	winner_c1:
	cmp	r15b, [letterx]
	je	xwinc1
	jmp	owinc1

	xwinc1:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	note1
	
	owinc1:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100


	note1:
	ret


col_2:
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt+1], r15b
	je	c2b
	jmp	note2d

	c2b:
	cmp 	[empt+5], r15b
	je	c2c
	jmp	note2d
		
		c2c:
		cmp 	[empt+9], r15b
		je	c2d
		jmp	note2d

			c2d:
			cmp 	[empt+13], r15b
			je	winner_c2
			jmp	note2d

	winner_c2:
	cmp	r15b, [letterx]
	je	xwinc2
	jmp	owinc2

	xwinc2:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	note2d
	owinc2:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	note2d:
	ret

col_3: 
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt+2], r15b
	je	c3b
	jmp	note3d

	c3b:
	cmp 	[empt+6], r15b
	je	c3c
	jmp	note3d
		
		c3c:
		cmp 	[empt+10], r15b
		je	c3d
		jmp	note3d

			c3d:
			cmp 	[empt+14], r15b
			je	winner_c3
			jmp	note3d

	winner_c3:
	cmp	r15b, [letterx]
	je	xwinc3
	jmp	owinc3

	xwinc3:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	note3d
	
	owinc3:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	note3d:
	ret


col_4: 
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt+3], r15b
	je	c4b
	jmp	note4d

	c4b:
	cmp 	[empt+7], r15b
	je	c4c
	jmp	note4d
		
		c4c:
		cmp 	[empt+11], r15b
		je	c4d
		jmp	note4d

			c4d:
			cmp 	[empt+15], r15b
			je	winner_c4
			jmp	note4d

	winner_c4:
	cmp	r15b, [letterx]
	je	xwinc4
	jmp	owinc4

	xwinc4:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	note4d
	
	owinc4:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	note4d:
	ret
	
check_diag:	;+0 +5 +10 +15
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt], r15b
	je	dia1b
	jmp	dia_note1

	dia1b:
	cmp 	[empt+5], r15b
	je	dia1c
	jmp	dia_note1
		
		dia1c:
		cmp 	[empt+10], r15b
		je	dia1d
		jmp	dia_note1

			dia1d:
			cmp 	[empt+15], r15b
			je	winner_dia1
			jmp	dia_note1

	winner_dia1:
	cmp	r15b, [letterx]
	je	xwindia
	jmp	owindia

	xwindia:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	dia_note1
	
	owindia:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	dia_note1:
	ret

check_rediag:	;+3 +6 +9 +12
	mov	rax, 0
	mov	r15b, dil
	cmp 	[empt+3], r15b
	je	redia1b
	jmp	redia_note1

	redia1b:
	cmp 	[empt+6], r15b
	je	redia1c
	jmp	redia_note1
		
		redia1c:
		cmp 	[empt+9], r15b
		je	redia1d
		jmp	redia_note1

			redia1d:
			cmp 	[empt+12], r15b
			je	winner_redia1
			jmp	redia_note1

	winner_redia1:
	cmp	r15b, [letterx]
	je	xwinredia
	jmp	owinredia

	xwinredia:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg9         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	jmp	redia_note1
	
	owinredia:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg10         
        mov     rax,0           
        call    printf
	pop     rbp 
	mov	rax, 100
	redia_note1:
	ret



col_block:
	xor	rax, rax
	call	col_b1
	cmp	rax, 30
	je	row_b

	xor	rax, rax
	call	col_b2
	cmp	rax, 30	
	je	row_b

	xor	rax, rax
	call	col_b3
	cmp	rax, 30
	je	row_b

	xor	rax, rax
	call	col_b4
	cmp	rax, 30
	je	row_b

	col_b:
	ret

col_b1:;0 4 8 12
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]
	

	cmp	[empt], r15b
	jne	cb_c1b
	mov	r9b, [lettero]
	cmp	[empt], r9b
	je	cb_c1b
	inc	r14b

	cb_c1b:
	cmp	[empt+4], r15b
	jne	cb_c1c
	mov	r9b, [lettero]
	cmp	[empt+4], r9b
	je	cb_c1c
	inc	r14b

	cb_c1c:
	cmp	[empt+8], r15b
	jne	cb_c1d
	mov	r9b, [lettero]
	cmp	[empt+8], r9b
	je	cb_c1d
	inc	r14b

	cb_c1d:
	cmp	[empt+12], r15b
	jne	check_count
	mov	r9b, [lettero]
	cmp	[empt+12], r9b
	je	check_count

	inc	r14b
	
	check_count:
	cmp	r14b, 3
	je	pos
	jmp	not_pos

	pos:
	xor	r12, r12
	cmp	[empt], r15b
	je	cb_c1_b
	mov	r12, 0
	jmp	set
		cb_c1_b:
		cmp	[empt+4], r15b
		je	cb_c1_c
		mov	r12, 4
		jmp	set
			cb_c1_c:
			cmp	[empt+8], r15b
			je	cb_c1_d
			mov	r12, 8
			jmp	set
				cb_c1_d:
				mov	r12, 12
		
	set:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20

	jmp	exit_colb1
	
	not_pos:
	mov	rax, 30
	exit_colb1:
	ret

col_b2:;1 5 9 13
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+1], r15b
	jne	cb_c2b
	mov	r9b, [lettero]
	cmp	[empt+1], r9b
	je	cb_c2b
	inc	r14b

	cb_c2b:
	cmp	[empt+5], r15b
	jne	cb_c2c
	mov	r9b, [lettero]
	cmp	[empt+5], r9b
	je	cb_c2c
	inc	r14b

	cb_c2c:
	cmp	[empt+9], r15b
	jne	cb_c2d
	mov	r9b, [lettero]
	cmp	[empt+9], r9b
	je	cb_c2d
	inc	r14b

	cb_c2d:
	cmp	[empt+13], r15b
	jne	check_count2
	mov	r9b, [lettero]
	cmp	[empt+13], r9b
	je	check_count2
	inc	r14b
	
	check_count2:
	cmp	r14b, 3
	je	pos2
	jmp	not_pos2

	pos2:
	xor	r12, r12
	cmp	[empt+1], r15b
	je	cb_c2_b
	mov	r12, 1
	jmp	set2
		cb_c2_b:
		cmp	[empt+5], r15b
		je	cb_c2_c
		mov	r12, 5
		jmp	set2
			cb_c2_c:
			cmp	[empt+9], r15b
			je	cb_c2_d
			mov	r12, 9
			jmp	set2
				cb_c2_d:
				mov	r12, 13
		
	set2:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_colb2
	
	not_pos2:
	mov	rax, 30
	exit_colb2:
	ret


col_b3:;2 6 10 14
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+2], r15b
	jne	cb_c3b
	mov	r9b, [lettero]
	cmp	[empt+2], r9b
	je	cb_c3b
	inc	r14b

	cb_c3b:
	cmp	[empt+6], r15b
	jne	cb_c3c
	mov	r9b, [lettero]
	cmp	[empt+6], r9b
	je	cb_c3c
	inc	r14b

	cb_c3c:
	cmp	[empt+10], r15b
	jne	cb_c3d
	mov	r9b, [lettero]
	cmp	[empt+10], r9b
	je	cb_c3d
	inc	r14b

	cb_c3d:
	cmp	[empt+14], r15b
	jne	check_count3
	mov	r9b, [lettero]
	cmp	[empt+2], r9b
	je	check_count3
	inc	r14b
	
	check_count3:
	cmp	r14b, 3
	je	pos3
	jmp	not_pos3

	pos3:
	xor	r12, r12
	cmp	[empt+2], r15b
	je	cb_c3_b
	mov	r12, 2
	jmp	set3
		cb_c3_b:
		cmp	[empt+6], r15b
		je	cb_c3_c
		mov	r12, 6 
		jmp	set3
			cb_c3_c:
			cmp	[empt+10], r15b
			je	cb_c3_d
			mov	r12, 10
			jmp	set3
				cb_c3_d:
				mov	r12, 14
		
	set3:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_colb3
	
	not_pos3:
	mov	rax, 30
	exit_colb3:
	ret


col_b4:;3 7 11 15
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+3], r15b
	jne	cb_c4b
	mov	r9b, [lettero]
	cmp	[empt+3], r9b
	je	cb_c4b
	inc	r14b

	cb_c4b:
	cmp	[empt+7], r15b
	jne	cb_c4c
	mov	r9b, [lettero]
	cmp	[empt+7], r9b
	je	cb_c4c
	inc	r14b

	cb_c4c:
	cmp	[empt+11], r15b
	jne	cb_c4d
	mov	r9b, [lettero]
	cmp	[empt+11], r9b
	je	cb_c4d

	inc	r14b

	cb_c4d:
	cmp	[empt+15], r15b
	jne	check_count4
	mov	r9b, [lettero]
	cmp	[empt+3], r9b
	je	check_count4

	inc	r14b
	
	check_count4:
	cmp	r14b, 3
	je	pos4
	jmp	not_pos4

	pos4:
	xor	r12, r12
	cmp	[empt+3], r15b
	je	cb_c4_b
	mov	r12, 3
	jmp	set4
		cb_c4_b:
		cmp	[empt+7], r15b
		je	cb_c4_c
		mov	r12, 7
		jmp	set4
			cb_c4_c:
			cmp	[empt+11], r15b
			je	cb_c4_d
			mov	r12, 11
			jmp	set4
				cb_c4_d:
				mov	r12, 15
		
	set4:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_colb4
	
	not_pos4:
	mov	rax, 30
	exit_colb4:
	ret



row_block:
	xor	rax, rax
	call	row_b1
	cmp	rax, 30
	je	row_b
	xor	rax, rax
	call	row_b2
	cmp	rax, 30
	je	row_b

	xor	rax, rax
	call	row_b3
	cmp	rax, 30
	je	row_b

	xor	rax, rax	
	call	row_b4
	row_b:
	ret

row_b1:;0 1 2 3
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt], r15b
	jne	rb_r1b
	mov	r9b, [lettero]
	cmp	[empt], r9b
	je	rb_r1b
	inc	r14b

	rb_r1b:
	cmp	[empt+1], r15b
	jne	rb_r1c
	mov	r9b, [lettero]
	cmp	[empt+1], r9b
	je	rb_r1c
	inc	r14b

	rb_r1c:
	cmp	[empt+2], r15b
	jne	rb_r1d
	mov	r9b, [lettero]
	cmp	[empt+2], r9b
	je	rb_r1d

	inc	r14b

	rb_r1d:
	cmp	[empt+3], r15b
	jne	rcheck_count
	mov	r9b, [lettero]
	cmp	[empt], r9b
	je	rcheck_count

	inc	r14b
	
	rcheck_count:
	cmp	r14b, 3
	je	rpos
	jmp	rnot_pos

	rpos:
	xor	r12, r12
	cmp	[empt], r15b
	je	rb_r1_b
	mov	r12, 0
	jmp	rset
		rb_r1_b:
		cmp	[empt+1], r15b
		je	rb_r1_c
		mov	r12, 1
		jmp	rset
			rb_r1_c:
			cmp	[empt+2], r15b
			je	rb_r1_d
			mov	r12, 2
			jmp	rset
				rb_r1_d:
				mov	r12, 3
		
	rset:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_rowb1
	
	rnot_pos:
	mov	rax, 30
	exit_rowb1:
	ret

row_b2:;4 5 6 7
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+4], r15b
	jne	rb_r2b
	mov	r9b, [lettero]
	cmp	[empt+4], r9b
	je	rb_r2b

	inc	r14b

	rb_r2b:
	cmp	[empt+5], r15b
	jne	rb_r2c
	mov	r9b, [lettero]
	cmp	[empt+5], r9b
	je	rb_r2c

	inc	r14b

	rb_r2c:
	cmp	[empt+6], r15b
	jne	rb_r2d
	mov	r9b, [lettero]
	cmp	[empt+6], r9b
	je	rb_r2d

	inc	r14b

	rb_r2d:
	cmp	[empt+7], r15b
	jne	rcheck_count2
	mov	r9b, [lettero]
	cmp	[empt+7], r9b
	je	rcheck_count2

	inc	r14b
	
	rcheck_count2:
	cmp	r14b, 3
	je	rpos2
	jmp	rnot_pos2

	rpos2:
	xor	r12, r12
	cmp	[empt+4], r15b
	je	rb_r2_b
	mov	r12, 4
	jmp	rset2
		rb_r2_b:
		cmp	[empt+5], r15b
		je	rb_r2_c
		mov	r12, 5
		jmp	rset2
			rb_r2_c:
			cmp	[empt+6], r15b
			je	rb_r2_d
			mov	r12, 6
			jmp	rset2
				rb_r2_d:
				mov	r12, 7
		
	rset2:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_rowb2
	
	rnot_pos2:
	mov	rax, 30
	exit_rowb2:
	ret

row_b3:;8 9 10 11
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+8], r15b
	jne	rb_r3b
	mov	r9b, [lettero]
	cmp	[empt+9], r9b
	je	rb_r3b

	inc	r14b

	rb_r3b:
	cmp	[empt+9], r15b
	jne	rb_r3c
	mov	r9b, [lettero]
	cmp	[empt+9], r9b
	je	rb_r3c

	inc	r14b

	rb_r3c:
	cmp	[empt+10], r15b
	jne	rb_r3d
	mov	r9b, [lettero]
	cmp	[empt+10], r9b
	je	rb_r3d

	inc	r14b

	rb_r3d:
	cmp	[empt+11], r15b
	jne	rcheck_count3
	mov	r9b, [lettero]
	cmp	[empt+11], r9b
	je	rcheck_count3

	inc	r14b
	
	rcheck_count3:
	cmp	r14b, 3
	je	rpos3
	jmp	rnot_pos3

	rpos3:
	xor	r12, r12
	cmp	[empt+8], r15b
	je	rb_r3_b
	mov	r12, 8
	jmp	rset3
		rb_r3_b:
		cmp	[empt+9], r15b
		je	rb_r3_c
		mov	r12, 9
		jmp	rset3
			rb_r3_c:
			cmp	[empt+10], r15b
			je	rb_r3_d
			mov	r12, 10
			jmp	rset3
				rb_r3_d:
				mov	r12, 11
		
	rset3:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_rowb3
	
	rnot_pos3:
	mov	rax, 30
	exit_rowb3:
	ret

row_b4:;12 13 14 15
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+12], r15b
	jne	rb_r4b
	mov	r9b, [lettero]
	cmp	[empt+12], r9b
	je	rb_r4b

	inc	r14b

	rb_r4b:
	cmp	[empt+13], r15b
	jne	rb_r4c
	mov	r9b, [lettero]
	cmp	[empt+13], r9b
	je	rb_r4c

	inc	r14b

	rb_r4c:
	cmp	[empt+14], r15b
	jne	rb_r4d
	mov	r9b, [lettero]
	cmp	[empt+14], r9b
	je	rb_r4d

	inc	r14b

	rb_r4d:
	cmp	[empt+15], r15b
	jne	rcheck_count4

	mov	r9b, [lettero]
	cmp	[empt+15], r9b
	je	rcheck_count4

	inc	r14b
	
	rcheck_count4:
	cmp	r14b, 3
	je	rpos4
	jmp	rnot_pos4

	rpos4:
	xor	r12, r12
	cmp	[empt+12], r15b
	je	rb_r4_b
	mov	r12, 12
	jmp	rset4
		rb_r4_b:
		cmp	[empt+13], r15b
		je	rb_r4_c
		mov	r12, 13
		jmp	rset4
			rb_r4_c:
			cmp	[empt+14], r15b
			je	rb_r4_d
			mov	r12, 14
			jmp	rset4
				rb_r4_d:
				mov	r12, 15
		
	rset4:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_rowb4
	
	rnot_pos4:
	mov	rax, 30
	exit_rowb4:
	ret



block_diag:;0 5 10 15
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt], r15b
	jne	rb_diagb

	mov	r9b, [lettero]
	cmp	[empt], r9b
	je	rb_diagb

	inc	r14b

	rb_diagb:
	cmp	[empt+5], r15b
	jne	rb_diagc
	mov	r9b, [lettero]
	cmp	[empt+5], r9b
	je	rb_diagc

	inc	r14b

	rb_diagc:
	cmp	[empt+10], r15b
	jne	rb_diagd
	mov	r9b, [lettero]
	cmp	[empt+10], r9b
	je	rb_diagd

	inc	r14b

	rb_diagd:
	cmp	[empt+15], r15b
	jne	diagcheck_count
	mov	r9b, [lettero]
	cmp	[empt+15], r9b
	je	diagcheck_count

	inc	r14b
	
	diagcheck_count:
	cmp	r14b, 3
	je	diagpos
	jmp	diagnot_pos

	diagpos:
	xor	r12, r12
	cmp	[empt], r15b
	je	rb_diag_b
	mov	r12, 0
	jmp	diagset
		rb_diag_b:
		cmp	[empt+5], r15b
		je	rb_diag_c
		mov	r12, 5
		jmp	diagset
			rb_diag_c:
			cmp	[empt+10], r15b
			je	rb_diag_d
			mov	r12, 10
			jmp	diagset
				rb_diag_d:
				mov	r12, 15
		
	diagset:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_diagb
	
	diagnot_pos:
	mov	rax, 30
	exit_diagb:
	ret


block_rediag:;3 6 9 12
	mov 	rax, 0	;boolean flag
	mov	r14b, 0	;count
	mov	r15b, [letterx]

	cmp	[empt+3], r15b
	jne	rb_rediagb
	mov	r9b, [lettero]
	cmp	[empt+3], r9b
	je	rb_rediagb

	inc	r14b

	rb_rediagb:
	cmp	[empt+6], r15b
	jne	rb_rediagc
	mov	r9b, [lettero]
	cmp	[empt+6], r9b
	je	rb_rediagc

	inc	r14b

	rb_rediagc:
	cmp	[empt+9], r15b
	jne	rb_rediagd
	mov	r9b, [lettero]
	cmp	[empt+9], r9b
	je	rb_rediagd

	inc	r14b

	rb_rediagd:
	cmp	[empt+12], r15b
	jne	rediagcheck_count
	mov	r9b, [lettero]
	cmp	[empt+12], r9b
	je	rediagcheck_count


	inc	r14b
	
	rediagcheck_count:
	cmp	r14b, 3
	je	rediagpos
	jmp	rediagnot_pos

	rediagpos:
	xor	r12, r12
	cmp	[empt+3], r15b
	je	rb_rediag_b
	mov	r12, 3
	jmp	rediagset
		rb_rediag_b:
		cmp	[empt+6], r15b
		je	rb_rediag_c
		mov	r12, 6
		jmp	rediagset
			rb_rediag_c:
			cmp	[empt+9], r15b
			je	rb_rediag_d
			mov	r12, 9
			jmp	rediagset
				rb_rediag_d:
				mov	r12, 12
		
	rediagset:
	mov	r13b, [lettero]
	mov	[empt+r12], r13b
	mov	rax, 20
	jmp	exit_rediagb
	
	rediagnot_pos:
	mov	rax, 30
	exit_rediagb:
	ret


check_draW:
	mov	r9b, [letterx]
	mov	r10b,[lettero]
	mov	r12, 0; count
	mov	rax, 0; boolean flag
	loop_check:
	cmp	[empt+r12], r9b	;
	je	move_on
	cmp	[empt+r12], r10b;
	je	move_on
	jmp	exit_draw	; [pos] != 'x' != 'o' means there are still space not draw
	move_on:
	inc	r12
	cmp	r12, 15
	je	exit_loop
	jmp	loop_check

	exit_loop:
	push    rbp
	mov     rdi,fmt         
        mov     rsi,msg12        
        mov     rax,0           
        call    printf
	pop     rbp 

	mov	rax, 25	;boolean flag = 1
	exit_draw:
	ret

egg:
	mov     rdi,fmt         
        mov     rsi,msg11       
        mov     rax,0           
        call    printf
	jmp	exit

