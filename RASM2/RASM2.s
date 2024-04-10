//================================================================================
//Programmer: Aiden Sallows
//Programmer: RASM2.s
//Purpose:  Input numeric information from the keyboard, perform addition, 
//          subtraction, multiplication, and division. Check for overflow upon
//          all operations.
//Date Last Modified: March 7th, 2024
//================================================================================
    .global _start

    .equ MAX_LEN, 20 //const, used for getstring
    .equ BUFFER,  21


    .data 
//data allocation for input and output variables
dbX:                .quad 0
dbY:                .quad 0
dbSum:              .quad 0
dbDif:              .quad 0
dbDiv:              .quad 0
dbRemain:           .quad 0
dbProd:             .quad 0
dbBoolCheck:        .byte 0 //will equal 1 if first input is successful
//int used to count for loop that gets user input
dbGetLoopIt:        .byte 0 
//String variables used to display user prompt
//Error messages
szStudentInfo:      .asciz "Name: Aiden Sallows\nClass: CS 3B\nLab: RASM2\nDate:3/14/2024\n\n" 
szDivByZero:        .asciz "You cannot divide by 0. Thus, there is NO quotientor remainder\n"
szOverflowAdd:      .asciz "OVERFLOW occurred when ADDING\n"
szOverflowSub:      .asciz "OVERFLOW occurred when SUBTRACTING\n"
szErrorMul:         .asciz "RESULT OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RANGE WHEN MULTIPLYING\n"
szInvalidString:    .asciz "INVALID character in numeric string\n"
szTooBig:           .asciz "NUMBER OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RE-ENTER VALUE:\n"
//User prompts
szExit:			.asciz "Thanks for using my program!! Good Day!\n" 
szFirst:        .asciz "Enter your first number: "
szSecond:       .asciz "Enter your second number: "
szSumPrompt:    .asciz "The sum is "
szDifPrompt:    .asciz "The difference is "
szProdPrompt:   .asciz "The product is "
szQuotPrompt:   .asciz "The quotient is "
szRemainPrompt: .asciz "The remainder is "
//Data storage for strings
szBuffer:      .skip 512
iLimitNum:     .word 21  // the limit for entering numeric strings

chLF:          .byte 0xa // new line


    .text
_start:
    //Display student info
    ldr     x0,=szStudentInfo //loads address of szStudentInfo into x0
    bl      putstring //branch and link putstring
    looptime:
        //reset dbBoolCheck
        ldr     x0,=chLF
        bl      putch

        mov     x0,#0 //Copies 0 into bool variable
        ldr     x1,=dbBoolCheck //obtain address of dbBoolCheck and store it into x1
        strb    w0,[x1] //grabs the first word from x0 and stores it into address held by x1

        //this while loop will iterate until user enters 'enter' or a valid input
        get_input:
            //receive the first input from user
            //check if its first or second input
            ldr      x0,=dbBoolCheck
            ldrb     w1,[x0]

            cmp      x1,#0
            b.ne     second_prompt
            //else its the first input
            ldr     x0,=szFirst //display prompt
            bl      putstring//branch and link putstring
            b       continue_input
            second_prompt:
                ldr     x0,=szSecond //display prompt
                bl      putstring//branch and link putstring

            continue_input:
                ldr     x0,=szBuffer //loads address of szBuffer into x0
                mov     x1,#512 //allocates 512 bytes

                bl      getstring //branch and link getstring

                //check to make sure input is not enter
                ldr     x8,=szBuffer //load into x8 the cstring of what user entered
                ldrb    w9,[x8],#1 //load first character value into x9

                //if x9 is equal to \n then exit
                cmp     x9,#0 //if the value is null, then it will execute 0-0
                b.eq    exit_sequence

                //Now check to see if the number is negative
                cmp     x9,#45 //- in ascii
                b.ne    check_characters
                //else, number is negative
                //set bool var and move the byte one over
                ldrb    w9,[x8],#1 //load next character value into x9

            //Then check there is no characters!
            check_characters:
                //if a character is found, throw error message and return to get_input
                //else continue
                //check if its \n first
                //then check if its less than 48
                //then check if its greater than 57

                cmp     x9,#0 //if the value is null, then input does not have any characters
                b.eq    check_too_long 

                //else character is not null, so check if its 0-9
                // if a character is found, pop error message and jump to get input
                cmp     x9,#48
                b.lt    error_character_found

                cmp     x9,#57
                b.gt    error_character_found  

                //else, this byte is valid, grab next byte and loop
                ldrb    w9,[x8],#1 //load next character value into x9
                b       check_characters

            check_too_long:
            //doesnt work, need to convert to db and then check overflow value
            //Now make sure input is not greater than largest positive int in 32's complement
            //now x0 holds int value
            //Now convert to db variable
                //check if its first or second input
                ldr      x6,=dbBoolCheck
                ldrb     w7,[x6]

                cmp      x7,#0
                b.ne     store_dbY

                //else, must be first input
                ldr     x0,=szBuffer //loads address of szBuffer into X0
                bl      ascint64 //branch and link to ascint64 (convert cstring to int)

                ldr     x1,=dbX //load into X1 the address of dbA
                str     x0,[x1] //dbA = result in x0
                b.vs    error_too_long //check to see if this conversion raised the overflow flag
                store_dbY:
                    ldr     x0,=szBuffer //loads address of szBuffer into X0
                    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

                    ldr     x1,=dbY //load into X1 the address of dbA
                    str     x0,[x1] //dbA = result in x0
                    b.vs    error_too_long //check to see if this conversion raised the overflow flag


            //first input is validated!
            //Now check bool variable. If var is 0, move onto second input
            //else, move onto processing
            ldr      x0,=dbBoolCheck
            ldrb     w1,[x0]

            cmp      x1,#0
            b.ne     processing
            //else, second input must be collected
            mov      x1,#1 //Copies 0 into bool variable
            strb     w1,[x0] //grabs the first word from x1 and stores it into address held by x0
            b        get_input

        processing:
            sum_proc:
                //Begin addition processing
                //add x1 and x2, if overflow occurs, then throw OVERFLOW OCCURED WHEN ADDING and skip
                //load x and y values
                ldr     x0,=dbX
                ldr     x0,[x0]

                ldr     x1,=dbY
                ldr     x1,[x1]
                //Now add
                adds x0,x0,x1 //x0 = x0+x1

                //Now check for overflow
                b.vs    sum_error//if overflow, then throw error and jump to difference
                //else, add worked properly
                //now output sum            
                ldr     x1,=szBuffer //converts sum to ascii
                bl      int64asc //branch and link int 64 to ascii

                ldr     x0,=szSumPrompt //display prompt
                bl      putstring//branch and link putstring

                ldr     x0,=szBuffer
                bl      putstring

                ldr     x0,=chLF
                bl      putch
                //now jump to difference
                b       difference_proc
            sum_error:
                ldr     x0,=szOverflowAdd
                bl      putstring

            difference_proc:
                //Begin difference processing
                //sub x1 and x2, if overflow occurs, then throw OVERFLOW OCCURED WHEN SUBBING and skip
                //load x and y values
                ldr     x0,=dbX
                ldr     x0,[x0]

                ldr     x1,=dbY
                ldr     x1,[x1]
                //Now add
                subs x0,x0,x1 //x0 = x0+x1

                //Now check for overflow
                b.vs    dif_error//if overflow, then throw error and jump to difference
                //else, add worked properly
                //now output sum            
                ldr     x1,=szBuffer //converts sum to ascii
                bl      int64asc //branch and link int 64 to ascii

                ldr     x0,=szDifPrompt //display prompt
                bl      putstring//branch and link putstring

                ldr     x0,=szBuffer
                bl      putstring

                ldr     x0,=chLF
                bl      putch
                //now jump to difference
                b       product_proc
            dif_error:
                ldr     x0,=szOverflowSub
                bl      putstring

            product_proc:
                //Begin product processing
                //sub x1 and x2, if overflow occurs, then throw OVERFLOW OCCURED WHEN SUBBING and skip
                //load x and y values
                ldr     x0,=dbX
                ldr     x0,[x0]

                ldr     x1,=dbY
                ldr     x1,[x1]
                //Now add
                mul     x2,x0,x1 //x2 = x0*x1

                //Now check for overflow
                //Mul doesnt have overflow flags unfortunately so get creative
                // IF x2 / x1 != x0, then overflow occured

                //first check if product is 0
                cmp     x2,#0
                b.eq    prod_is_zero
                sdiv    x3,x2,x1 
                cmp     x3,x0  
                b.ne    prod_error//if overflow, then throw error and jump to difference
                //else, add worked properly
                //now output sum      
                //set x0 to = x2
                prod_is_zero:
                    mov     x0,x2

                    ldr     x1,=szBuffer //converts sum to ascii
                    bl      int64asc //branch and link int 64 to ascii

                    ldr     x0,=szProdPrompt //display prompt
                    bl      putstring//branch and link putstring

                    ldr     x0,=szBuffer
                    bl      putstring

                    ldr     x0,=chLF
                    bl      putch
                    //now jump to difference
                    b       quotient_proc
            prod_error:
                ldr     x0,=szErrorMul
                bl      putstring

            quotient_proc:
                //Begin quotient processing
                //sub x1 and x2, if overflow occurs, then throw OVERFLOW OCCURED WHEN SUBBING and skip
                //load x and y values
                ldr     x0,=dbX
                ldr     x0,[x0]

                ldr     x1,=dbY
                ldr     x1,[x1]

                cmp     x1,#0
                b.eq    quot_error

                //Now divide
                sdiv     x0,x0,x1 //x0 = x0/x1

                //now output quotient      
                ldr     x1,=szBuffer //converts sum to ascii
                bl      int64asc //branch and link int 64 to ascii

                ldr     x0,=szQuotPrompt //display prompt
                bl      putstring//branch and link putstring

                ldr     x0,=szBuffer
                bl      putstring

                ldr     x0,=chLF
                bl      putch

                ldr     x0,=dbX
                ldr     x0,[x0]

                ldr     x1,=dbY
                ldr     x1,[x1]

                sdiv     x2,x0,x1 //x2 = x0/x1
                
                ldr     x6,=dbDiv //X6 -> address of dbOutput
                str     x2,[x6] //retrieves value of address in x6 and stores in x0
                //now store remainder in x3
                //remainder = divident - (quotient * divisor)
                mul     x3,x2,x1 //x3 = quotient * divisor
                sub     x3,x0,x3  //x3 = divident - quotient * divisor 

                ldr     x6,=dbRemain //X6 -> address of dbOutput
                str     x3,[x6] //retrieves value of address in x6 and stores in x0
                //now output quotient
                ldr     x0,=dbDiv
                ldr     x0,[x0]

                ldr     x1,=szBuffer //converts sum to ascii
                bl      int64asc //branch and link int 64 to ascii

                // ldr     x0,=szBuffer
                // bl      putstring

                ldr     x0,=szRemainPrompt //display prompt
                bl      putstring//branch and link putstring

                ldr     x0,=dbRemain
                ldr     x0,[x0]

                ldr     x1,=szBuffer //converts sum to ascii
                bl      int64asc //branch and link int 64 to ascii

                ldr     x0,=szBuffer
                bl      putstring

                ldr     x0,=chLF
                bl      putch

                b       looptime
            quot_error:
                ldr     x0,=szDivByZero
                bl      putstring   
                //now jump to end
                b       looptime
    //end of get input loop    
    error_too_long:
        ldr     x0,=szTooBig
        bl      putstring//branch and link putstring

        b       get_input
    error_character_found:
        ldr     x0,=szInvalidString
        bl      putstring//branch and link putstring

        b       get_input
    exit_sequence:
        ldr     x0,=szExit //display exit prompt
        bl      putstring//branch and link putstring

        //setup to end program
        mov X0, #0
        mov X8, #93
        svc 0

    .end




