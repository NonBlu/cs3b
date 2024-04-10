//================================================================================
//Programmer: Aiden Sallows
//String_endsWith
//Purpose: Calculates if String 1 contains String 2 at the given index
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_endsWith

.text
String_endsWith:
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
    //move string2 value to x21
    mov     x22, x1

    //first identify the length of string1
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,return_false
    //else
    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21

    //identify the length of string2
    mov     x0,x22
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,return_false
    //else
    //Now x0 contains the length of our string
    mov     x23,x0  //copy the value of stringlength into x23
    
    //check to see if string2 is larger than string1
    cmp     x23,x21
    bgt     return_false

    //we are good!!!
    //run this loop until x23 is 0
    //we need to set 23 to equal 21 - 23
    sub     x23,x21,x23
beginIndexLoop:
    ldrb    w24,[x20],#1 //load character into x23
    sub     x23,x23,#1 //decrememnt begin index
    
    cmp     x23,#0 //run until 0
    bne     beginIndexLoop

//Now we check compare character of both strings
    ldrb    w24,[x20],#1
    ldrb    w25,[x22],#1
until_null_loop:
        cmp     w24,w25
        bne     return_false //if characters are not equals, return false
        cbz     w24, return_true //is our character of string1 == null? jump to return_true if true
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
    