# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`

main:                 # int main(void)
    la   $a0, prompt1 # printf("Enter the starting number: ");
    li   $v0, 4
    syscall

    li   $v0, 5       # scanf("%d", start);
    syscall

    move $t0, $v0

    la   $a0, prompt2 # printf("Enter the stopping number: ");
    li   $v0, 4
    syscall

    li   $v0, 5       # scanf("%d", stop);
    syscall

    move $t1, $v0

    la   $a0, prompt3 # printf("Enter the step size: ");
    li   $v0, 4
    syscall

    li   $v0, 5       # scanf("%d", step);
    syscall

    move $t2, $v0

#end of initial input section (all good)


    bgt $t1, $t0, pos_loop

    bgt  $t2, $zero, end         #end if the step size is wrong, 0 < step

neg_loop: 
    bgt  $t2, $zero, end     #end if the step size is wrong
    bgt   $t1, $t0, end         # if t1 > t0, then end the loop

    move  $a0, $t0              # printf("%d");
    li    $v0, 1
    syscall

    li   $a0, '\n'              # printf("%c", '\n');
    li   $v0, 11

    add $t0, $t0, $t2
    syscall
    j neg_loop

pos_loop: 
    blt  $t2, $zero, end     #end if the step size is wrong
    blt  $t1, $t0, end      #t1 < t0
    
    #add $t0, $t0, $t2

    move $a0, $t0           # printf("%d");
    li   $v0, 1
    syscall

    li   $a0, '\n'          # printf("%c", '\n');
    li   $v0, 11
    add $t0, $t0, $t2
    syscall

    j pos_loop




end:
    li   $v0, 0
    jr   $ra          # return 0

.data
    prompt1: .asciiz "Enter the starting number: "
    prompt2: .asciiz "Enter the stopping number: "
    prompt3: .asciiz "Enter the step size: "
