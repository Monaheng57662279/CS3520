.text
main:
jal print
move $a0 ,$v0
li $v0,1
syscall

li $v0,10
syscall


isPrime:
	
	#if num<0 return false
	li $t0,2
	sgt $v0,$a1,$t0
	beqz  $v0,notPrime
	
	#testif num%i =0
	div $t0,$a1,2
	li $t1,2
	#for(int i = 2;i < num / 2;i++)
	prime:
	
		sle $t2,$t1,$t0
		beqz $t2,notPrime
		rem $t3,$a1,$t1
		addu $t1,$t1,1
		bnez $t3,prime
		addu $v0,$v0,-1
		
	notPrime:
		jr $ra
	
	
reverse:
	add $v0,$zero,0 
	#while(num > 0)
	loop:
	sgt $t0,$a1,$zero
	beqz $t0,endLoop
	mul $t1,$v0,10
	rem $t2,$a1,10
	add $v0,$t1,$t2
	div $a1,$a1,10
	b loop
endLoop:
	jr $ra
	
squareOfPrime:
		addi $v0,$zero,0
	
		addi $sp,$sp,-4
		sw $ra,0($sp)
		jal isPrime
		beqz $v0, false
		
		mul $a1,$a1,$a1
		jal reverse

		move $a0,$v0
		seq $v0, $a1, $a0
		
		bnez  $v0, false
		li $t0,2
		div $t1,$a0,2
		true:
			sle $t2,$t0,$t1
			beqz $t2, false
			mul $t3,$t0,$t0 
			seq  $t4,$t3,$a0
			beqz $t4, true
			
			move $a1,$t3
			jal isPrime
			
			
			b false
		
		false:
		
		lw $ra,0($sp)
		addi $sp,$sp,4
		
		jr $ra
			
print:
	#load into stack
	add $sp,$sp,-20
	sw $ra,0($sp)
	
	
	li $t0,2000
	
	li $a1,2
	sw $t0,4($sp) 
	sw $a1,8($sp)
	
	li $t1,10
	li $t2,0
	sw $t1,12($sp)
	sw $t2,16($sp)
	
	loop1:
		#while square of primes is less than 10, loop
		lw $t1,12($sp)
		lw $t2,16($sp)
		
		slt $t3,$t2,$t1
		beqz $t3, endLoop1
		lw $a1,8($sp) 
		jal squareOfPrime
	
		lw $a1,8($sp)
		addi $a1,$a1,1 
		sw $a1,8($sp)
		
		beqz $v0,loop1
		
		lw $a1,8($sp)
		addu $a1,$a1,-1
		
		mul $a0,$a1,$a1
		li $v0,1
		syscall
		
	
		lw $t2,16($sp)
		add $t2, $t2,1
		sw $t2,16($sp)
		#print newline
		la $a0, string
		li $v0,4
		syscall
		
		b loop1
	endLoop1:
		
		lw $ra,0($sp)
		#free stack
		add $sp,$sp,20
		
		jr $ra			
	
.data
string: .asciiz	"\n"
	