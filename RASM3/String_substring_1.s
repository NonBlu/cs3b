//================================================================================
//Programmer: Aiden Sallows
//String_substring_1
//Purpose: Returns a string consisting of characters from substring of the passed
//         string starting with beginIndex and ending with endIndex
//Date Last Modified: April 8th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ X2: Must point to an integer
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_substring_1

.text
String_substring_1:
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
    //move beginindex value to x21
    mov     x21, x1
    //move endindex value to x22
    mov     x22, x2

    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,fail
    //else
    //Now x0 contains the length of our string
    mov     x23,x0  //copy the value of stringlength into x21
    
    //check to see if begin or end index is bigger than stringlength -1
    cmp     x23,x21 
    ble     fail

    cmp     x23,x22 
    ble     fail

    //now check to see if indexes are positive
    cmp     x21,#0
    ble     fail

    cmp     x22,#0
    ble     fail

    //now check that x22 is greater than x21
    cmp     x22,x21 
    blt     fail 

    //indexes are good!!!
    //calculate length needed for newly allocated string
    sub     x23,x22,x21

    mov     x0,x23

    bl      malloc //branch and link to malloc

    mov     x24,x0 //copy address of new allocated memory to x22
    
beginIndexLoop:
    ldrb    w25,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop

copyLoop:
    //Now we can finally load our string into allocated space
    ldrb    w25,[x20],#1 //load first character into x23
    str     x25,[x24],#1 //store that character into current index of allocated space
    sub     x23,x23,#1 //decrement string length until 0
    
    cmp     x23,#0 //exit when string length is 0
    bne     copyLoop

    mov     x25,#0
    str     x25,[x24] //store null at the end of the string

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
