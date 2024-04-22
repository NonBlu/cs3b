//================================================================================
//Programmer: Aiden Sallows
//String_copy
//Purpose: Allocates new memory for a string variable and stores it to that memory
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_copy

.text
String_copy:
    //Preserve r19->r29 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!
    stp X23, X24, [SP, #-16]!
    stp X25, X26, [SP, #-16]!
    stp X27, X28, [SP, #-16]!
    stp X29, LR,  [SP, #-16]!

    //we preserve the LR due to BL Malloc
    str     x30, [SP,#-16]! //push LR

    str     x0, [SP,#-16]! //push x0 onto the stack

    //get string length of source

    bl      String_length

    //x0 + 1 is the number of bytes need to malloc
    add     x0,x0,#1
    str     x0,[SP,#-16]! //push x0 onto the stack, saved_length +1

    bl      malloc

    //now x0 points to newly allocated space

    ldr     x20, [SP], #16 //popped length of src string+1
    ldr     x21, [SP], #16 //popped & src string
    mov     x22,x0 //move x0 into x22

copyLoop:
    //Now we can finally load our string into allocated space
    cmp     x20,#0 //exit when string length is 0
    beq     exit

    ldrb    w23,[x21],#1 //load first character into x23
    strb    w23,[x22],#1 //store that character into current index of allocated space
    sub     x20,x20,#1 //decrement string length until 0
    
    b       copyLoop

exit:
    //now restore preserved registers and return
    ldr x30, [SP], #16
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret lr//return
    