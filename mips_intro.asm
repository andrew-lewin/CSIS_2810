# reads three ints and stores them in t0, t1, and t2
# display the sum of the numbers
# display the smaller number
# display the larger number
# ask the user if they want to continue

	.text
main:				#start of program
loop:
		#read the ints
		#store in t0, t1, t2
		la	$a0, input_msg	#load input_msg into $a0 to prepare for syscall
		
		li	$v0, 4		#set $v0 to 4, which will print what $a0 points at
		syscall			#make the syscall
		li	$v0, 5		#prepare $v0 for reading an int
		syscall			#read the int
		move 	$t0, $v0	#move the information from $v0 to $t0
		
		li	$v0, 4		#set $v0 to 4, which will print what $a0 points at
		syscall			#make the syscall
		li	$v0, 5		#prepare $v0 for reading an int
		syscall			#read the int
		move 	$t1, $v0	#move the information from $v0 to $t1
		
		li	$v0, 4		#set $v0 to 4, which will print what $a0 points at
		syscall			#make the syscall
		li 	$v0, 5		#prepare $v0 for reading an int
		syscall			#read the int
		move	$t2, $v0	#move the information from $v0 to $t1
		
		#calculate the sum and print output
		#store sum in t3
		add	$t3, $t0, $t1	#add $t0 and $t1 and store in $t3
		add	$t3, $t2, $t3	#add $t2 and the old $t3 and store in $t3
		
		la	$a0, sum_msg	#set $a0 to sum_msg so we can print that
			li	$v0, 4		#set $v0 to 4, which will print what $a0 points at
		syscall			#make the syscall
		move	$a0, $t3	#make $a0 be what's in $t3
		li	$v0, 1		#make $v0 1 to print an int
		syscall			#make the syscall to finish the string
		
		#find the min and max and print them
		#store them in t3
		ble	$t0, $t1, t0_smaller	#branch if $t0 is smaller than $t1
		move 	$t3, $t1		#otherwise set $t3 to contents of $t1
		b	endif_smaller1		#branch to endif_smaller1
	t0_smaller:
		move	$t3, $t0		#set $t3 to the contents of $t0
	
	endif_smaller1:
		ble	$t2, $t3, t2_smaller	#branch if $t2 is smaller than $t3
		b	endif_smaller2		#branch to endif_smaller2
	t2_smaller:
		move	$t3, $t2		#set $t3 to the conents of $t2
	
	endif_smaller2:
		la	$a0, smaller_msg	#prepare $a0 with smaller_msg
		li	$v0, 4			#set $v0 to 4, which will print string $a0
		syscall
		move	$a0, $t3		#set $a0 to the conetns of $t3
		li	$v0, 1			#prepare $v0 for an int
		syscall
		
		bge	$t0, $t1, t0_bigger	#branch if $t0 is larger than $t1
		move	$t3, $t1		#otherwise set $t3 to contents of $t1
		b	endif_bigger1		#branch to endif_bigger1
	t0_bigger:
		move	$t3, $t0		#set $t3 to the contents of $t0
	
	endif_bigger1:
		bge	$t2, $t3, t2_bigger	#branch if $t2 is larger than $t3
		b	endif_bigger2		#branch to endif_bigger2
	t2_bigger:
		move	$t3, $t2		#set $t2 to the contents of $t2
	
	endif_bigger2:
		la	$a0, larger_msg		#prepare $a0 with larger_msg
		li	$v0, 4			#set $v0 to 4, which will print string $a0
		syscall
		move	$a0, $t3		#set $a0 to the contents of $t3
		li	$v0, 1			#prepare $v0 for an int
		syscall
	
	#ask if user if they want to exit
		la	$a0, exit_msg		#prepare $a0 with exit_msg
		li	$v0, 4			#set $v0 to 4, which will print string $a0
		syscall
		li	$v0, 5			#prepare $v0 for reading an int
		syscall
		beqz	$v0, endloop		#if $v0, user input, is 0 go to endloop to exit
		
	#format input output for next iteration
		la	$a0, next_iteration	#prepare $a0 with next_iteration
		li	$v0, 4			#set $v0 to 4, which will print string $a0
		syscall
		b	loop
	
endloop:
		li	$v0, 10		#put 10 in $v0 to prepare to exit
		syscall			#make syscall, which reads $v0 to exit

	.data
input_msg:	.asciiz "Enter an int:\n"
sum_msg:	.asciiz "\nThe sum is "
smaller_msg:	.asciiz "\nThe smaller number is "
larger_msg:	.asciiz "\nThe larger number is "
exit_msg:	.asciiz "\n\ncontinue? 0 for exit, 1 for continue\n"
next_iteration:	.asciiz "\n"