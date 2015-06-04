# This program compiles the following C code to MIPS assembly
# int leaf_example( int g, int h, int I, int j ){
#    int f;
#    f = (g + h) - (I + j)
#    return f;
#}

leaf_example:
	addi 	$sp, $sp, -12	# make room for 3 items on the stack pointer ($sp)
	sw	$t1, 8($sp)	# save $t1 for use later
	sw	$t0, 4($sp)	# save $t0 for use later
	sw	$s0, 0($sp)	# save $s0 for use later
	
	add	$t1, $a0, $a1	# (g + h) and store in $t1
	add	$t0, $a2, $a3	# (i + j) and store in $t0
	sub	$s0, $t1, $t0	# (g + h) - (i + j) and store in $s0
	
	move	$v0, $s0	# set $v0 (return register) to the contents of $s0
	
	lw	$s0, 0($sp)	# restore register $s0
	lw	$t0, 4($sp)	# restore register $t0
	lw	$t1, 8($sp)	# restore register $t1
	addi	$sp, $sp, 12	# adjust stack to delete 3 items
	
	jr	$ra		# jump back to calling routine