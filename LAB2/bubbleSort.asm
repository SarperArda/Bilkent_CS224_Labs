#CS224
#Lab No:2
#Section No:1
#SARPER ARDA BAKIR
#21902781
#12/10/22
		.text
	.globl	_main
############################
_main:
	la 	$a0 , msg0
	li 	$v0, 4
	syscall 
	
	li 	$v0,5
	syscall
	
	move 	$t0, $v0
	ble 	$t0,$zero, error
	li	$t1,4
	
	mult	$t0,$t1
	mflo	$t2
	
	move	$a0,$t2
	li	$v0,9
	syscall
	move	$t2,$v0
	move	$a2,$t2
	move	$a3,$t0
############################
monitor:
	
	subi 	$sp,$sp,16
	sw 	$s0,0($sp)
	sw 	$s1,4($sp)
	sw 	$s2,8($sp)
	sw 	$s3,12($sp)
	
	move	$s0,$a2
	move	$s1,$a3

		
	jal	elementInput
	la 	$a0,msg5
	li 	$v0,4
	syscall
	
	move	$a2,$s0
	move	$a3,$s1
	
	jal	display
	
	la 	$a0 , msg6
	li 	$v0, 4
	syscall 
	move	$a0,$s0
	move	$a1,$s1
	
	jal bubble
	
	move	$s0,$a0
	move	$s1,$a1
	
	la 	$a0,msg5
	li 	$v0,4
	syscall
	
	move	$a2,$s0
	move	$a3,$s1
	
	jal	display
	
	move	$a3,$s0
	move	$a2,$s1
	
	jal	minMax
	
	move	$s2,$v0
	move	$s3,$v1
	la 	$a0 , msg2
	li 	$v0, 4
	syscall
	
	move 	$a0 , $s2
	li 	$v0, 1
	syscall
	
	la 	$a0 , msg3
	li 	$v0, 4
	syscall
	
	move 	$a0 , $s3
	li 	$v0, 1
	syscall
	
	addi	$sp,$sp,16
	li 	$v0, 10
	syscall
	
############################	
elementInput:
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall

	li 	$v0, 5
	syscall
	
	
	sw 	$v0, 0($a2)
	addi 	$a2, $a2, 4
	addi 	$a3, $a3, -1
	bgt 	$a3,$zero,elementInput
	jr $ra
############################
display:

	subi 	$sp,$sp,16
	sw 	$s0,0($sp)
	sw 	$s1,4($sp)
	sw 	$s2,8($sp)
	sw 	$s3,12($sp)
	
	lw 	$a0, 0($a2)
	li 	$v0,1
	syscall
	
	la 	$a0, spc
	li 	$v0,4
	syscall
	
	addi 	$a2, $a2,4
	addi 	$a3,$a3,-1
	bgt 	$a3,$zero,display
	addi	$sp,$sp,16
	jr	$ra	
############################
bubble:

	subi 	$sp,$sp,24
	sw 	$s0,0($sp)
	sw 	$s1,4($sp)
	sw 	$s2,8($sp)
	sw 	$s3,12($sp)
	sw 	$s4,16($sp)
	sw 	$s5,20($sp)


	move	$s0,$a0
	move	$s1,$a1
	move	$s2,$a1
	li	$s5,1
		
outer:
	beq 	$s1,$zero,sorted
	lw	$s3,0($s0)
	lw	$s4,4($s0)
	bgt 	$s3,$s4,inner
	sw	$s4,0($s0)
	sw	$s3,4($s0)
	
inner:
	addi	$s0,$s0,4
	subi	$s2,$s2,1
	bgt 	$s2,$s5,outer
	move	$s0,$a0
	addi	$s5,$s5,1
	subi	$s1,$s1,1
	move	$s2,$a1
	j	outer
	
sorted:
	addi	$sp,$sp,24
	jr $ra	
############################		
minMax:
	
	subi 	$sp,$sp,16
	sw 	$s0,0($sp)
	sw 	$s1,4($sp)
	sw 	$s2,8($sp)
	sw 	$s3,12($sp)
	
	lw	$s0,0($a3)
	
	li 	$s1,4  		#temporal value for 4
	
	mult 	$a2,$s1
	mflo 	$s2
	
	add 	$s2,$s2,$a3	#$t2 tail pointer
	sub 	$s2,$s2,$s1
	
	lw	$s3,0($s2)
	move	$v0,$s3
	move	$v1,$s0
	addi	$sp,$sp,16
	jr $ra
############################
error:
	la 	$a0,msg4
	li 	$v0, 4
	syscall
	
	j	_main
	
############################		
		.data
msg0:	.asciiz "Enter the size of the array you want: "
msg1:	.asciiz "\nEnter inputs of array: "
msg2:	.asciiz "\nMin: "
msg3:	.asciiz "\nMax: "
msg4:	.asciiz "\nInvalid Input.\n"
msg5:	.asciiz "\n\nDisplaying array contents: "
msg6:	.asciiz	"\nBubble Sort"
spc:	.asciiz " "