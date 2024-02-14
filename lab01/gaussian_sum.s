#
# COMP1521 lab exercise sample solution
#
# A simple MIPS program that calculates the Gaussian sum between two numbers
# Written 12/2/2022
# by Dylan Brotherston (d.brotherston@unsw.edu.au)



main:


  la    $a0, prompt1   #printf "enter new number"
  li    $v0, 4
  syscall

  li    $v0, 5       # scanf("%d", number);
  syscall

  move  $t1, $v0     #move the number

  la    $a0, prompt2   #printf "enter second number"
  li    $v0, 4
  syscall

  li    $v0, 5       # scanf("%d", number);
  syscall

  move  $t2, $v0     #move the second number

  sub   $t3, $t2, $t1     #subtract no.2 - no.1
  addi  $t3, $t3, 1       #add 1

  add   $t4, $t1, $t2     #add together (the second section)
  
  mul   $t5, $t3, $t4    #final printed number
  div   $t5, $t5, 2

  la    $a0, answer1  #printf answer 1
  li    $v0, 4
  syscall

  move   $a0, $t1        #   printf("%d", 42); testing
  li     $v0, 1
  syscall

  la    $a0, answer2  #printf answer 1
  li    $v0, 4
  syscall 

  move   $a0, $t2        #   printf("%d", 42); testing
  li     $v0, 1
  syscall

  la    $a0, answer3  #printf answer 1
  li    $v0, 4
  syscall

  move   $a0, $t5        #   printf("%d", 42); testing
  li     $v0, 1
  syscall

  li   $a0, '\n'        #   printf("%d", 42); testing
  li     $v0, 11
  syscall


#end
  li   $v0, 0
  jr   $ra          # return


.data
  prompt1: .asciiz "Enter first number: "
  prompt2: .asciiz "Enter second number: "

  answer1: .asciiz "The sum of all numbers between "
  answer2: .asciiz " and "
  answer3: .asciiz " (inclusive) is: "
