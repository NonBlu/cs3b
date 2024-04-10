//================================================================================
//Programmer: Aiden Sallows
//Lab 11
//Purpose: Demonstrate the ability to concatenate strings
//Date Last Modified: March 5th, 2024
//================================================================================
    .global _start

    .equ MAX_LEN, 20 //const, used for getstring
    .equ BUFFER, 21

    .data 
//data allocation for various variables
szX:         .asciz "Cat"
szY:         .asciz "in the hat."
szSpace:     .asciz " "
ptrString:   .quad 0
chLF:        .byte 0xa // new line

    .text
_start:
    //store szX and szY into x19 and x20
    ldr     x19,=szX
    ldr     x20,=szY

    //first identify the length of string 1 (szX)
    ldr     x0,=szX //load szX into x0
    bl      String_length //call String_length

    //Now x0 contains the length of szX (should be 3)
    mov     x21,x0  //copy the value of szX stringlength into x21
    
        //Now identify the length of string 2 (szY)
    ldr     x0,=szY //load szY into x0
    bl      String_length //call String_length

    //Now x0 contains the length of szY (should be 15)
    mov     x22,x0  //copy the value of szY stringlength into x22
    
    //Now determine length of both strings (should be 15)
    add     x23,x21,x22 
    add     x23,x23,#1 //add 1 for the extra space 
    
    //now that we know the length of the concatenated string, allocate the memory
    //Preserve r19->r22 registers
    stp X19, X20, [SP, #-16]!
    stp X21, X22, [SP, #-16]!

    mov     x0,x23 // we will need to allocate 15 bytes, store 11 into x0
    bl      malloc //branch and link to malloc

    //now x0 contains an address that contains 15 bytes
    //So lets grab the ptrString variable and have it point to the newly allocated memory
    ldr     x1,=ptrString
    str     x0,[x1] 

    //now we can restore our registers!
    ldp X21, X22, [SP], #16
    ldp X19, X20, [SP], #16

    //Now we can finally load our strings into allocated space
    //obtain value of memory ptrstring is pointing to
    ldr     x23,=ptrString
    ldr     x23,[x23]

    //Now we need to traverse our strings
    mov     x24,#0 //first string index
    mov     x25,#0 //second string index
    mov     x26,#0 //new string index

    //time for some loops to traverse
    szX_loop:
        ldrb    w27, [x19,x24] //load into x27 (address of first string + current index) || basically increments string by index
        strb    w27, [x23,x26] //store value held in x27 at (ptrstring address + current index)

        sub     x21,x21,#1 //subtract 1 from the stringlength of szX
        add     x24,x24,#1 //add 1 to the first string index
        add     x26,x26,#1 //add 1 to new string index
        
        cmp     x21,#0 //iterate through until string length is 0
        b.eq    add_space
        b       szX_loop
    
    add_space:
        ldr     x29,=szSpace //load address of space string
        ldrb    w29,[x29] //grab the first character in the string
        strb    w29,[x23,x26] //store the space character into n string
        add     x26,x26,#1 //increment new string index
    
    szY_loop:
        ldrb    w27, [x20,x25] //load into x27 (address of second string + current index) || basically increments string by index
        strb    w27, [x23,x26] //store value held in x27 at (ptrstring address + current index)

        sub     x22,x22,#1 //subtract 1 from the stringlength of szX
        add     x25,x25,#1 //add 1 to the second string index
        add     x26,x26,#1 //add 1 to new string index
        
        cmp     x22,#0 //iterate through until string length is 0
        b.eq    exit
        b       szY_loop        
    exit:
        ldr     x0, =ptrString
        ldr     x0,[x0] //load value of new concatenated string
        bl      putstring //print

        ldr     x0,=chLF
        bl      putch //print new line

        //free memory
        ldr     x0,=ptrString
        ldr     x0,[x0]
        bl      free

exit_sequence:
    
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
