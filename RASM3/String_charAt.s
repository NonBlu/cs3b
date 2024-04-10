//================================================================================
//Programmer: Aiden Sallows
//String_substring_2
//Purpose: Returns a character containing the character at the given index within
//         the given string
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_charAt

.text
String_charAt:
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
    //move index value to x21
    mov     x21, x1

    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,fail
    //else
    //Now x0 contains the length of our string
    mov     x22,x0  //copy the value of stringlength into x22
    
    //check to see if index is bigger than stringlength -1
    cmp     x22,x21 
    ble     fail

    //now check to see if index is positive
    cmp     x21,#0
    ble     fail

    //index is good!!!

    //allocated memory for a single character
    mov     x0,#1

    bl      malloc //branch and link to malloc

    mov     x23,x0 //copy address of new allocated memory to x22
    
beginIndexLoop:
    ldrb    w24,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop

copyCharacter:
    //Now we can finally load our string into allocated space
    ldrb    w24,[x20],#1 //load first character into x23
    str     x24,[x23],#1 //store that character into current index of allocated space

    b       exit
fail:
    mov     x0,#0
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
exit:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
