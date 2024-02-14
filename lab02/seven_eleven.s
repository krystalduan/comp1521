# Read a number and print positive multiples of 7 or 11 < n

main:                  # int main(void) {

    la   $a0, prompt   # printf("Enter a number: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", number);
    syscall

    move $t0, $v0
    li $t1, 1
    
 #while loop    
loop: 
    bge  $t1, $t0, end

    rem $t2, $t1, 7
    beq $t2, 0, true

    rem $t2, $t1, 11
    beq $t2, 0, true
    addi $t1, $t1, 1
    b   loop



true: 
    move   $a0, $t1        #   printf("%d", 42);
    li   $v0, 1
    syscall

    li   $a0, '\n'      # printf("%c", '\n');
    li   $v0, 11
    syscall

    addi $t1, $t1, 1
    b   loop

end:
    li   $v0, 0
    jr   $ra           # return 0

.data
    prompt: .asciiz "Enter a number: "
