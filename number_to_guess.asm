# Create a variable called numToGuess and set it equal to your number to guess.
# Pass a number entered from the keyboard to a procedure that prints one of the following messages:
#   *If the number from the keyboard equals the number to guess, print a "good guess" message.
#   *If the number from the keyboard is smaller than the number to guess, print a "too low" message.
#   *If the number from the keyboard is greater than the number to guess, print a "too hi" message.
#   and returns 1 for a "good guess" or 0 for a "too low" or "too hi" guess.
# Allow no more than 5 guesses.
#   If the number is guessed correctly before the 5th guess, print a congratulatory message and exit the program.
#   If the number is not guessed correctly in five guesses, print a "you had your five guesses" message and exit the program.

.text
main:
	add	$s0, $zero, $zero	# prepare $s0 to count the number of guesses made
	
enterNum:
	beq				# check if there have been 5 guesses and branch if there have been
	
	la	$a0, enterNumMsg	# prepare $a0 with the enterNumMsg
	li	$v0, 4			# prepare $v0 with 4 to print enterNumMsg
	syscall
	
	li	$v0, 5			# prepare $v0 with 5 to read an int
	syscall
	move	$t0, $v0		# move the user input to $t0
	
	addi	$s0, $s0, 1		# add 1 to the number of guesses
	
checkGuess:
	bgt				# branch if guess is greater than the correct answer
	blt				# branch if guess is less than the correct answer
	beq				# branch if guess is equal to the correct answer

greater:

less:

equal:
	
	
	li	$v0, 10			#put 10 in $v0 to prepare to exit
	syscall


.data
numToGuess:	.word	5
goodGuess:	.asciiz	"You were correct.\n"
tooHigh:	.asciiz	"You guessed too high.\n"
tooLow:		.asciiz	"You guessed too low.\n"
enterNumMsg:	.asciiz	"Please enter a number to guess\n"