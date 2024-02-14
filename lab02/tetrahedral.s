# Read a number n and print the first n tetrahedral numbers
# https://en.wikipedia.org/wiki/Tetrahedral_number

main:                  # int main(void) {

    la   $a0, prompt   # printf("Enter how many: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", number);
    syscall

    move $t0, $v0       #$t0 is now how_many

    li $t1, 1           #$t1 is n =1


  #  li $t2, 0             #$t2 is total
loop: 
    bgt $t1, $t0, end     #$n > how_many, then end
    li $t2, 0             #$t2 is total = 0
    li $t3, 1               #$t3 is j = 1

  #  bgt  $t3, $t1, loop_2

    li $t2, 0             #$t2 is total

#where loop2 should come in

loop_2: 
    bgt   $t3, $t1, print_loop  #j > n, then go to print
    li    $t4, 1           #$t4 is i = 1

   
    
loop_3: 
    bgt $t4, $t3, print_loop_2   #i > j, then go to loop2
    add      $t2, $t2, $t4      # total = total + i;
    addi    $t4, $t4, 1         # i = i + 1;
    
    j loop_3

print_loop_2:
    addi   $t3, $t3, 1         # j = j + 1;
    j loop_2
   

print_loop: 
    move   $a0, $t2        #   printf $total
    li   $v0, 1
    syscall

    li   $a0, '\n'      # printf("%c", '\n');
    li   $v0, 11
    syscall

    addi   $t1, $t1, 1
    j loop



    la   $a0, 67       #   printf $t1
    li   $v0, 1
    syscall

    li   $a0, '\n'      # printf("%c", '\n');
    li   $v0, 11
    syscall



end:
    li   $v0, 0
    jr   $ra           # return 0

.data
    prompt: .asciiz "Enter how many: "
