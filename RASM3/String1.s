//================================================================================
//Programmer: Aiden Sallows
//String1.s
//Purpose: Contains functions created by member 1 for RASM3
//Date Last Modified: April 10th, 2024
//================================================================================
// @ X0: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
.data

.global String_length
.global String_equals
.global String_equalsIgnoreCase
.global String_copy
.global String_substring_1
.global String_substring_2
.global String_charAt
.global String_startsWith_1
.global String_startsWith_2
.global String_endsWith

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

    until_null_loop_SL:

        cmp W21, #0 //is our character == null?
        beq continue //exit loop if true

        //ELSE
        add x19,x19,#1 //incrememnt x19
        //grab next character
        ldrb W21, [X20], #1
        //loop
        b until_null_loop_SL

exit_string_length:
    //now restore preserved registers and return
    sub x19,x19,#1 //decrement x19
    mov x0,x19 //now take int value of string length and move into x0
    
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    
//================================================================================
//Programmer: Aiden Sallows
//String_equals
//Purpose: Calculates if two strings are equivalent
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.

String_equals:
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

    until_null_loop_SEQ:
        
        //ELSE
        cmp     w21,w23
        bne     return_false_SEQ //if characters are not equals, return false
        cbz     w21, return_true_SEQ //is our character of string1 == null? jump to return_true if true
        //else, characters were the same
        //grab next character of both strings
        ldrb W21, [X20], #1
        ldrb W23, [X22], #1
        //loop
        b until_null_loop_SEQ

    return_false_SEQ:
        mov     x0,#0 //return 1 to represent true
        b       exit_SEQ
    return_true_SEQ:
        mov     x0,#1 //return 1 to represent true
        b       exit_SEQ

exit_SEQ:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return


//================================================================================
//String_equalsIgnoreCase
//Purpose: Calculates if two strings are equivalent, regardless of case
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    

    until_null_loop_SEQ_IG:
        
        //check if both values are zero
        cmp     w21,w23
        beq     checkZero_SEQ_IG
        //else cont
        b       notZero_SEQ_IG
        checkZero_SEQ_IG:
            cbz     w21, return_true //is our character of string1 == null? jump to return_true if true
        //if both values were zero, then returned true
        notZero_SEQ_IG:
            //ELSE
            //Now check if the character is an Uppercase letter (between ASCII x65 and x90)
            cmp     w21,#65
            blt     checkY_SEQ_IG
            //character may be uppercase
            cmp     w21,#90
            ble     add_32X_SEQ_IG
            //character is not uppercase
            checkY_SEQ_IG:
                //Now check if the character is an Uppercase letter (between ASCII x65 and x90)
                cmp     w23,#65
                blt     continue_SEQ_IG
                //character may be uppercase
                cmp     w23,#90
                ble     add_32Y_SEQ_IG
                //character is not uppercase
            continue_SEQ_IG:
                cmp     w21,w23
                bne     return_false //if characters are not equals, return false

                //else, characters were the same
                //grab next character of both strings
                ldrb W21, [X20], #1
                ldrb W23, [X22], #1
                //loop
                b until_null_loop_SEQ_IG

    add_32X_SEQ_IG:
        //character is uppercase in string 1
        add     w21,w21,#32
        b       checkY_SEQ_IG
    add_add_32Y_SEQ_IG32Y:
        //character is uppercase in string 2
        add     w23,w23,#32
        b       continue_SEQ_IG
    return_falseSEQ_IG:
        mov     x0,#0 //return 1 to represent true
        b       exitSEQ_IG
    return_trueSEQ_IG:
        mov     x0,#1 //return 1 to represent true
        b       exitSEQ_IG

exitSEQ_IG:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    

//================================================================================
//String_copy
//Purpose: Allocates new memory for a string variable and stores it to that memory
//================================================================================
// @ X0: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    cbz     x0,exit_STCP
    //else

    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21
    
    //now that we know the length of the  string, allocate the memory
    bl      malloc //branch and link to malloc

    mov     x22,x0 //copy address of new allocated memory to x22

copyLoop_STCP:
    //Now we can finally load our string into allocated space
    ldrb    w23,[x20],#1 //load first character into x23
    str     x23,[x22],#1 //store that character into current index of allocated space
    sub     x21,x21,#1 //decrement string length until 0
    
    cmp     x21,#0 //exit when string length is 0
    bne     copyLoop_STCP

    mov     x23,#0
    str     x23,[x22] //store null at the end of the string

exit_STCP:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return

//================================================================================
//String_substring_1
//Purpose: Returns a string consisting of characters from substring of the passed
//         string starting with beginIndex and ending with endIndex
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ X2: Must point to an integer
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    cbz     x0,fail_SUBSTR
    //else
    //Now x0 contains the length of our string
    mov     x23,x0  //copy the value of stringlength into x21
    
    //check to see if begin or end index is bigger than stringlength -1
    cmp     x23,x21 
    ble     fail_SUBSTR

    cmp     x23,x22 
    ble     fail_SUBSTR

    //now check to see if indexes are positive
    cmp     x21,#0
    ble     fail_SUBSTR

    cmp     x22,#0
    ble     fail_SUBSTR

    //now check that x22 is greater than x21
    cmp     x22,x21 
    blt     fail_SUBSTR 

    //indexes are good!!!
    //calculate length needed for newly allocated string
    sub     x23,x22,x21

    mov     x0,x23

    bl      malloc //branch and link to malloc

    mov     x24,x0 //copy address of new allocated memory to x22
    
beginIndexLoop_SUBSTR:
    ldrb    w25,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop_SUBSTR

copyLoop_SUBSTR:
    //Now we can finally load our string into allocated space
    ldrb    w25,[x20],#1 //load first character into x23
    str     x25,[x24],#1 //store that character into current index of allocated space
    sub     x23,x23,#1 //decrement string length until 0
    
    cmp     x23,#0 //exit when string length is 0
    bne     copyLoop_SUBSTR

    mov     x25,#0
    str     x25,[x24] //store null at the end of the string

    b       exit_SUBSTR
fail_SUBSTR:
    mov     x0,#0
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
exit_SUBSTR:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return

//================================================================================
//String_substring_2
//Purpose: Returns a string consisting of characters from substring of the passed
//         string starting with beginIndex.
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
String_substring_2:
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

    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,fail_SUBSTR2
    //else
    //Now x0 contains the length of our string
    mov     x22,x0  //copy the value of stringlength into x22
    
    //check to see if begin or end index is bigger than stringlength -1
    cmp     x22,x21 
    ble     fail_SUBSTR2

    //now check to see if indexes are positive
    cmp     x21,#0
    ble     fail_SUBSTR2

    //index is good!!!
    //calculate length needed for newly allocated string
    sub     x23,x22,x21

    mov     x0,x23

    bl      malloc //branch and link to malloc

    mov     x24,x0 //copy address of new allocated memory to x22
    
beginIndexLoop_SUBSTR2:
    ldrb    w25,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop_SUBSTR2

copyLoop_SUBSTR2:
    //Now we can finally load our string into allocated space
    ldrb    w25,[x20],#1 //load first character into x23
    str     x25,[x24],#1 //store that character into current index of allocated space
    sub     x23,x23,#1 //decrement string length until 0
    
    cmp     x23,#0 //exit when string length is 0
    bne     copyLoop_SUBSTR2

    mov     x25,#0
    str     x25,[x24] //store null at the end of the string

    b       exit_SUBSTR2
fail_SUBSTR2:
    mov     x0,#0
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
exit_SUBSTR2:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return

//================================================================================
//String_charAt
//Purpose: Returns a character containing the character at the given index within
//         the given string
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    cbz     x0,fail_CHAT
    //else
    //Now x0 contains the length of our string
    mov     x22,x0  //copy the value of stringlength into x22
    
    //check to see if index is bigger than stringlength -1
    cmp     x22,x21 
    ble     fail_CHAT

    //now check to see if index is positive
    cmp     x21,#0
    ble     fail_CHAT

    //index is good!!!

    //allocated memory for a single character
    mov     x0,#1

    bl      malloc //branch and link to malloc

    mov     x23,x0 //copy address of new allocated memory to x22
    
beginIndexLoop_CHAT:
    ldrb    w24,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop_CHAT

copyCharacter_CHAT:
    //Now we can finally load our string into allocated space
    ldrb    w24,[x20],#1 //load first character into x23
    str     x24,[x23],#1 //store that character into current index of allocated space

    b       exit_CHAT
fail_CHAT:
    mov     x0,#0
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
exit_CHAT:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return

//================================================================================
//String_startsWith_1
//Purpose: Calculates if String 1 contains String 2 at the given index
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to an integer
// @ X2: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
String_startsWith_1:
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
    //move index value to x21
    mov     x21, x1
    //move string2 value to x22
    mov     x22, x2
    //first identify the length of string
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,return_false_STRT1
    //else
    //Now x0 contains the length of our string
    mov     x23,x0  //copy the value of stringlength into x23
    
    //check to see if index is bigger than stringlength -1
    cmp     x23,x21 
    ble     return_false_STRT1

    //now check to see if index is positive
    cmp     x21,#0
    ble     return_false_STRT1

    //index is good!!!
beginIndexLoop_STRT1:
    ldrb    w24,[x20],#1 //load character into x23
    sub     x21,x21,#1 //decrememnt begin index
    
    cmp     x21,#0 //run until 0
    bne     beginIndexLoop_STRT1

//Now we check compare character of both strings
    ldrb    w24,[x20],#1
    ldrb    w25,[x22],#1
until_null_loop_STRT1:
        cmp     w24,w25
        bne     return_false_STRT1 //if characters are not equals, return false
        cbz     w24, return_true_STRT1 //is our character of string1 == null? jump to return_true if true
        //else, characters were the same
        //grab next character of both strings
        ldrb W24, [X20], #1
        ldrb W25, [X22], #1
        //loop
        b until_null_loop_STRT1

    return_false_STRT1:
        mov     x0,#0 //return 1 to represent true
        b       exit_STRT1
    return_true_STRT1:
        mov     x0,#1 //return 1 to represent true
        b       exit_STRT1

exit_STRT1:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return



//================================================================================
//String_startsWith_2
//Purpose: Calculates if String 1 starts with String 2 
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    cbz     x0,return_false_STRT2
    //else
    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21

//Now we check compare character of both strings
    ldrb    w24,[x20],#1
    ldrb    w25,[x22],#1
until_null_loop_STRT2:
        cmp     w24,w25
        bne     return_false_STRT2 //if characters are not equals, return false

        sub     x21,x21,#1
        //check to see if string2 is empty
        cmp     x21,#0 //is our character of string2 == null? jump to return_true if true
        beq     return_true_STRT2
        //else, characters were the same
        //grab next character of both strings
        ldrb W24, [X20], #1
        ldrb W25, [X22], #1
        //loop
        b until_null_loop_STRT2

    return_false_STRT2:
        mov     x0,#0 //return 1 to represent true
        b       exit_STRT2
    return_true_STRT2:
        mov     x0,#1 //return 1 to represent true
        b       exit_STRT2

exit_STRT2:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    

//================================================================================
//String_endsWith
//Purpose: Calculates if String 1 contains String 2 at the given index
//================================================================================
// @ X0: Must point to a null terminated string
// @ X1: Must point to a null terminated string
// @ LR: Must contain the return address
// @ All AAPCS required registers are preserved,  r19-r29 and SP.
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
    cbz     x0,return_false_ENDWT
    //else
    //Now x0 contains the length of our string
    mov     x21,x0  //copy the value of stringlength into x21

    //identify the length of string2
    mov     x0,x22
    bl      String_length //call String_length

    //check and exit if string length is 0
    cbz     x0,return_false_ENDWT
    //else
    //Now x0 contains the length of our string
    mov     x23,x0  //copy the value of stringlength into x23
    
    //check to see if string2 is larger than string1
    cmp     x23,x21
    bgt     return_false_ENDWT

    //we are good!!!
    //run this loop until x23 is 0
    //we need to set 23 to equal 21 - 23
    sub     x23,x21,x23
beginIndexLoop_ENDWT:
    ldrb    w24,[x20],#1 //load character into x23
    sub     x23,x23,#1 //decrememnt begin index
    
    cmp     x23,#0 //run until 0
    bne     beginIndexLoop_ENDWT

//Now we check compare character of both strings
    ldrb    w24,[x20],#1
    ldrb    w25,[x22],#1
until_null_loop_ENDWT:
        cmp     w24,w25
        bne     return_false_ENDWT//if characters are not equals, return false
        cbz     w24, return_true_ENDWT //is our character of string1 == null? jump to return_true if true
        //else, characters were the same
        //grab next character of both strings
        ldrb W24, [X20], #1
        ldrb W25, [X22], #1
        //loop
        b until_null_loop_ENDWT

    return_false_ENDWT:
        mov     x0,#0 //return 1 to represent true
        b       exit_ENDWT
    return_true_ENDWT:
        mov     x0,#1 //return 1 to represent true
        b       exit_ENDWT

exit_ENDWT:
    //now restore preserved registers and return
    ldp X29, LR,  [SP], #16
    ldp X27, X28, [SP], #16
    ldp X25, X26, [SP], #16
    ldp X23, X24, [SP], #16
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    ret//return
    