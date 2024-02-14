# read a mark and print the corresponding UNSW grade

main:
    la   $a0, prompt    # printf("Enter a mark: ");
    li   $v0, 4
    syscall

    li   $v0, 5         # scanf("%d", mark);
    syscall

    move $t0, $v0

    bge $t0, 50, pass

 #fail:
    la   $a0, fl        # printf("FL\n");
    li   $v0, 4
    syscall
    

    b   end

    
#pass 
pass:
    bge $t0, 65, credit
    la   $a0, ps        # printf("PS\n");
    li   $v0, 4
    syscall

   
    b    end

    

credit:
    bge $t0, 75, distinction
    la   $a0, cr        # printf("CR\n");
    li   $v0, 4
    syscall
    b    end

distinction: 
    bge $t0, 85, high_distinction
    la   $a0, dn        # printf("DN\n");
    li   $v0, 4
    syscall
    b    end

 high_distinction: 
    la   $a0, hd        # printf("HD\n");
    li   $v0, 4
    syscall
    b    end

end:
    li   $v0, 0
    jr   $ra            # return 0

.data
    prompt: .asciiz "Enter a mark: "
    fl: .asciiz "FL\n"
    ps: .asciiz "PS\n"
    cr: .asciiz "CR\n"
    dn: .asciiz "DN\n"
    hd: .asciiz "HD\n"

