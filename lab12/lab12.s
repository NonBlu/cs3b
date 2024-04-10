//================================================================================
//Programmer: Aiden Sallows
//Lab 9
//Purpose: Write a program that accepts 10 numbers from the user and calcs the sum
//Date Last Modified: March 5th, 2024
//================================================================================
    .global _start

    .equ MAX_LEN, 20 //const, used for getstring
    .equ BUFFER, 21

    .data 

//String variables used to display strings
szOutput:      .asciz "n = " //
szOutput2:     .asciz "n! = " //
szBuffer:      .skip BUFFER
chLF:          .byte 0xa // new line
dbN:           .quad 0x5 //value 5 stored in n
dbIt:          .quad 0x13880
    .text
_start:
    loop:
    ldr     x2,=dbIt // Loading the address of label dbIt
    ldr     x2,[x2] //load a single byte from x0 dbIt

    // cmp     x2,#5
    // beq     exit_sequence //branches to exit sequence if dbIt is not greater than 0
    //if not greater than 0, sub 1 from bIt

    add     x2,x2,#1

    ldr      x3,=dbIt //grabs address of dbIt
    str      x2,[x3] //store new x2 into dbIt

    ldr     x0,=szOutput //display prompt
    bl      putstring//branch and link putstring
    //load value of n
    ldr     x0,=dbIt // Loading the address of label dbIt
    ldr     x0,[x0] //load a single byte from x0 dbIt
    //print n value
    ldr     x1,=szBuffer
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    // ldr     x0,=chLF //print new line feed
    // bl      putch 

    // ldr     x0,=szOutput2 //display prompt
    // bl      putstring//branch and link putstring
    
    //load value of n again
    ldr     x0,=dbIt // Loading the address of label dbIt
    ldr     x0,[x0] //load a single byte from x0 dbIt

    //compute n factorial
    bl      fact
    // //Print n factorial
    // ldr     x1,=szBuffer
    // bl      int64asc// bl(x0,*x1)

    // ldr     x0,=szBuffer //store string value into x0
    // bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    b      loop

    exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
