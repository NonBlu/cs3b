//================================================================================
//Programmer: Aiden Sallows
//Lab 8
//Purpose: Write a program that prompts the user for two (2) 64 bit signed numbers and displays the largest of the two. Execute a for loop that runs three times.
//Date Last Modified: February 29th, 2024
//================================================================================
    .global _start

    .equ MAX_LEN, 20 //const, used for getstring

    .data 
//data allocation for various variables
dbX:    .quad 0
dbY:    .quad 0

//int used to count for loop
dbIt:    .byte 3 //19
//String variables used to display user prompt
szPromptX:     .asciz "Enter x: " //29
szPromptY:     .asciz "Enter y: "//39

szMsg1:        .asciz "y > x: " //47
szMsg2:        .asciz "x > y: " //55
szMsg3:        .asciz " > " //59
szMsg4:        .asciz "x == y: " //68
szMsg5:        .asciz " == " //73

szX:           .skip 21 //94
szY:           .skip 21 //115

chLF:          .byte 0xa //116


    .text
_start:

//start for loop
for_loop_3:
    ldr     x2,=dbIt // Loading the address of label dbIt
    ldrb    w2,[x2] //load a single byte from x0 dbIt

    cmp     x2,#0
    beq     exit_sequence //branches to exit sequence if dbIt is not greater than 0
    //if not greater than 0, sub 1 from bIt

    sub     x2,x2,#1

    ldr     x3,=dbIt //grabs address of dbIt
    strb     w2,[x3] //store new x2 into dbIt

    //receive input from user
    ldr     x0,=szPromptX //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szX //loads address of szX into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    //receive input from user
    ldr     x0,=szPromptY //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szY //loads address of szY into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    //==========================================================
    //Now time to convert string input
    ldr     x0,=szX //loads address of szX into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbX //load into X1 the address of dbX
    str     x0,[x1] //dbX = result in x0
    //converts string szX into an int stored in dbX

    ldr     x0,=szY //loads address of szY into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbY //load into X1 the address of dbY
    str     x0,[x1] //dbY = result in x0
    //converts string szY into an int stored in dbY

    //============================================================
    //Now compute x and y relationship
    ldr     x0,=dbX //grab address of dbX
    ldr     x0,[x0] //loads value of dbX into x0

    ldr     x1,=dbY //grabs address of dbY
    ldr     x1,[x1] //loads value of dbY into x1

    cmp     x0,x1 //Executes operation x1-x2

    ble     lessthanorequal //branch to lesssthanorequal if x0 is less than or equal to x1

    //this must mean that x0 is greater than x1
    ldr     x0,=szMsg2
    bl      putstring //display that x is greater than y

    ldr     x0,=szX
    bl      putstring //display x

    ldr     x0,=szMsg3
    bl      putstring //display >

    ldr     x0,=szY
    bl      putstring //display y

    ldr     x0,=chLF
    bl      putch
    ldr     x0,=chLF
    bl      putch

    b       for_loop_3
    lessthanorequal:

    beq      equal //branch if x0 is equal to x1

    //this must mean that x0 is less than x1
    ldr     x0,=szMsg1
    bl      putstring //display that x is less than y

    ldr     x0,=szY
    bl      putstring //display x

    ldr     x0,=szMsg3
    bl      putstring //display >

    ldr     x0,=szX
    bl      putstring //display y

    ldr     x0,=chLF
    bl      putch
    ldr     x0,=chLF
    bl      putch

    b       for_loop_3 //branch to exit sequence
    equal:

    //this must mean they are equal to eachother
    ldr     x0,=szMsg4
    bl      putstring //display that x is equal to y

    ldr     x0,=szX
    bl      putstring //display x

    ldr     x0,=szMsg5
    bl      putstring //display ==

    ldr     x0,=szY
    bl      putstring //display y

    ldr     x0,=chLF
    bl      putch
    ldr     x0,=chLF
    bl      putch

    b       for_loop_3 //branch to exit sequence

    exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end