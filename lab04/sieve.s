# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# t0 = i, t2 = price, t3 = pointer, , t4 = 1
main:

    # PUT YOUR CODE
    li $t0, 0           # int i = 0
    li $t4, 0
loop_init: 
    bge  $t0, 1000, end_loop_init

    li   $t4, 1

    #mul  $t1, $t0, 1    #   calculate &numbers[i]
    la   $t2, prime     #
    add  $t3, $t0, $t2  #   t3 = &numbers[i]
    sb   $t4, ($t3)     #   load numbers[i] into $a0

    addi $t0, $t0, 1    # i++;
    
    j loop_init         # }

end_loop_init: 

    li $t0, 2           # i = 2
loop1:
    bge $t0, 1000, end

    #mul $t1, $t0, 1
    la  $t2, prime
    add $t3, $t0, $t2
    lb  $t4, 0($t3)  

    beq $t4, 0, end_loop2

    move  $a0, $t0     
    li  $v0, 1          # printf("%d"); 
    syscall

    li   $a0, '\n'      # printf("%c", '\n'); 
    li   $v0, 11
    syscall

    li $t5, 2           #  int j = t5 = 2
    mul $t5, $t5, $t0   #  int j = 2 * i;
loop2:
    bge $t5, 1000, end_loop2
    li   $t8, 0         # t4 = 0

    #mul  $t6, $t5, 1    #   calculate &numbers[j]
    la   $t9, prime     #
    add  $t7, $t5, $t9  #   t3 = &numbers[i]
    sb   $t8, ($t7)     #   load numbers[i] into $a0

    add $t5, $t5, $t0   # j = j + i 

    j loop2                #}
end_loop2:

    addi $t0, $t0, 1
    j loop1
end:
    li $v0, 0           # return 0
    jr $31

.data
prime:
    .space 1000