.text
.align		2
.global		main
.type		main, %function
main:
	stmfd	sp!, {lr}
	@@ Mensaje de bienvenida
	ldr r0,= MensajeBienvenida
	bl puts
Juego:
	@@ Mostrar Tablero
	ldr r0, = Tablero
	bl MostrarTablero
	@@ Mensaje Jugador
	ldr r0, = Jugador
	bl MensajeJugador
ingreso:
	ldr r0,= MEntrada
	bl puts
	ldr r0,= Entrada
	ldr r1,= Ingreso
	bl scanf
	@@ Revisar que sean numeros lo que se ingreso
	cmp r0,#0
	beq Num_Mal
	@@Revisar que el ingreso este en el rango
	ldr r0,= Ingreso
	bl Revisar	
	@@ Revisar que sean los numero esten en rango
	cmp r0,#1
	beq Num_Mal
	ldr r0,=Tablero
	ldr r1,= Ingreso
	ldr r2,= Jugador
	bl RevisarLetra
	@@ Revisar que sean la letra
	cmp r0,#0
	beq Num_Mal
	
	ldr r0,=Tablero
	ldr r1,= Ingreso
	ldr r2,= Jugador
	bl RevisarPaso
	@@ Revisar que se pueda mover
	cmp r0,#1
	beq Num_Mal
	mov r3, #0
	cmp r1,#2
	moveq r3, #2
	ldr r0,=Tablero
	ldr r1,= Ingreso
	ldr r2,= Jugador
	bl Jugada
	b Juego
	
fin:	
	@@ r0, r3 <- 0 como sennal de no error al sistema operativo
	mov	r3, #0
	mov	r0, r3
	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr

Num_Mal:
	ldr r0,= mal
	bl puts
	bl getchar
	b ingreso
.data
.align 2
MEntrada:
	.asciz "Ingreso el movimiento"
mal:
	.asciz "Ingreso invalido"
Entrada:
	.asciz "%d"
Ingreso:
	.word 0
Jugador:
	.word 1
MensajeBienvenida:
	.asciz "Bienvenido a Ranas"
Tablero:
	.word 'a','a','a','a','a',' ','b',' ','b','b','b'
