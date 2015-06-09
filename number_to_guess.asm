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
	lw	$s1, allowedGuesses	# prepare $s1 with the upper bound of allowed guesses
	lw	$s2, numToGuess		# prepare $s3 with the number we should be trying to guess
	
enterNum:
	beq	$s0, $s1, tooMany	# check if there have been 5 guesses and branch if there have been
	
	la	$a0, enterNumMsg	# prepare $a0 with the enterNumMsg
	li	$v0, 4			# prepare $v0 with 4 to print enterNumMsg
	syscall
	
	li	$v0, 5			# prepare $v0 with 5 to read an int
	syscall
	move	$a0, $v0		# move the user input to $a0
	
	addi	$s0, $s0, 1		# add 1 to the number of guesses
	
	bgt	$a0, $s2, greater	# branch if guess is greater than the correct answer
	blt	$a0, $s2, less		# branch if guess is less than the correct answer

equal:
	la	$a0, goodGuess		# prepare $a0 with good guess message
	li	$a1, 1			# load $a1 with 1 to signify we are exiting
	li	$a2, 0			# load $a2 with 0 to signify we guessed the right number
	b	printAndReturnOrExit

greater:
	la	$a0, tooHigh		# prepare $a0 with too high message
	li	$a1, 0			# load $a1 with 0 to signify we are going to continue
	b	printAndReturnOrExit

less:
	la	$a0, tooLow		# prepare $a0 with too low message
	li	$a1, 0			# load $a1 with 0 to signify we are going to continue
	b	printAndReturnOrExit

tooMany:
	la	$a0, tooManyMsg		# prepare $a0 with too many message
	li	$a1, 1			# load $a1 with 1 to signify we are exiting
	li	$a2, 1			# load $a2 with 1 to signify we guessed too many times
	
printAndReturnOrExit:
	li	$v0, 4			# load $v0 with 4 to print string
	syscall
	beqz	$a1, enterNum		# if $a1 is 0 we will continue the program
	
	beqz	$a2, exit		# if $a2 is 0 we should just exit
	
	li	$v0, 1			# prepare $v0 with 1 to print an integer
	move	$a0, $s2		# prepare $a0 with the number to guess
	syscall

exit:
	li	$v0, 10			# put 10 in $v0 to prepare to exit
	syscall

.data
numToGuess:	.word	89
allowedGuesses:	.word	5
goodGuess:	.asciiz	"You were correct.\n"
tooHigh:	.asciiz	"You guessed too high.\n"
tooLow:		.asciiz	"You guessed too low.\n"
tooManyMsg:	.asciiz "You guessed too many times. The answer was "
enterNumMsg:	.asciiz	"Please enter a number to guess:\n"