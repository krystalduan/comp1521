# Recursive factorial function
# n < 1 yields n! = 1
# $s0 is used for n
# we use an s register because the convention is their value
# is preserved across function calls
# f is in $t0

# DO NOT CHANGE THE CODE IN MAIN

main:
    begin              # create stack frame
    push  $ra          # save $ra
    push  $s0          # save $s0

    li   $s0, 0         # int n = 0
    la   $a0, msg1
    li   $v0, 4
    syscall            # printf(Enter n: ")

    li    $v0, 5
    syscall            # scanf("%d", &n)
    move  $s0, $v0

    move  $a0, $s0     # factorial(n)
    jal   factorial    #
    move  $t0, $v0     #

    move  $a0, $s0
    li    $v0, 1
    syscall            # printf ("%d", n)

    la    $a0, msg2
    li    $v0, 4
    syscall            # printf("! = ")

    move  $a0, $t0
    li    $v0, 1
    syscall            # printf ("%d", f)

    li   $a0, '\n'     # printf("%c", '\n');
    li   $v0, 11
    syscall


    pop   $s0          # restore $s0
    pop   $ra          # restore $ra
    end                # clean up stack frame

    jr  $ra

factorial: 
    begin 
    push $ra
    push $s1
    push $s0


    li $s1, 1           # int result
    #move $s0, $a0

    ble $a0, 1, else    # if (n > 1)
if: 
    move $s0, $a0
    addi $a0, $a0, -1   # n - 1
    jal factorial       # factorial(n - 1);
    mul $v0, $v0, $s0   # result = n * factorial(n - 1);
    
    j epilogue
else: 
    li $s1, 1
    move $v0, $s1

epilogue: 
    pop $s0
    pop $s1
    pop $ra
    end
    jr $ra


    .data
msg1:   .asciiz "Enter n: "
msg2:   .asciiz "! = "


# DO NOT CHANGE CODE ABOVE HERE


    .text
#factorial:
    #  ADD CODE TO CREATE STACK FRAME

    # ADD CODE FORFUNCTION HERE

    # ADD CODE TO REMOVE STACK FRAME
    #jr  $ra


  #  move $a0, $s0
   # li   $v0, 1
   # syscall

  #  li   $a0, '\n'     # printf("%c", '\n');
   # li   $v0, 11
   # syscall