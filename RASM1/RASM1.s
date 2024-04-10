//================================================================================
//Programmer: Aiden Sallows
//RASM 1
//Purpose: Calculates X = (A+B)-(C+D) where A, B, C, D are all quads that are
//         input by the user at run time.
//Date Last Modified: February 9th, 2024
//================================================================================
    .global _start

    .equ BUFFER, 21 //const, used to allot 21 bytes in mem
    .equ MAX_LEN, 20 //const, used for getstring

    .data 
//String variables for variables A,B,C,D, as well as the output
szA:        .skip BUFFER
szB:        .skip BUFFER
szC:        .skip BUFFER
szD:        .skip BUFFER
szOutput:   .skip BUFFER
szOutHex:   .skip BUFFER

//String value to display name,class,lab, and date
szStudentInfo: .asciz "Name: Aiden Sallows\nClass: CS 3B\nLab: RASM1\nDate:2/13/2024\n\n" 
//String variables used to display user prompt
szPrompt:      .asciz "Enter a whole number: "
szPrntAddr:    .asciz "The addresses of the 4 ints:"
szPrntOut:     .asciz "The address of dbSum:"
//String variables to display mathematical operations
szMinus:    .asciz " - "
szPlus:     .asciz " + "
szEquals:   .asciz " = "
sz0x:       .asciz " 0x"

//line feed variable
chLF:       .byte 0xa //10 is the newline character in ascii)
chPar1:     .byte 0x28 // character for '('
chPar2:     .byte 0x29 // character for ')'
chTAB:      .byte 0x9 // TAB character
//data variables, used for computing. 
dbA:        .quad 0
dbB:        .quad 0
dbC:        .quad 0
dbD:        .quad 0
dbOutput:   .quad 0

    .text
_start:
    //=========================================
    //Display student info
    ldr     x0,=szStudentInfo //loads address of szStudentInfo into x0
    bl      putstring //branch and link putstring

    //receive input from user
    ldr     x0,=szPrompt //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szA //loads address of szA into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szB //loads address of szB into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt //display prompt
    bl      putstring//branch and link putstring

    ldr     x0,=szC //loads address of szC into x0
    mov     x1,MAX_LEN//moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt //display prompt
    bl      putstring//branch and link putstring

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

    //dbOutput = (dbA + dbB) - (dbC + dbD)
    // x0 = output 
    // x1 = dbA
    // x2 = dbB
    // x3 = dbC
    // x4 = dbD
    // x5 = temp variable  
    ldr     x1,=dbA //X1 -> address of dbA
    ldr     x1,[x1] //X1 = dbA

    ldr     x2,=dbB //X2 -> address of dbB
    ldr     x2,[x2] //X2 = dbB

    ldr     x3,=dbC //X3 -> address of dbC
    ldr     x3,[x3] //X3 = dbC

    ldr     x4,=dbD //X4 -> address of dbD
    ldr     x4,[x4] //X4 = dbD

    add     x0,x1,x2 //X0 = X1 + X2 .. X0 = dbA + dbB
    add     x5,x3,x4 //X5 = X3 + X4 .. X5 = dbC + dbD
    sub     x0,x0,x5 //X0 = X0 - X5 .. X0 = (dbA + dbB) - (dbC + dbD)


    //now save X0 -> dbOutpuyt (dbOutput = X0)
    ldr     x6,=dbOutput //X6 -> address of dbOutput
    str     x0,[x6] //retrieves value of address in x6 and stores in x0

    //now convert our output var to a string
    ldr     x1,=szOutput //converts sum to ascii
    bl      int64asc //branch and link int 64 to ascii

    //**Print the result**
    //Print (
    ldr     x0,=chPar1
    bl      putch//branch and link putstring

    //Print variable szA
    ldr     x0,=szA
    bl      putstring//branch and link putstring

    //Print +
    ldr     x0,=szPlus
    bl      putstring//branch and link putstring

    //Print variable szV
    ldr     x0,=szB
    bl      putstring//branch and link putstring

    //Print )
    ldr     x0,=chPar2
    bl      putch//branch and link putch

    //Print -
    ldr     x0,=szMinus
    bl      putstring//branch and link putstring

    //Print (
    ldr     x0,=chPar1
    bl      putch//branch and link putch

    //Print variable szC
    ldr     x0,=szC
    bl      putstring//branch and link putstring

    //Print +
    ldr     x0,=szPlus
    bl      putstring//branch and link putstring

    //Print variable szD
    ldr     x0,=szD
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

    //Print 0x
    ldr     x0,=sz0x
    bl      putstring//branch and link putstring

    //Display hex value of output 
    ldr     x0,=szOutput //load string value of output into x0
    bl      ascint64     //convert string to int value
    ldr     x2,#16       //Set number of hex digits to be displayed to 16
    bl      hex64asc     //prints hex value

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //****Now time to print addresses of four integers *****
    ldr     x0,=szPrntAddr
    bl      putstring//branch and link putstring

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //Now find and print address of dbA,dbB,dbC,dbD
    //Print address of dbA
    ldr     x0,=dbA //load address of dbA to x0
    ldr     x2,#8   //load 8 into x2 to limit output to 8 numbers
    bl      hex64asc//convert hex value of address to ascii

    //output TAB
    ldr     x0,=chTAB
    bl      putch//branch and link putch
    
    //Print address of dbB
    ldr     x0,=dbB //load address of dbB to x0
    ldr     x2,#8   //load 8 into x2 to limit output to 8 numbers
    bl      hex64asc //convert hex value of address to ascii

    //output TAB
    ldr     x0,=chTAB
    bl      putch//branch and link putch

    //Print address of dbC
    ldr     x0,=dbC //load address of dbC to x0
    ldr     x2,#8   //load 8 into x2 to limit output to 8 numbers
    bl      hex64asc//convert hex value of address to ascii

    //output TAB
    ldr     x0,=chTAB
    bl      putch//branch and link putch

    //Print address of dbD
    ldr     x0,=dbD //load address of dbD to x0
    ldr     x2,#8   //load 8 into x2 to limit output to 8 numbers
    bl      hex64asc//convert hex value of address to ascii

    //output TAB
    ldr     x0,=chTAB
    bl      putch//branch and link putch

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //****Now printing dbOutput address *****
    ldr     x0,=szPrntOut
    bl      putstring//branch and link putstring

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //Now find and print address of dbA,dbB,dbC,dbD
    //Print address of dbA
    ldr     x0,=dbOutput //load address of dbA to x0
    ldr     x2,#8   //load 8 into x2 to limit output to 8 numbers
    bl      hex64asc//convert hex value of address to ascii

    //New line
    ldr     x0,=chLF
    bl      putch//branch and link putch

    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
 