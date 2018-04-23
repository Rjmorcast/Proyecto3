.text
.align		2
.global	MostrarTablero
.global MensajeJugador
.global Revisar
.global RevisarLetra
.global RevisarPaso
.global Jugada
MostrarTablero:
	push {lr}
	push {r0}
	@@ Cargar el tablero
	pop {r8}
	mov r6,#0
imprimir:
	ldr r0,=formato
	ldr r1, [r8], #4
	@@ Imprimirlo
	bl printf
	add r6,r6,#1
	cmp r6, #11
	blt imprimir
	@@Salto de linea
	ldr r0,=salto
	bl puts
	@@Imprimir numero de abajo
	ldr r0,=numeros
	bl puts
	pop {lr}
	mov pc, lr
MensajeJugador:
	push {lr}
	push {r0}
	ldr r1, [r0]
	@@Cargar mensaje de jugador e imprimir
	ldr r0,=formatoJugador
	bl printf
	pop {r0}
	ldr r1, [r0]
	@@Cambiar al siguiente
	cmp r1,#1
	moveq r1,#2
	movne r1,#1
	str r1, [r0]
	pop {lr}
	mov pc, lr	
	
Revisar:
	ldr r1, [r0]
	mov r0, #0
	@@ Mira que este dentro del rango de numeros permitidos
	cmp r1, #0
	movlt r0, #1
	cmp r1, #11
	movgt r0, #1
	mov pc,lr
RevisarLetra:
	push {lr}
	push {r0}
	pop {r8}
	mov r6,#0
	ldr r7, [r1]
	push {r2}

ciclo:	add r8,#4
	add r6,r6,#1
	cmp r6, r7
	blt ciclo
	sub r8, #4
	ldr r1, [r8]
	@@ revisar que es la letra que corresponde
	pop {r7}
	ldr r0,[r7]
	cmp r0, #2
	moveq r7, #97
	movne r7, #98
	ldr r0,[r8]
	cmp r0, r7
	movne r0, #0
	moveq r0, #1
	pop {lr}
	mov pc, lr
RevisarPaso:
	push {lr}
	push {r0}
	pop {r8}
	mov r6,#0
	ldr r7, [r1]
	push {r2}
ciclo2:
	add r8,#4
	add r6,r6,#1
	cmp r6, r7
	blt ciclo2
	sub r8, #4
	ldr r1, [r8]
	@@ revisar que es la letra que corresponde
	pop {r7}
	ldr r0,[r7]
	cmp r0, #2
	moveq r7, #97
	moveq r9, #4
	movne r7, #98
	movne r9, #-4
	mov r1,#1
	@@ revisar enfrente
	ldr r0,[r8,r9]
	cmp r0, r7
	moveq r0, #1
	cmp r0, #32
	moveq r0, #0
	beq ya
	add r1,#1
	@@ revisar salto
	add r9, r9
	ldr r0,[r8,r9]
	cmp r0, #97
	moveq r0, #1
	beq ya
	cmp r0, #98
	moveq r0, #1
	beq ya

ya:
	pop {lr}
	mov pc, lr                                            
@@Variables
Jugada:
	push {lr}
	push {r0}
	pop {r8}
	mov r6,#0
	ldr r7, [r1]
	push {r2}
ciclo3:
	add r8,#4
	add r6,r6,#1
	cmp r6, r7
	blt ciclo3
	sub r8, #4
	ldr r1, [r8]
	@@ revisar que es la letra que corresponde
	pop {r7}
	ldr r0,[r7]
	cmp r0, #2
	moveq r7, #97
	moveq r9, #4
	movne r7, #98
	movne r9, #-4
	cmp r3, #2
	addeq r9,r9
	str r7, [r8,r9]
	mov r7,#32
	str r7, [r8]
	pop {lr}
	mov pc, lr 
	
	
salto:
	.asciz ""
formato:
	.asciz "(%c)  "
formatoJugador:
	.asciz "Jugador %d \n"
numeros:
	.asciz "(1)  (2)  (3)  (4)  (5)  (6)  (7)  (8)  (9) (10) (11) \n"
