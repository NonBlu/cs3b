//================================================================================
//Programmer: Aiden Sallows
//fact
//Purpose: Calculates n! and returns value in x0
//Date Last Modified: March 26th, 2024
//================================================================================
// @ X0: Must contain an int value n >=0
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global fact

.text
fact:
    //Preserve r19->r29 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!
    stp X23, X24, [SP, #-16]!
    stp X25, X26, [SP, #-16]!
    stp X27, X28, [SP, #-16]!
    stp X29, LR,  [SP, #-16]!

    //Base case where n == 0
    cmp     x0,#0
    b.gt    fact_loop //branch if value is not base case

    //else n == 0
    mov     x0,#1 //multiply returned value by 1
    b       exit

fact_loop:
    
    mov     x19,x0 //saving n to register x19
    sub     x0,x0,#1 //n = n-1

    bl     fact //branch and link to fact
    mul    x0,x0,x19 //once we begin rewinding, multiply each return value by the one previous 

exit:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret     lr//return
    