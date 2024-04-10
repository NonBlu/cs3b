//================================================================================
//Programmer: Aiden Sallows
//String_equalsIgnoreCase
//Purpose: Calculates if two strings are equivalent, regardless of case
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_equalsIgnoreCase

.text
String_equalsIgnoreCase:
    //Preserve r19->r29 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!
    stp X23, X24, [SP, #-16]!
    stp X25, X26, [SP, #-16]!
    stp X27, X28, [SP, #-16]!
    stp X29, LR,  [SP, #-16]!

    //set stack frame
    mov     x29, SP
    //move string1 value to x20, our string register
    mov     x20, x0
    //Now grab first character value of our string1 and store into X21
    ldrb    w21, [x20]
    
    //move string1 value to x20, our string register
    mov     x22, x1
    //Now grab first character value of our string1 and store into X21
    ldrb    w23, [x22]
    

    until_null_loop:
        
        //check if both values are zero
        cmp     w21,w23
        beq     checkZero
        //else cont
        b       notZero
        checkZero:
            cbz     w21, return_true //is our character of string1 == null? jump to return_true if true
        //if both values were zero, then returned true
        notZero:
            //ELSE
            //Now check if the character is an Uppercase letter (between ASCII x65 and x90)
            cmp     w21,#65
            blt     checkY
            //character may be uppercase
            cmp     w21,#90
            ble     add_32X
            //character is not uppercase
            checkY:
                //Now check if the character is an Uppercase letter (between ASCII x65 and x90)
                cmp     w23,#65
                blt     continue
                //character may be uppercase
                cmp     w23,#90
                ble     add_32Y
                //character is not uppercase
            continue:
                cmp     w21,w23
                bne     return_false //if characters are not equals, return false

                //else, characters were the same
                //grab next character of both strings
                ldrb W21, [X20], #1
                ldrb W23, [X22], #1
                //loop
                b until_null_loop

    add_32X:
        //character is uppercase in string 1
        add     w21,w21,#32
        b       checkY
    add_32Y:
        //character is uppercase in string 2
        add     w23,w23,#32
        b       continue
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
    