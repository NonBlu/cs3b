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

    //set stack frame
    mov     x29, SP
    //move string value to x20, our string register
    mov     x20, x0

    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,exit
    //else

    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21
    
    //now that we know the length of the  string, allocate the memory
    bl      malloc //branch and link to malloc

    mov     x22,x0 //copy address of new allocated memory to x22

copyLoop:
    //Now we can finally load our string into allocated space
    ldrb    w23,[x20],#1 //load first character into x23
    str     x23,[x22],#1 //store that character into current index of allocated space
    sub     x21,x21,#1 //decrement string length until 0
    
    cmp     x21,#0 //exit when string length is 0
    bne     copyLoop

    mov     x23,#0
    str     x23,[x22] //store null at the end of the string

exit:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    