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
szOutput:      .asciz "Streng length = " //
szString:      .asciz "This is a string." //
szBuffer:      .skip BUFFER
chLF:          .byte 0xa // new line

    .text
_start:

    ldr     x0,=szOutput //display prompt
    bl      putstring//branch and link putstring
    //get string length
    ldr     x0,=szString
    bl      String_length
    //Print string length
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end




