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
//data allocation for various variables
dbInputArray:    .quad 0,0,0,0,0,0,0,0,0,0
dbSum:           .quad 0

//int used to count for loop that gets user input
dbGetLoopIt:    .byte 0 
//String variables used to display user prompt
szPrompt1:     .asciz "Enter a number: " //
szPrompt2:     .asciz "Sum of the numbers: " //
szBuffer:      .skip  BUFFER


chLF:          .byte 0xa // new line
chTab:         .byte 0x9 //tab

    .text
_start:

    //start for loop
    //this for loop will iterate 10 times
    get_input_loop:
        //receive input from user
        //load dbGetLoopIt into x2

        ldr     x0,=szPrompt1 //display prompt
        bl      putstring//branch and link putstring

        ldr     x0,=szBuffer //loads address of szX into x0
        mov     x1,MAX_LEN //moves what is in buffer to x1

        bl      getstring //branch and link getstring

        //Now convert string to int value, sum it and store value into array
        ldr     x0,=szBuffer //loads address of szBuffer into X0 ||COULD DELETE
        bl      ascint64 //branch and link to ascint64 (convert cstring to int)

        ldr     x4,=dbInputArray //load into X1 the address of dbX
        str     x0,[x4] //dbX = result in x0
        add     x4,x4,#8 //increment array

        //store this entered value into sum
        ldr     x5,=dbSum //load address of sum
        ldr     x5,[x5] //retrieve value
        add     x5,x5,x0 //sum = sum + new input

        ldr    x6,=dbSum
        str    x5,[x6] //store new x2 into dbIt

        //increment incrementer and check if need to loop
        ldr     x2,=dbGetLoopIt // Loading the address of label dbIt
        ldrb    w2,[x2] //load a single byte from x0 dbIt

        add     x2,x2,#1

        ldr     x3,=dbGetLoopIt //grabs address of dbIt
        strb    w2,[x3] //store new x2 into dbIt

        cmp     x2,#10
        bne     get_input_loop//branches to exit sequence if dbIt is not greater than 0
        //if not greater than 0, sub 1 from bIt

    //Print sum
    ldr     x0,=szPrompt2 //loading address of szPrompt2 into x0
    bl      putstring //Display szPrompt2

    ldr     x0,=dbSum // gets the address of dbSum
    ldr     x0,[x0] //retrieves the value of dbBig from the address, storing into x0
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




