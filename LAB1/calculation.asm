#CS224
#Lab No:1
#Section No:1
#SARPER ARDA BAKIR
#21902781
#04/10/22

#################################
#				#
#	text segment		#
#				#
#################################

	.text
	.globl	_start
_start:	 

#Asking inputs from user 
	la 	$a0 , msg2
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,a
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,b

#x,a,b data loading temporary registers 
	lw 	$t0,a
	lw 	$t1,b
	lw 	$t2,x
	
	li 	$t3,0		#temporary result
	
	li 	$t4,2		#constant value for 2
	
# calculating (2 *a - b)
	mult 	$t0,$t4
	mflo 	$t3	
	sub 	$t3,$t3,$t1
	
	move 	$t2,$t3		#uploding result
		
#calculating (a + b)
	add 	$t3,$t0,$t1
	
#calculating (2 *a - b)	/ (a + b)
	div 	$t2,$t3
	mflo 	$t2
	
#displaying result
	
	la 	$a0, result
	li 	$v0,4
	syscall

	move 	$a0, $t2
	li 	$v0,1
	syscall
	
#################################
#				#
#     	 data segment		#
#				#
#################################		
	
	.data
x:	.word 	0
a:	.word 	0
b:	.word 	0
msg1:	.asciiz "\nEnter number: "
msg2:	.asciiz "In this program x = (2 *a - b) / (a + b) equation will be calculated.\n"
result:	.asciiz "\nResult: " 
