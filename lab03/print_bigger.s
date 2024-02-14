# Read 10 numbers into an array
# then print the numbers which are
# larger than the final number read.

# i in register $t0
# registers $t1, $t2 & $t3 used to hold temporary results

main:

    li   $t0, 0         # i = 0
loop0:
    bge  $t0, 10, end0  # while (i < 10) {

    li   $v0, 5         #   scanf("%d", &numbers[i]);
    syscall             #

    move $t4, $v0       #   final_number = numbers[i] (t4 = final numbers)

    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #   
    sw   $v0, ($t3)     #   store entered number in arra
    
    

    addi $t0, $t0, 1    #   i++;
    j    loop0          # }
end0:


    li   $t0, 0         # i = 0
loop1:
    bge  $t0, 10, end1  # while (i < 10) {
    
   # move  $a0, $t4              # printf("%d"); testing
   # li    $v0, 1
    #syscall

    #ble  $t0, $t4, print_numbers #  if numbers[i] >= final_number



    mul  $t1, $t0, 4    #   calculate &numbers[i]
    la   $t2, numbers   #
    add  $t3, $t1, $t2  #   $t3 = &numbers[i]
    lw   $t5, ($t3)     #   $t5 = numbers[i]

    blt  $t5, $t4, do_not_print_numbers #  if numbers[i] >= final_number
   
    lw   $a0, ($t3)
    li   $v0, 1         #   printf("%d", numbers[i])
    syscall

    li   $a0, '\n'      #   printf("%c", '\n');
    li   $v0, 11
    syscall  
   
    #addi $t0, $t0, 1    #   i++
    sw   $t5, ($t3)

do_not_print_numbers:

    addi $t0, $t0, 1    #   i++

    j    loop1          # }
    move  $a0, $t4              # printf("%d"); testing
    li    $v0, 1
    #syscall

end1:

    jr   $ra              # return

.data

numbers:
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # int numbers[10] = {0};
