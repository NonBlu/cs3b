//================================================================================
//Programmer: Aiden Sallows
//String_length
//Purpose: Calculates the length of a string function
//Date Last Modified: March 26th, 2024
//================================================================================
// @ Subroutine String_length: Provided a pointer to a null terminated string, String_length will 
// @      return the length of the string in X0
// @ X0: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

// Assemble the external function: as -g -o ../obj/String_length.o String_length.s
// Link the external function to your driver: ld -o lab12 driver.o ../obj/String_length.o
.global String_length

.text
String_length:
    //Preserve r19->r29 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!
    stp X23, X24, [SP, #-16]!
    stp X25, X26, [SP, #-16]!
    stp X27, X28, [SP, #-16]!
    stp X29, LR,  [SP, #-16]!

    //set stack frame
    mov X29, SP
    //set x19 to be our counter 
    mov X19, #0
    //move string value to x20, our string register
    mov X20, X0
    //Now grab first character value of our string and store into X21
    ldrb W21, [X20]

    until_null_loop:

        cmp W21, #0 //is our character == null?
        beq continue //exit loop if true

        //ELSE
        add x19,x19,#1 //incrememnt x19
        //grab next character
        ldrb W21, [X20], #1
        //loop
        b until_null_loop

    continue:
        //if we exited, x19 will be one more than the length of the string
        sub x19,x19,#1 //decrement x19
        mov x0,x19 //now take int value of string length and move into x0

exit:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    