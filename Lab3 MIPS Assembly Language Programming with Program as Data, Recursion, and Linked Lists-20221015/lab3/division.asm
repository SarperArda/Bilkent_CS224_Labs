	.text 
	.globl main
main:
	la 	$a0 , msg0
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	beqz $v0,done
	
	move	$a1,$v0
	
	la 	$a0 , msg1
	li 	$v0, 4
	syscall
	
	li 	$v0,5
	syscall
	
	beqz $v0,done
	
	move	$a2,$v0
	jal	division
	
	move	$t0,$v1
	
	la 	$a0 , msg2
	li 	$v0, 4
	syscall
	
	
	move 	$a0 , $t0
	li 	$v0, 1
	syscall
	
	add	$v1,$zero,$zero
	j	main
division:
	addi	$sp, $sp, -16
	sw	$s0, 12($sp)
	sw	$s1, 8($sp)
	sw	$s2, 4($sp)
	sw	$ra, 0($sp) 
	
	li	$s0,0
	
	bgt	$a2,$a1,doneRecursive
	sub	$a1,$a1,$a2
	addi	$s0,$zero,1
	jal	division
	
doneRecursive:
	add	$v1,$v1,$s0
	lw	$ra, 0($sp) 
	lw	$s2, 4($sp)
	lw	$s1, 8($sp)
	lw	$s0, 12($sp)
	addi	$sp, $sp, 16
	jr	$ra	

	
done:
	li 	$v0,10
	syscall	

	.data
msg0:	.asciiz "\nEnter number you want to divide: "
msg1:	.asciiz "\nEnter divisor: "
msg2:	.asciiz "\nResult: "
