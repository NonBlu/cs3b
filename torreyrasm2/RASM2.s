/* Name: Torrey S.
* Program: RASM2.s
* Class: CS3B
* Lab: RASM2
* Date:March 12 2024
* Purpose: Input numeric information from the 
*          keyboard, perform addition, subtraction,
*           multiplication, and division. Check for 
*           overflow upon all operations.
*/  
   
   .global _start

   .data

iLimitNum:        .word    21         //limit for entering numeric strings

szX:              .skip    21
szY:              .skip    21

dbX:              .quad    0
dbY:              .quad    0

dbSum:            .skip 21
dbDiff:           .skip 21
dbProd:           .skip 21
dbQuot:           .skip 21
dbReamin:         .skip 21

szHeader:         .asciz   "\tName:     Torrey Spear\n\tProgram:  RASM2.s\n\tClass:    CS 3B\n\tDate:     March 12 2024\n\n"

szPromptX:        .asciz   "Enter your first number: "
szPromptY:        .asciz   "Enter your second number: "

szDivByZero:      .asciz   "You cannot divide by 0. Thus, there is NO quotient or remainder\n"
szOverflowAdd:    .asciz   "OVERFLOW occurred when ADDING\n"
szOverflowSub:    .asciz   "OVERFLOW occurred when SUBTRACTING\n"
szErrorMul:       .asciz   "RESULT OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RANGE WHEN MULTIPLYING\n"
szInvalidString:  .asciz   "INVALID NUMERIC STRING. RE-ENTER VALUE\n"
szErrorInput:     .asciz   "NUMBER OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RE-ENTER VALUE: \n"

szOutro:          .asciz   "Thanks for using my program!! Good Day!\n\n"

szFUCK:            .asciz   "congrats it didnt jump right. hopefully u dont see this\n"

chLF :            .byte    0x0a


.text
_start:

ldr     x0,=szHeader
bl      putstring


//starts a loop to get X and Y from the user
//create a while loop, while user hasnt entered zero, get input form user
//smaller loop to check if inputed variable if valid
get_loop:

   b  first_loop

   first_to_long:
      ldr   x0,=szErrorInput
      bl    putstring
      b     first_loop

   //second_to_long:

   //not_valid_int_X:

   //not_valid_int_Y:

   first_loop:
      ldr     x0,=szPromptX   //gets prompt 1 string 
      bl      putstring       //prints string

      ldr     x0,=szX         //stores szA in 0
      
      bl      getstring       //calls and exectured getstring


/*
//****************************************************
//       just for me to see what is being stored in szX
      ldr   x0,=szX
      bl    putstring

      ldr   x0,=chLF
      bl    putch
//****************************************************
*/

      //check if entered value is zero
      ldr     x8,=szX         
      ldrb    w9,[x8]
      cmp     x9,#0
      b.eq    exit_sequence

      /*
      //check its length
      ldr      x3,=iLimitNum
      ldrb     w4,[x3]
      cmp      x9,x4
      b.ge     first_to_long
      */




end:

ldr   x0,=szFUCK
bl    putstring

ldr   x0,=chLF
bl    putch

exit_sequence:

//*****************************************
// Setup the parameters to exit the program
// and then call linux to do it.
   mov X0, #0               //Use 0 return code
   mov X8, #93              //Service code 93 terminates
   svc 0                    //terminates

.end
