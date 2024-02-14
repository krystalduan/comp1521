########################################################################
# COMP1521 22T1 -- Assignment 1 -- Mipstermind!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T1/resources/mips-editors.html
# !!! IMPORTANT !!!
#
#
# This program was written by YOUR-NAME-HERE (z5361475)
# on 27-03-2022
#
# Version 1.0 (28-02-22): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
########################################################################

#![tabsize(8)]

# Constant definitions.
# DO NOT CHANGE THESE DEFINITIONS

TURN_NORMAL = 0
TURN_WIN    = 1
NULL_GUESS  = -1

########################################################################
# .DATA
# YOU DO NOT NEED TO CHANGE THE DATA SECTION
.data

# int correct_solution[GUESS_LEN];
.align 2
correct_solution:	.space GUESS_LEN * 4

# int current_guess[GUESS_LEN];
.align 2
current_guess:		.space GUESS_LEN * 4

# int solution_temp[GUESS_LEN];
.align 2
solution_temp:		.space GUESS_LEN * 4


guess_length_str:	.asciiz "Guess length:\t"
valid_guesses_str:	.asciiz "Valid guesses:\t1-"
number_turns_str:	.asciiz "How many turns:\t"
enter_seed_str:		.asciiz "Enter a random seed: "
you_lost_str:		.asciiz "You lost! The secret codeword was: "
turn_str_1:		.asciiz "---[ Turn "
turn_str_2:		.asciiz " ]---\n"
enter_guess_str:	.asciiz "Enter your guess: "
you_win_str:		.asciiz "You win, congratulations!\n"
correct_place_str:	.asciiz "Correct guesses in correct place:   "
incorrect_place_str:	.asciiz "Correct guesses in incorrect place: "

############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################


########################################################################
#
# Implement the following 8 functions,
# and check these boxes as you finish implementing each function
#
#  - [ ] main
#  - [ ] play_game
#  - [ ] generate_solution
#  - [ ] play_turn
#  - [ ] read_guess
#  - [ ] copy_solution_into_temp
#  - [ ] calculate_correct_place
#  - [ ] calculate_incorrect_place
#  - [X] seed_rand  (provided for you)
#  - [X] rand       (provided for you)
#
########################################################################


########################################################################
# .TEXT <main>
.text
main:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   - [...]
	#
	# Structure:
	#   main
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

main__prologue:
	begin                   # begin a new stack frame
	push	$ra             # $ra

main__body:
	# printf("Guess length: %d\n", GUESS_LEN);
	la	$a0, guess_length_str
	li	$v0, 4          # syscall 4: print_string
	syscall                 # printf("Guess length: ");

	li	$a0, GUESS_LEN
	li	$v0, 1          # syscall 1: print_int
	syscall                 # printf("%d", GUESS_LEN);

	li	$a0, '\n'
	li	$v0, 11         # syscall 11: print_char
	syscall                 # printf("\n");


	# printf("Valid guesses: 1-%d\n", GUESS_CHOICES);
	la	$a0, valid_guesses_str
	li	$v0, 4          # syscall 4: print_string
	syscall                 # printf("Valid guesses: 1-");

	li	$a0, GUESS_CHOICES
	li	$v0, 1          # syscall 1: print_int
	syscall                 # printf("%d", GUESS_CHOICES);

	li	$a0, '\n'
	li	$v0, 11         # syscall 11: print_char
	syscall                 # printf("\n");


	# printf("How many turns: %d\n\n", MAX_TURNS);
	la	$a0, number_turns_str
	li	$v0, 4          # syscall 4: print_string
	syscall                 # printf("How many turns: ");

	li	$a0, MAX_TURNS
	li	$v0, 1          # syscall 1: print_int
	syscall                 # printf("%d", MAX_TURNS);

	li	$a0, '\n'
	li	$v0, 11         # syscall 11: print_char
	syscall                 # printf("\n");
	syscall                 # printf("\n");

	li 	$s0, 0		# int random_seed; $s0 = random_seed

	la   	$a0, enter_seed_str
	li   	$v0, 4		# syscall 4: print_string
	syscall            	# printf(Enter a random seed: ")

    	li    	$v0, 5    
    	syscall            	# scanf("%d", &random_seed)
    	move  	$s0, $v0     	# move random seed to $s0

    	move  	$a0, $s0     	# seed_rand(random_seed)
    	jal   	seed_rand    	#
    	move  	$s0, $v0      	# $s0 = random_seed after seed_rand function

	jal 	play_game

main__epilogue:
	pop	$ra             # $raS
	end                     # ends the current stack frame

	li	$v0, 0
	jr	$ra             # return 0;




########################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $s0 ]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7  ]
	#
	# Locals:
	# 	- int turn = $s0
	#	- int i = $t0
	#	- int turn_status = $t7
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body
	#	-> loop
	# 	-> end_loop
	#	-> print_loop
	# 	-> end_print_loop
	#   -> [epilogue]

play_game__prologue:
	begin 
	push	$ra 
	push	$s0

play_game__body:
	jal 	generate_solution # generate_solution();

	li	$s0, 0		# int turn = $s0 = 0
loop_play_game:
	bge 	$s0, MAX_TURNS, end_loop_play_game	# turn < MAX_TURNS;

	move 	$a0, $s0	# move turn(in $s0) into $a0
	jal 	play_turn	# play_turn(turn)
	move	$t7, $v0	# turn_status = play_turn(turn)
	
	# if (turn_status == TURN_WIN) {
        # return;
	beq	$t7, TURN_WIN, play_game__epilogue

	addi 	$s0, $s0, 1	# turn++;
	j 	loop_play_game	# }
end_loop_play_game: 
	la	$a0, you_lost_str
	li	$v0, 4          # syscall 4: print_string
	syscall			# printf("You lost! The secret codeword was: ");

	li 	$t0, 0		# int i = 0
start_print_loop_play_game:
	# for (int i = 0; i < GUESS_LEN; i++) 
	bge	$t0, GUESS_LEN, end_print_loop_play_game

	mul  	$t1, $t0, 4    	# calculate offset from i * 4 = $t1
    	la   	$t2, correct_solution  
    	add  	$t3, $t1, $t2  	# $t3 = &correct_solution[t0]
    	lw   	$t6, ($t3)     	# $t6 = correct_solution[t0]
	
	move 	$a0, $t6	# printf("%d ", correct_solution[i]);
	li	$v0, 1
	syscall

	li   	$a0, 32     	# printf(" ", '\n'); print whitespace
	li   	$v0, 11
    	syscall  
	
	addi	$t0, $t0, 1	# i++;
	j 	start_print_loop_play_game

end_print_loop_play_game: 
	li   	$a0, '\n'      #   printf("%c", '\n');
	li   	$v0, 11
    	syscall  

play_game__epilogue:
	pop	$s0
	pop	$ra
	end
	jr	$ra             # return;

########################################################################
# .TEXT <generate_solution>
.text
generate_solution:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$v0, $a0,  $t1, $t2, $t3, $s0 ]
	# Clobbers: [$v0, $a0,  $t1, $t2, $t3 ]
	#
	# Locals:
	#   - int i = $s0
	#
	# Structure:
	#   generate_solution
	#   -> [prologue]
	#   -> body
	#	-> loop
	#   -> [epilogue]

generate_solution__prologue:
	begin
	push 	$ra
	push	$s0
	push	$s1

generate_solution__body:
	li	$s0, 0		# int i = 0 
loop_generate_solution:
	bge 	$s0, GUESS_LEN, generate_solution__epilogue	# i < GUESS_LEN

	li 	$a0, GUESS_CHOICES
	jal 	rand
	move 	$s1, $v0	# $s0 = rand(GUESS_CHOICES)

	addi	$s1, $s1, 1	# $t6 = rand(GUESS_CHOICES) + 1

	mul	$t1, $s0, 4
	la	$t2, correct_solution
	add 	$t3, $t1, $t2  	# $t3 = &correct_solution[i]
    	sw  	$s1, ($t3)     	# $t5 = correct_solution[i]

	addi	$s0, $s0, 1	# i++
	j loop_generate_solution	# }
generate_solution__epilogue:
	pop 	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra             # return;



########################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:
	#   	- $a0: int
	# Returns:
	#    	- $v0: int 
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$v0, $a0, $s0, $s1, $s2]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   	- int correct_place = $s0
	#	- int incorrect_place = $s1
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> body
	#	-> if
	# 	-> continue_play
	#   -> [epilogue]

play_turn__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push	$s2

play_turn__body:
	move 	$s2, $a0		# put original $a0 (turn) in $t0
	addi	$s2, $s2, 1		# turn + 1
	
	la	$a0, turn_str_1
	li	$v0, 4          	# syscall 4: print_string
	syscall                 	# printf("---[ Turn");

	move	$a0, $s2
	li	$v0, 1			# syscall 1: print_integer
	syscall                 	# printf("%d", correct_place);

	la	$a0, turn_str_2
	li	$v0, 4          	# syscall 4: print_string
	syscall                 	# printf("]---\n");

	la	$a0, enter_guess_str
	li	$v0, 4          	# syscall 4: print_string
	syscall                	 	# printf("Enter your guess: ");


	jal 	read_guess		# read_guess();

	jal 	copy_solution_into_temp	# copy_solution_into_temp();

	jal 	calculate_correct_place	# calculate_correct_place();
	move 	$s0, $v0		# int correct_place  = calculate_correct_place();

	jal 	calculate_incorrect_place # calculate_incorrect_place();
	move 	$s1, $v0		# int incorrect_place = calculate_incorrect_place();

if_play_turn: 
	# if (correct_place == GUESS_LEN)
	bne 	$s0, GUESS_LEN, continue_play_turn

	la	$a0, you_win_str
	li	$v0, 4          	# syscall 4: print_string
	syscall                 	# printf("You win, congratulations!");

	li 	$v0, TURN_WIN		# return TURN_WIN;

	j 	play_turn__epilogue	# jump to epilogue to return function

continue_play_turn:
	la	$a0, correct_place_str
	li	$v0, 4          # syscall 4: print_string
	syscall                 # printf("Correct guesses in correct place: ");

	move	$a0, $s0        # syscall 1: print_int
	li	$v0, 1
	syscall                 # printf("%d", correct_place);

	li	$a0, '\n'
	li	$v0, 11         # syscall 11: print_char
	syscall                 # printf("\n");

	la	$a0, incorrect_place_str
	li	$v0, 4          # syscall 4: print_string
	syscall                 # printf("Correct guesses in incorrect place: ")

	move	$a0, $s1        # syscall 1: print_int
	li	$v0, 1
	syscall                 # printf("%d", incorrect_place);


	li	$a0, '\n'
	li	$v0, 11         # syscall 11: print_char
	syscall                 # printf("\n");

	li 	$v0, TURN_NORMAL #return TURN_NORMAL;

play_turn__epilogue:
	pop	$s2
	pop 	$s1
	pop	$s0
	pop 	$ra
	end
	jr	$ra             # return;


########################################################################
# .TEXT <read_guess>
.text
read_guess:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	# Clobbers: [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - n_guess = $t0
	#   - guess = $t1
	# Structure:
	#   read_guess
	#   -> [prologue]
	#   -> body
	#	-> loop
	#   -> [epilogue]

read_guess__prologue:
	begin
	push 	$ra
read_guess__body:
	li	$t0, 0			# int n_guess = 0
loop_read_guess:
	# while ( n_guess < GUESS_LEN )
	bge  	$t0, GUESS_LEN, read_guess__epilogue  

    	li   	$v0, 5         		# scanf("%d", &numbers[i]);
    	syscall

    	mul  	$t1, $t0, 4    		# calculate &numbers[i]
    	la   	$t2, current_guess 
    	add  	$t3, $t1, $t2  		
    	sw   	$v0, ($t3)     		# store scanned number into current_guess[]

    	move 	$t4, $v0       		# final_number = numbers[i]

    	addi 	$t0, $t0, 1    		# n_guess++;
    	j    	loop_read_guess         # }

read_guess__epilogue:
	pop	$ra
	end
	jr	$ra            		# return;

########################################################################
# .TEXT <copy_solution_into_temp>
.text
copy_solution_into_temp:
	# Args:     void
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - int i = $t0
	#
	# Structure:
	#   copy_solution_into_temp
	#   -> [prologue]
	#   -> body
	# 	-> loop
	#   -> [epilogue]

copy_solution_into_temp__prologue:
	begin
	push 	$ra
	push 	$s0
copy_solution_into_temp__body:
	li 	$t0, 0			# int i = $t0
copy_solution_loop: 
	#	i < GUESS_LEN;
	bge	$t0, GUESS_LEN, copy_solution_into_temp__epilogue

	mul  	$t1, $t0, 4    		# calculate offset from i * 4 = $t1
    	la   	$t2, correct_solution  	
    	add  	$t3, $t1, $t2  		
    	lw   	$s0, ($t3)     		#   $s0 = correct_solution[t0]
	
    	la   	$t4, solution_temp  	
    	add  	$t3, $t1, $t4  		# store correct_solution 
    	sw   	$s0, ($t3)     		# into current_guess[t0]

	addi	$t0, $t0, 1		# i++
	j	copy_solution_loop	# }


copy_solution_into_temp__epilogue:
	pop	$s0
	pop	$ra
	end
	jr	$ra             # return;




########################################################################
# .TEXT <calculate_correct_place>
.text
calculate_correct_place:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8 ]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7  ]]
	#
	# Locals:
	#  	- guess_index = $t0
	#	- total = $t8
	# 	- guess = $t4
	#
	# Structure:
	#   calculate_correct_place
	#   -> [prologue]
	#   -> body
	#	-> loop
	#	-> if
	#	-> skip_if
	#	-> loop end
	#   -> [epilogue]

calculate_correct_place__prologue:
	begin
	push 	$ra
calculate_correct_place__body:

	# TODO ... complete this function
	li	$t0, 0 		# int guess_index = 0 
	li 	$t8, 0		# int total = 0;
calculate_correct_loop: 
	bge 	$t0, GUESS_LEN, calculate_correct_loop_end

	li	$t4, 0		# int guess = $t4 (initialise)

	mul  	$t1, $t0, 4    	# calculate offset from i * 4 = $t1
    	la   	$t2, current_guess  #
    	add  	$t3, $t1, $t2  	#
    	lw   	$s1, ($t3)     	# int guess = current_guess[guess_index];
	    
	la   	$t5, solution_temp  #
    	add  	$t6, $t1, $t5  	#
    	lw   	$s2, ($t6)     	# t7 = solution_temp[guess_index];

calculate_correct_if: 
	bne	$s1, $s2, calculate_correct_skip_if
	addi	$t8, $t8, 1	# total++;

	li	$t7, NULL_GUESS
	sw	$t7, ($t3)
	sw	$t7, ($t6)

calculate_correct_skip_if:
	addi	$t0, $t0, 1
	j	calculate_correct_loop

calculate_correct_loop_end: 
	move 	$v0, $t8

calculate_correct_place__epilogue:
	pop	$ra
	end
	jr	$ra             # return;

########################################################################
# .TEXT <calculate_incorrect_place>
.text
calculate_incorrect_place:
	# Args:     void
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $s0, $s1, $s2]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7]
	#
	# Locals:
	#   	- int guess = $s1
	#   	- int guess_index = $t0
	#   	- int total = $s0
	#   	- int solution_index = $t4
	#
	# Structure:
	#   calculate_incorrect_place
	#   -> [prologue]
	#   -> body
	# 	-> loop_outer
	#	-> if_outer
	#	-> loop_inner
	#	-> if_inner
	#	-> if_inner_end
	#	-> if_outer_end
	#	-> loop_outer_end
	#   -> [epilogue]

calculate_incorrect_place__prologue:
	begin
	push 	$ra
	push 	$s0
	push	$s1
	push 	$s2
calculate_incorrect_place__body:
	li	$s0, 0			# int total = 0
	li	$t0, 0			# int guess_index = 0;
calculate_incorrect_loop_outer:
	# guess_index < GUESS_LEN;
	bge	$t0, GUESS_LEN, calculate_incorrect_loop_outer_end

	li	$t4, 0			# int guess = $t4 (initialise)

	mul  	$t1, $t0, 4    		# calculate offset from i * 4 = $t1
    	la   	$t2, current_guess  	#
    	add  	$t3, $t1, $t2  		#
    	lw   	$s1, ($t3)     		# int guess = current_guess[guess_index];

calculate_incorrect_if_outer: 
	# if (guess != NULL_GUESS)
	beq	$s1, NULL_GUESS, calculate_incorrect_if_outer_end
	
	li	$t4, 0			# int solution_index = 0;
calculate_incorrect_loop_inner:
	# solution_index < GUESS_LEN
	bge	$t4, GUESS_LEN, calculate_incorrect_if_outer_end

	# get solution_temp[solution_index]
	mul	$t5, $t4, 4
	la   	$t6, solution_temp  	#
    	add  	$t7, $t5, $t6  		#
    	lw   	$s2, ($t7)     		# s2 = solution_temp[solution_index]

calculate_incorrect_if_inner: 
	# if (solution_temp[solution_index] == guess)
	bne	$s2, $s1, calculate_incorrect_if_inner_end

	# total++;
	addi	$s0, $s0, 1

	# solution_temp[solution_index] = NULL_GUESS;
	li	$t8, NULL_GUESS		 	
	sw	$t8, ($t7)

	# break
	j	calculate_incorrect_if_outer_end
calculate_incorrect_if_inner_end:

	addi	$t4, $t4, 1		#solution_index++
	j	calculate_incorrect_loop_inner	# }

calculate_incorrect_if_outer_end:	
	addi	$t0, $t0, 1		# guess_index++
	j	calculate_incorrect_loop_outer # }
calculate_incorrect_loop_outer_end:
	move	$v0, $s0		# return total;

calculate_incorrect_place__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra            	 	# return;





########################################################################
####                                                                ####
####        STOP HERE ... YOU HAVE COMPLETED THE ASSIGNMENT!        ####
####                                                                ####
########################################################################

##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following.
## But you may find it useful to read through.
## You'll be calling these functions from your code.
##


########################################################################
# .DATA
# DO NOT CHANGE THIS DATA SECTION
.data

# int random_seed;
.align 2
random_seed:		.space 4


########################################################################
# .TEXT <seed_rand>
# DO NOT CHANGE THIS FUNCTION
.text
seed_rand:
	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:    []
	# Uses:     [$a0, $t0]
	# Clobbers: [$t0]
	#
	# Locals:
	# - $t0: offline_seed
	#
	# Structure:
	#   seed_rand

	li	$t0, OFFLINE_SEED # const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0          # random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra               # return;




########################################################################
# .TEXT <rand>
# DO NOT CHANGE THIS FUNCTION
.text
rand:
	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	# - $t0: random_seed
	#
	# Structure:
	#   rand

	lw	$t0, random_seed  # unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995   # rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345        # rand += 12345;
	sw	$t0, random_seed  # random_seed = rand;

	remu	$v0, $t0, $a0     # rand % n
	jr	$ra               # return;
