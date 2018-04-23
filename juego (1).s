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
	@@ Mensaje Jugador
	ldr r0, = Jugador
	bl MensajeJugador
	ldr r9, = Jugador
	ldr r9, [r9]
ingreso:
	@@ Mostrar Tablero
	ldr r0, = Tablero
	bl MostrarTablero
	ldr r0,= MEntrada
	bl puts
	ldr r0,= Entrada
	ldr r1,= Ingreso
	bl scanf
	@@ Revisar que sean numeros lo que se ingreso
	cmp r0,#0
	beq Num_Mal
	@@Revisar si se rindio
	ldr r1,= Ingreso
	ldr r1,[r1]
	cmp r1, #-1
	beq Rendirse
	@@Revisar que el ingreso este en el rango
	ldr r0,= Ingreso
	bl Revisar	
	@@ Revisar que sean los numero esten en rango
	cmp r0,#1
	beq Num_Mal
	ldr r0, = Tablero
	ldr r1,= Ingreso
	bl RevisarPaso
	@@ Revisar que se pueda mover
	cmp r0,#1
	beq Num_Mal
	mov r3, #0
	cmp r1,#2
	moveq r3, #2
	ldr r0, = Tablero
	ldr r1,= Ingreso
	bl Jugada
	ldr r0,=Tablero
	ldr r1,=Solucion
	bl Gano
	cmp r0, #0
	beq win
	b ingreso
fin:	
	@@ r0, r3 <- 0 como sennal de no error al sistema operativo
	mov	r3, #0
	mov	r0, r3
	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr
Rendirse:
	bl getchar
	b fin
Num_Mal:
	ldr r0,= mal
	bl puts
	bl getchar
	b ingreso
win: 	
	ldr r0,=Ganaste
	bl puts
	b fin
.data
.align 2
Ganaste:
	.asciz "Ganaste!!!!!!!!!!"
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
Solucion: 
	.word 'b','b','b','b','b',' ','a','a','a','a','a'
Tablero:
	.word 'a','a','a','a','a',' ','b','b','b','b','b'
MensajeBienvenida:
	.asciz "\nBienvenido a Ranas \nInstrucciones  \n1. Presione la tecla del numero de la rana que desea que salte \n2. Para salir presione al mismo tiempo las teclas Ctrl y z\n3. Para redirse ingrese -1"
