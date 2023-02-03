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

#Asking array size and elements of array from user

	la 	$a0 , msg0
	li 	$v0, 4
	syscall 
	
	li 	$v0,5
	syscall
	
	sw 	$v0, size
	lw 	$t0, size
	
	bgt 	$t0,100,error
	
	la 	$t1,array
	
	move 	$a2,$t0
	move	$a3,$t1
	
	jal 	elementInput
	jal 	menu
		
#################################

#Taking elements of array and showing error message

elementInput:

	la 	$a0 , msg6
	li 	$v0, 4
	syscall

	li 	$v0, 5
	syscall
	
	
	sw 	$v0, 0($t1)
	addi 	$t1, $t1, 4
	addi 	$t0, $t0, -1
	bgt 	$t0,$zero,elementInput
	jr $ra
	
error:
	la 	$a0 , msg5
	li 	$v0, 4
	syscall
	
	j 	_start
	
#################################

#displaying options and taking option from user
	
menu:

	lw 	$t0, size
	
	la 	$t1, array
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg2
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg3
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg4
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg13
	li 	$v0, 4
	syscall
	
	la 	$a0 , msg7
	li 	$v0, 4
	syscall
	la 	$a0 , msg16
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	sw 	$v0,opt
	lw 	$t0,opt
	
	beq 	$t0,1,opt1
	beq 	$t0,2,opt2
	beq 	$t0,3,opt3
	beq 	$t0,4,opt4
	beq	$t0,5,opt5
	beq	$t0,6,bubbleSort
	
	bge 	$t0,5,errorMenu
	
#################################

opt1:
	
	move 	$t0,$a2		#size
	move	$t1,$a3		#array

#taking input

	la 	$a0 , msg8
	li 	$v0, 4
	syscall 
	
	li 	$v0,5
	syscall
	
	sw 	$v0,input
	lw 	$t3,input	#input
	
	li 	$t4,0		#sum
	
#there is no jump for opt1Loop bcs assembly reads codes top to down

opt1loop:

	lw 	$t6,0($t1)	#first element of array
	  
	beq 	$t0,$zero,done
	
	addi 	$t1, $t1, 4	#next element
	addi 	$t0, $t0, -1	#size decreasing
	
	bgt 	$t6,$t3,opt1count
	

	
	j 	opt1loop
	
opt1count:
	
	add 	$t4,$t4,$t6
	j 	opt1loop
	
#################################

opt2:
	move 	$t0,$a2
	move	$t1,$a3
	
	li 	$t4,0  		#even sum
	li 	$t5,0		#odd sum
	
opt2Loop:

	beq 	$t0,$zero,done2
	
	lw 	$t3, 0($t1)	#first element of array
	li 	$t9,2 		#constant 2
	div 	$t3,$t9
	mfhi 	$t6		#remainder for checking even or odd
	
	addi 	$t1, $t1, 4	#next element
	addi 	$t0, $t0, -1	#size decreasing
	
	beq 	$t6,$zero,evenCount
	bne 	$t6,$zero,oddCount
	
oddCount:

	add 	$t5, $t5, $t3
	j 	opt2Loop
	
evenCount:

	add 	$t4, $t4, $t3
	j 	opt2Loop
	
#################################

#ending loops and displaying results for option 1 and 3

done:
	la 	$a0 , msg9
	li 	$v0, 4
	syscall
	
	move 	$a0 , $t4
	li 	$v0, 1
	syscall 
	  
	j 	menu
	
#ending loops and displaying results for option 2
	
done2:
	la 	$a0 , msg10
	li 	$v0, 4
	syscall
	
	move 	$a0 , $t4
	li 	$v0, 1
	syscall 
	
	la 	$a0 , msg11
	li 	$v0, 4
	syscall
	
	move 	$a0 , $t5
	li 	$v0, 1
	syscall 
	
	j menu
	
#################################

opt3:

#taking input from user

	move 	$t0,$a2		#size
	move	$t1,$a3		#array
	
	la 	$a0 , msg8
	li 	$v0, 4
	syscall 
	
	li 	$v0,5
	syscall
	
	sw 	$v0,input
	lw 	$t3,input	#input
	
	li 	$t4,0		#sum
	
opt3Loop:

	beq 	$t0,$zero,done
	
	lw 	$t5, 0($t1)	#first element of array
	
	div 	$t5,$t3
	mfhi 	$t6		#remainder
	
	addi 	$t1, $t1, 4	#next element
	addi 	$t0, $t0, -1	#size decrasing
	
	beq 	$t6,$zero,opt3Count
	
	j	opt3Loop

opt3Count:

	addi 	$t4,$t4,1
	j	opt3Loop
	
#################################

#quit to progrom and displaying invalid input message

opt4:
	la 	$a0 , msg12
	li 	$v0, 4
	syscall
	
	li 	$v0,10
	syscall
opt5:
	lw	$t6,0($a3)
	
	li 	$t5,4 #temporal value for 4
	
	mult 	$a2,$t5
	mflo 	$t2
	
	add 	$t2,$t2,$a3	#$t2 tail pointer
	sub 	$t2,$t2,$t5
	
	lw	$t7,0($t2)
	
	la 	$a0 , msg14
	li 	$v0, 4
	syscall
	
	move 	$a0 , $t6
	li 	$v0, 1
	syscall
	
	la 	$a0 , msg15
	li 	$v0, 4
	syscall
	
	move 	$a0 , $t7
	li 	$v0, 1
	syscall
errorMenu:
	la $a0 , msg5
	li $v0, 4
	syscall
	j menu
bubbleSort:
	move $s0, $a0
	move $s1, $a1
	move $s2, $a1
	
comparator:
	beq $s1, $zero, ending 	# we have sorted everything
	lw  $t0 ,0($s0)		# first element
	lw  $t1, 4($s0)		# second element
	slt $t2, $t1, $t0	
	beq $t2, $zero, next	 
	sw  $t1, 0($s0)		 
	sw  $t0, 4($s0)		
			
next:
	addi $s0, $s0, 0x00000004 # increment by one the array pointer
	addi $s2, $s2, -0x00000001
	bgt  $s2, 0x00000001, comparator
	
	move $s0, $a0
	move $s2, $a1
	addi $s1, $s1, -0x00000001
	j comparator		
	
ending:
	jr $ra
#################################
#				#
#     	 data segment		#
#				#
#################################

	.data
array:	.space 	400
size:	.word 	0
msg0:	.asciiz "Enter the size of the array you want: "
msg1:	.asciiz "\n\n1. Find summation of numbers stored in the array which is greater than an input number.\n"
msg2:	.asciiz "2. Find summation of even and odd numbers and display them.\n"
msg3:	.asciiz "3. Display the number of occurrences of the array elements divisible by a certain input number.\n"
msg13:	.asciiz "5. minmax.\n"
msg4:	.asciiz "4. Quit.\n"
msg5:	.asciiz "\nInvalid Input.\n"
msg6:	.asciiz "\nEnter inputs of array: "
msg7:	.asciiz "\nEnter option(1-2-3-4): "
msg8:	.asciiz "\nEnter input: "
msg9:	.asciiz "\nResult: "
msg10:	.asciiz "\nResult Even Count: "
msg11:	.asciiz "\nResult Odd Count: "
msg12:	.asciiz "\nProgram Finished\n"
msg14:	.asciiz "Min: "
msg15:	.asciiz "\nMax: "
msg16:	.asciiz "\sort: "
opt:	.word	0
result:	.word	0
input:	.word 	0
