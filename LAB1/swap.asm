#CS224
#Lab No:1
#Section No:1
#SARPER ARDA BAKIR
#21902781
#04/10/22

	.text 
	.globl	_start
_start:	 

#Asking array size from user
	la 	$a0,msg1
	li	$v0, 4
	syscall 
	
	li	$v0,5
	syscall
	
	sw	$v0, size
	lw	$t0, size
	
	bgt	$t0,20, error # if user enter greater than 20 asking size again.

#creating array

	la	$t1,array
	
	jal	elementInput
	
	la 	$t1,array
	lw 	$t0,size
	
#displaying array
	
	la 	$a0,msg3
	li 	$v0,4
	syscall
	jal 	display
	
#reversing array	
	la 	$t1,array
	lw 	$t0,size
	
	li 	$t5,4 #temporal value for 4
	
	mult 	$t0,$t5
	mflo 	$t2
	
	add 	$t2,$t2,$t1	#$t2 tail pointer
	sub 	$t2,$t2,$t5
	
	jal 	reverse
	
#displaying reversed array
	
	la 	$t1,array
	lw 	$t0,size
	
	la 	$a0,msg4
	li 	$v0,4
	syscall
	jal 	display
	
	li 	$v0,10
	syscall
	
############################
error:
	la 	$a0,msg5
	li 	$v0, 4
	syscall
	
	j	_start
	
elementInput:

	la 	$a0,msg2
	li 	$v0,4
	syscall

	li 	$v0,5
	syscall
	
	sw 	$v0, 0($t1)
	addi 	$t1, $t1, 4
	addi 	$t0, $t0, -1
	bgt 	$t0,$zero,elementInput
	jr $ra
	
############################	
display:
	lw 	$a0, 0($t1)
	li 	$v0,1
	syscall
	
	la 	$a0, spc
	li 	$v0,4
	syscall
	
	addi 	$t1, $t1,4
	addi 	$t0,$t0,-1
	bgt 	$t0,$zero,display

reverse:
	bge 	$t1,$t2,return
	lw 	$t3, 0($t1)
	lw 	$t4, 0($t2)
	
	sw 	$t4, 0($t1)
	sw 	$t3, 0($t2)
	
	addi 	$t1, $t1,4
	subi 	$t2,$t2,4
	
	j 	reverse

return:
	jr 	$ra
	
############################	
	.data
array: 	.space 	80
size: 	.word 	0
msg1:	.asciiz "Enter the size of the array you want: "
msg2:	.asciiz "\nEnter inputs of array: "
msg3:	.asciiz "\nDisplaying array contents: "
msg4:	.asciiz "\n\nDisplaying reversed array contents: "
msg5:	.asciiz "\nInvalid Input. It should be less than 20.\n\n"
spc:	.asciiz " "
