#CS224
#Lab No:3
#Section No:1
#SARPER ARDA BAKIR
#21902781
#02/11/22
		.text
	.globl main
main:
	la 	$a0,msg1
	li	$v0, 4
	syscall 
	
	li	$v0,5
	syscall
	
	sw	$v0, size
	
	lw	$t0,size
	
	move	$a0, $t0	
	jal	createLinkedList
	
	move	$a0, $v0	
	move	$a1,$a0
	jal 	printLinkedList
	
	la 	$a0,msg1
	li	$v0, 4
	syscall 
	
	li	$v0,5
	syscall
	
	sw	$v0, size
	
	lw	$t1,size
	move	$a0, $t1	
	jal	createLinkedList
	move	$a0, $v0
	move	$a2,$a0
	jal 	printLinkedList

	la	$a0, line2
	li	$v0, 4
	syscall
	
	beqz	$t0,case1
	beqz	$t1,case2
	
	jal merge
	move	$a0, $v0
	move	$t2,$a0
	move	$a3, $v1
	la 	$a0,msg4
	li	$v0, 4
	syscall 
	move 	$a0,$a3
	li	$v0, 1
	syscall
	lw	$a0,0($t2)
	jal 	printLinkedList
# Stop. 
	li	$v0, 10
	syscall
case1:

	beqz   $t1,case3
	
	la 	$a0,msg4
	li	$v0, 4
	syscall 
	move 	$a0,$t1
	li	$v0, 1
	syscall
	
	move	$a0,$a2
	jal 	printLinkedList
	li	$v0, 10
	syscall
case2:
	beqz 	$t0,case3
	
	la 	$a0,msg4
	li	$v0, 4
	syscall 
	move 	$a0,$t0
	li	$v0, 1
	syscall
	
	move	$a0,$a1
	jal 	printLinkedList
	li	$v0, 10
	syscall
case3:
	la 	$a0,msg4
	li	$v0, 4
	syscall 
	move 	$a0,$zero
	li	$v0, 1
	syscall
	
	la	$a0, msg3
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall
createLinkedList:
# $a0: No. of nodes to be created ($a0 >= 1)
# $v0: returns list head
# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
# By 4*i inserting a data value like this
# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	beqz	$s0,jump
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	la 	$a0,msg2
	li	$v0, 4
	syscall 
	
	li	$v0,5
	syscall
	
	sw	$v0, data
	lw	$s4,data	
	sw	$s4, 4($s2)	# Store the data value.

addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq 	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
		
	la 	$a0,msg2
	li	$v0, 4
	syscall 
	
	li	$v0,5
	syscall
	
	sw	$v0, data
	lw	$s4,data
	sw	$s4, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
jump:
	jr	$ra
merge:
	addi	$sp, $sp, -36
	sw	$s0, 32($sp)
	sw	$s1, 28($sp)
	sw	$s2, 24($sp)
	sw	$s3, 20($sp)
	sw	$s4, 16($sp)
	sw	$s5, 12($sp)
	sw	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw	$ra, 0($sp) 
	
	li	$s0,0
	move	$s1,$a1
	move	$s2,$a2
	li	$a0, 8
	li	$v0, 9
	syscall
 
	move	$s7, $v0	
	move	$t3, $v0
comprasion:
	beqz	$s1,caseFirst
	beqz	$s2,caseSecond
	lw	$s3,0($s1)
	lw	$s4,0($s2)
	lw	$s5,4($s1)
	lw	$s6,4($s2)

	blt	$s5,$s6,add1
	blt	$s6,$s5,add2
	beq 	$s6,$s5,add3
add1:
	move	$v1,$s5
	move	$s1,$s3
	j	addLink
add2:
	move	$v1,$s6
	move	$s2,$s4
	j	addLink
add3:
	move	$v1,$s5
	move	$s1,$s3
	move	$s2,$s4
	j	addLink
addLink:
	addi	$s0, $s0, 1	
	li	$a0, 8 		
	li	$v0, 9
	syscall

	sw	$v0, 0($s7)

	move	$s7, $v0	
		
	sw	$v1, 4($s7)	
	j	comprasion
caseFirst:
	beqz	$s4,done
	lw	$s6,4($s2)
	move	$v1,$s6
	lw	$s4,0($s2)
	move	$s2,$s4
	j	addLink
caseSecond:
	lw	$s3,0($s1)
	lw	$s5,4($s1)
	move	$v1,$s5
	move	$s1,$s3
	j	add1
done:
	
	sw	$zero, 0($s7)
	move	$v1,$s0
	move	$v0,$t3
	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr	$ra
#=========================================================
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $a0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	beqz	$s0,printedAll
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1

	la	$a0, line
	li	$v0, 4
	syscall		
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	
	li	$v0, 1
	syscall

	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	
	li	$v0, 1		
	syscall	


	move	$s0, $s1	
	j	printNextNode
printedAll:

	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
#=========================================================		
	.data
size: 	.word 	0
data: 	.word 	0
msg1:	.asciiz "\nEnter the size of the linked list you want: "
msg2:	.asciiz "\nEnter the data: "
msg3:	.asciiz "\nEmpty Linked List"
msg4:	.asciiz "\nSize: "

line:	
	.asciiz "\n --------------------------------------"
line2:	
	.asciiz "\n \n----------RESULT-----------------"
nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
