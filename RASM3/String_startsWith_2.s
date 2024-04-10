//================================================================================
//Programmer: Aiden Sallows
//String_startsWith_1
//Purpose: Calculates if String 1 starts with String 2 
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_startsWith_2

.text
String_startsWith_2:
    //Preserve r19->r29 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!
    stp X23, X24, [SP, #-16]!
    stp X25, X26, [SP, #-16]!
    stp X27, X28, [SP, #-16]!
    stp X29, LR,  [SP, #-16]!

    //set stack frame
    mov     x29, SP
    //move string1 value to x20
    mov     x20, x0
    //move string2 value to x22
    mov     x22, x1

    //we want to find string length of string2
    mov     x0, x22
    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,return_false
    //else
    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21

//Now we check compare character of both strings
    ldrb    w24,[x20],#1
    ldrb    w25,[x22],#1
until_null_loop:
        cmp     w24,w25
        bne     return_false //if characters are not equals, return false

        sub     x21,x21,#1
        //check to see if string2 is empty
        cmp     x21,#0 //is our character of string2 == null? jump to return_true if true
        beq     return_true
        //else, characters were the same
        //grab next character of both strings
        ldrb W24, [X20], #1
        ldrb W25, [X22], #1
        //loop
        b until_null_loop

    return_false:
        mov     x0,#0 //return 1 to represent true
        b       exit
    return_true:
        mov     x0,#1 //return 1 to represent true
        b       exit

exit:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    