#CS224
#Lab No:1
#Section No:1
#SARPER ARDA BAKIR
#21902781
#04/10/22
	.text

#Asking inputs from user
	la 	$a0 , msg0
	li 	$v0, 4
	syscall	
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,b
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,c
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,d

# calculating b/c
	lw 	$t0,b
	lw 	$t1,c
	
	jal 	division
# calculating d*b

	lw 	$t0,d
	lw 	$t1,b
	lw 	$t2,a
	
	mult 	$t0,$t1
	mflo 	$t2
# calculating (b/c)+(d*b)
	
	add 	$t2,$t2,$a2
	
# calculating (b/c)+(d*b)-c
	lw 	$t3,c
	sub 	$t2,$t2,$t3

#calculating mod B
	move 	$a0,$t2
	lw 	$a1,b
	
	jal 	division

#displaying result
	la 	$a0, result
	li 	$v0,4
	syscall
	
	move 	$a0, $a3
	li 	$v0,1
	syscall

	li 	$v0,10
	syscall
	
#############################
division:

	
	li	$a2,0 	#result
	li	$a3,0	#remainder
	bgt	$t0,$zero, check
	j 	check
check:
	bge 	$t0,$t1, loopSub
	move 	$a3,$t0
	jr 	$ra
check1:
	bge 	$t1,$t0, loopAdd
	sub	$t0,$t0,$t1
	move 	$a3,$t0
	jr 	$ra
	
loopSub:
	sub 	$t0,$t0,$t1
	addi 	$a2,$a2,1
	j 	check
loopAdd:
	sub 	$t0,$t0,$t1
	addi 	$a2,$a2,1
	j 	check
############################			
	.data

msg0:	.asciiz "In this program A = (B / C + D * B - C ) Mod B will be calculated.\n\n"
msg1:	.asciiz "Enter number: "
result:	.asciiz "\nResult: " 
a:	.word 	0
b:	.word 	0
c:	.word 	0
d:	.word 	0
