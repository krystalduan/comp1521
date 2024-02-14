.data
    prompt_str: .asciiz "Enter a random seed: "
    result_str: .asciiz "The random result is: "

.text
main:
    begin
    push $ra

    # ADD CODE FORFUNCTION HERE

    li   $s0, 1         # int random seed = 0
    la   $a0, prompt_str
    li   $v0, 4
    syscall            # printf(Enter a random seed: ")

    li    $v0, 5    
    syscall            # scanf("%d", &random_seed)
    move  $s0, $v0     # move the random seed to $s0

    move  $a0, $s0     # seed_rand(random_seed)
    jal   seed_rand    #
    move  $s0, $v0      # random_seed after seed_rand function

    li   $a0, 100         
    jal rand
    move $s1, $v0       # value = rand(100)

    move $a0, $s1    
    jal add_rand
    move $s1, $v0       # value = add_rand(value);

    move  $a0, $s1    
    jal sub_rand
    move $s1, $v0       # value = sub_rand(value);
    
    move $a0, $s1         
    jal seq_rand
    move $s1, $v0       # value = seq_rand(value);

    la   $a0, result_str
    li   $v0, 4
    syscall            # printf("The random result is: ")

    move  $a0, $s1
    li    $v0, 1
    syscall            # printf ("%d", value)

    li   $a0, '\n'     # printf("%c", '\n');
    li   $v0, 11
    syscall
    

    # ADD CODE TO REMOVE STACK FRAME
    pop $ra
    end
    jr  $ra

add_rand: 
    begin 
    push $ra
    #push $a0
    push $s0
    push $s1

    move $s1, $a0

    la $a0, 0xFFFF
    jal rand
    move $s0, $v0

    add $v0, $s1, $s0
    
    pop $s1
    pop $s0
    #pop $a0
    pop $ra
    end
    jr $ra

sub_rand:
    begin 
    push $ra

    push $s0
    
    jal rand
    move $s0, $v0
    
    sub $v0, $a0, $s0       # return value - rand(value);

    pop $s0

    pop $ra
    end
    jr $ra


seq_rand: 
    begin 
    push $ra

    push $s0
    push $s1

    move $s1, $a0           # move og $a0 into $s1

    li $a0, 100
    jal rand
    move $s0, $v0           # int limit = rand(100)

    li $t1, 0               # int i = 0

seq_rand_loop:
    bge $t1, $t0, end_seq_rand     

    move $a0, $s1 
    jal add_rand
    move $s1, $v0

    addi $t1, $t1, 1        # t1 ++; 
    j seq_rand_loop

end_seq_rand: 
    move $v0, $s1

    pop $s1
    pop $s0

    pop $ra
    end
    jr $ra
epilogue: 
    
    #pop $ra
   # end
    

##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following.
## But you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
.data

# int random_seed;
.align 2
random_seed:    .space 4


########################################################################
# .TEXT <seed_rand>
.text

# DO NOT CHANGE THIS FUNCTION

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

    li  $t0, OFFLINE_SEED # const unsigned int offline_seed = OFFLINE_SEED;
    xor $t0, $a0          # random_seed = seed ^ offline_seed;
    sw  $t0, random_seed

    jr  $ra               # return;

########################################################################
# .TEXT <rand>
.text

# DO NOT CHANGE THIS FUNCTION

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
    #   - $t0: random_seed
    #
    # Structure:
    #   rand

    lw      $t0, random_seed # unsigned int rand = random_seed;
    multu   $t0, 0x5bd1e995  # rand *= 0x5bd1e995;
    mflo    $t0
    addiu   $t0, 12345       # rand += 12345;
    sw      $t0, random_seed # random_seed = rand;

    remu    $v0, $t0, $a0    #    rand % n
    jr      $ra              # return rand % n;



