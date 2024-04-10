//================================================================================
//Programmer: Aiden Sallows
//Lab 5
//Purpose: When given values A,B,C,D, outputs and displays: A - B + C - D. 
//Date Last Modified: February 5th, 2024
//================================================================================
    .global _start


    .equ BUFFER, 21 //const, used to allot 21 bytes in mem
    .equ MAX_LEN, 20 //const, used for getstring
    
    .data 
//String variables for variables A,B,C,D, as well as the sum
szA:        .skip BUFFER
szB:        .skip BUFFER
szC:        .skip BUFFER
szD:        .skip BUFFER
szSum:      .skip BUFFER

//String variables used to display user prompt
szPrompt1:  .asciz "Please enter A: "
szPrompt2:  .asciz "Please enter B: "
szPrompt3:  .asciz "Please enter C: "
szPrompt4:  .asciz "Please enter D: "
//String variables to display mathematical operations
szMinus:    .asciz " - "
szPlus:     .asciz " + "
szEquals:   .asciz " = "

//line feed variable
chLF:       .byte 0xa //10 is the newline character in ascii)

//data variables, used for computing. the sum of dbA,dbB,dbC, and dbD are stored in dbSum
dbA:        .quad 0
dbB:        .quad 0
dbC:        .quad 0
dbD:        .quad 0
dbSum:      .quad 0
    .text

_start:
    //=========================================
    //receive input from user
    ldr     x0,=szPrompt1 //display prompt
    bl      putstring

    ldr     x0,=szA //loads address of szA into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt2 //display prompt
    bl      putstring

    ldr     x0,=szB //loads address of szB into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt3 //display prompt
    bl      putstring

    ldr     x0,=szC //loads address of szC into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt4 //display prompt
    bl      putstring

    ldr     x0,=szD //loads address of szD into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

    bl      getstring //branch and link getstring

    //==========================================================
    //Now time to convert string input
    ldr     x0,=szA //loads address of szA into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbA //load into X1 the address of dbA
    str     x0,[x1] //dbA = result in x0
    //converts string szA into an int stored in dbA


    ldr     x0,=szB //loads address of szA into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbB //load into X1 the address of dbB
    str     x0,[x1] //dbB = result in x0
    //converts string szB into an int stored in dbB


    ldr     x0,=szC //loads address of szC into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbC //load into X1 the address of dbC
    str     x0,[x1] //dbC = result in x0
    //converts string szC into an int stored in dbC


    ldr     x0,=szD //loads address of szD into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbD //load into X1 the address of dbD
    str     x0,[x1] //dbD = result in x0
    //converts string szD into an int stored in dbD

    //=============================================================
    //Now time to perform the calculations

    //dbSum = dbA - dbB + dbC - dbD
    ldr     x1,=dbA //X1 -> address of dbA
    ldr     x1,[x1] //X1 = dbA

    ldr     x2,=dbB //X2 -> address of dbB
    ldr     x2,[x2] //X2 = dbB

    ldr     x3,=dbC //X3 -> address of dbC
    ldr     x3,[x3] //X3 = dbC

    ldr     x4,=dbD //X4 -> address of dbD
    ldr     x4,[x4] //X4 = dbD

    sub     x0,x1,x2 //X0 = X1 - X2 .. X0 = dbA - dbB
    add     x0,x0,x3 //X0 = X0 + X3 .. X0 = dbA - dbB + dbC
    sub     x0,x0,x4 //X0 = X0 - X4 .. X0 = dbA - dbB + dbC - dbD


    //now save X0 -> dbSum (dbSum = X0)
    ldr     x5,=dbSum //X5 -> address of dbSum
    str     x0,[x5] //contents of x0 stored in address x5

    //now convert our sum to a string
    ldr     x1,=szSum //converts sum to ascii
    bl      int64asc //branch and link int 64 to ascii


    //**Print the result**

    //Print variable szA
    ldr     x0,=szA
    bl      putstring

    //Print +
    ldr     x0,=szMinus
    bl      putstring

    //Print variable szV
    ldr     x0,=szB
    bl      putstring

    //Print +
    ldr     x0,=szPlus
    bl      putstring

    //Print variable szC
    ldr     x0,=szC
    bl      putstring

    //Print +
    ldr     x0,=szMinus
    bl      putstring

    //Print variable szD
    ldr     x0,=szD
    bl      putstring

    //Print =
    ldr     x0,=szEquals
    bl      putstring

    //Print szSum
    ldr     x0,=szSum
    bl      putstring

    //New line
    ldr     x0,=chLF
    bl      putch

    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end