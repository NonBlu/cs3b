//================================================================================
//Programmer: Aiden Sallows
//exam 1
//Purpose: Write an assembly language program that reads in 2 integers (x,y) from
//         the keyboard and outputs the result of the following formula.....
//         2 * (x + 2y)
//         You must do the multiplication(s) without using the multiply instruction
//        (get creative).
//Date Last Modified: February 22nd, 2024
//================================================================================
    .global _start

    .equ BUFFER, 21 //const, used to allot 21 bytes in mem
    .equ MAX_LEN, 20 //const, used for getstring

    .data 
//String variables for variables A,B,C,D, as well as the output
szX:        .skip BUFFER
szY:        .skip BUFFER
szOutput:   .skip BUFFER

//String value to display name,class,lab, and date
szStudentInfo: .asciz "Name: Aiden Sallows\nClass: CS 3B\nProgram: Exam 1\nDate:2/22/2024\n\n" 
//String variables used to display user prompt
szPromptX:     .asciz "Enter x: "
szPromptY:     .asciz "Enter y: "
//String variables to display mathematical operations
szPlus:     .asciz " + " //+
szEquals:   .asciz " = " //=
szMult:     .asciz " * " //*

//character variabels for display
chLF:       .byte 0xa //10 is the newline character in ascii)
ch2:        .byte 0x32 //32 is 2 in ascii
chPar1:     .byte 0x28 // character for '('
chPar2:     .byte 0x29 // character for ')'

//data variables, used for computing. 
dbX:        .quad 0
dbY:        .quad 0
dbOutput:   .quad 0

    .text
_start:
    //=========================================
    //Display student info
    ldr     x0,=szStudentInfo //loads address of szStudentInfo into x0
    bl      putstring //branch and link putstring

    //receive input from user
    ldr     x0,=szPromptX //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szX //loads address of szX into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPromptY //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szY //loads address of szY into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

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

    //=============================================================
    //Now time to perform the calculations

    //dbOutput = 2 * (dbX + 2 * dbY)
    // x0 = output = 2 * (dbX + 2 * dbY) = dbX + dbY + dbY + dbX +dbY +dbY
    // x1 = dbX
    // x2 = dbY

    ldr     x1,=dbX //X1 -> address of dbX
    ldr     x1,[x1] //X1 = dbX

    ldr     x2,=dbY //X2 -> address of dbY
    ldr     x2,[x2] //X2 = dbY

    add     x0,x1,x2 //X0 = X1 + X2 .. X0 = dbX + dbY
    add     x0,x0,x2 //X0 = X0 + X2 .. X0 = dbX + dbY + dbY
    add     x0,x0,x0 //X0 = X0 + X0 .. X0 = dbX + dbY + dbY + dbX + dbY + dbY

    //now save X0 -> dbOutpuyt (dbOutput = X0)
    ldr     x3,=dbOutput //X3 -> address of dbOutput
    str     x0,[x3] //store contents of x0 into memory address represented by dbOutput label

    //now convert our output var to a string
    ldr     x1,=szOutput //converts sum to ascii
    bl      int64asc //branch and link int 64 to ascii

    //**Print the result**
    //Print 2
    ldr     x0,=ch2
    bl      putch//branch and link putch
    
    //Print *
    ldr     x0,=szMult
    bl      putstring//branch and link putstring

    //Print (
    ldr     x0,=chPar1
    bl      putch//branch and link putstring

    //Print variable szX
    ldr     x0,=szX
    bl      putstring//branch and link putstring

    //Print +
    ldr     x0,=szPlus
    bl      putstring//branch and link putstring

    //Print 2
    ldr     x0,=ch2
    bl      putch//branch and link putch
    
    //Print *
    ldr     x0,=szMult
    bl      putstring//branch and link putstring

    //Print variable szY
    ldr     x0,=szY
    bl      putstring//branch and link putstring

    //Print )
    ldr     x0,=chPar2
    bl      putch//branch and link putch

    //Print =
    ldr     x0,=szEquals
    bl      putstring//branch and link putstring

    //Print szOutput
    ldr     x0,=szOutput
    bl      putstring//branch and link putstring

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
 