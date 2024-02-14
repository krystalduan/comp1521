# Read 10 numbers into an array
# print 0 if they are in non-decreasing order
# print 1 otherwise

# i in register $t0

main:

    li   $t0, 0         # i = 0
loop0:
    bge  $t0, 10, end0  # while (i < 10) {

    li   $v0, 5         #   scanf("%d", &numbers[i]);
    syscall             #

    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #
    sw   $v0, ($t3)     #   store entered number in array

    addi $t0, $t0, 1    #   i++;
    j    loop0          # }
end0:
    li  $t9, 0          # int swapped = 0;
    li  $t0, 1          #int = 1

loop1:
    bge $t0, 10, end1
    mul  $t1, $t0, 4     #
    la   $t2, numbers  
    add $t3, $t1, $t2   #$t3 = &numbers[i]
    lw  $t4, ($t3)      #$t4, x = numbers[i]


    li  $t5, 1          # $t5 = i 
    sub $t5, $t0, $t5   # $t5 = i - 1
    mul $t6, $t5, 4     
    add $t7, $t6, $t2   #t6 = &numbers[i-1]

    lw  $t8, ($t7)       #t8 = numbers[i-1]

    move $a0, $t7       # printf("%d", 42)  testing
    li   $v0, 1         #
    syscall

    li   $a0, '\n'      # printf("%c", '\n');
    li   $v0, 11
    syscall

    bge $t4, $t8, skip
    li $t9, 1

skip: 
    addi $t0, $t0, 1
    j loop1


    # PUT YOUR CODE HERE



end1:

    move   $a0, $t9       # printf("%d", 42)
    li   $v0, 1         #
    syscall

    li   $a0, '\n'      # printf("%c", '\n');
    li   $v0, 11
    syscall

    jr   $ra

.data

numbers:
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # int numbers[10] = {0};
