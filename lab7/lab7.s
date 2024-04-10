//================================================================================
//Programmer: Aiden Sallows
//Lab 6
//Purpose: Output our stored data values to the console
//Date Last Modified: February 8th, 2024
//================================================================================
    .global _start

    .equ BUFFER, 21 //const, used to allot 21 bytes in mem

    .data 
//data allocation for various variables
bA:        .skip     1
chInit:    .skip     1
u16Hi:     .hword    0
wAlt:      .word     0, 0, 0
szMsg1:    .skip     10
dbBig:     .quad     0

// 1 + 1 + 2 + 12 + 10 + 8 = 34

//strings to format display to console
sz1:        .asciz "bA = "
sz2:        .asciz "chInit = "
sz3:        .asciz "u16Hi = "
sz4:        .asciz "wAlt[0] = "
sz5:        .asciz "wAlt[1] = "
sz6:        .asciz "wAlt[2] = "
sz7:        .asciz "szMsg1 = "
sz8:        .asciz "dbBig = "

chQuote:    .byte 0x22
chSingle:   .byte 0x27
chLF:       .byte 0xa

szBuffer:   .skip BUFFER

    .text
_start:

    /******* Change value of bA *************/
    mov     x0,#155 //Copies 155 into x0 register
    ldr     x1,=bA //obtain address of bA and store it into x1

    //x1 holds address that needs to store x0

    strb    w0,[x1] //grabs the first word from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at bA
                    //Now bA holds the value 155

    /******* Change value of chInit *************/
    mov     x0,'j' //Copies j into x0 register
    ldr     x1,=chInit //obtain address of chInit and store it into x1

    //x1 holds address that needs to store x0

    strb    w0,[x1] //grabs the first word from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at chInit

    /******* Change value of u16Hi *************/
    mov     x0,#88 //Copies 88 into x0 register
    ldr     x1,=u16Hi //obtain address of u16Hi and store it into x1

    //x1 holds address that needs to store x0

    strh    w0,[x1] //grabs the first word from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at u16Hi

    /******* Change value of wAlt1[0] *************/
    mov     x0,#16 //Copies 16 into x0 register
    ldr     x1,=wAlt //obtain address of wAlt and store it into x1
    //x1 holds address that needs to store x0

    str     w0,[x1] //grabs the first 4 bytes from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at wAlt[0]

    /******* Change value of wAlt1[1] *************/
    mov     x0,#-1 //Copies -1 into x0 register

    str     w0,[x1, #4] //Skips 4 bytes, and then stores the next 4 bytes of x1 with value from x0
                        //brackets dereference memory address to modify value at wAlt[1]

    /******* Change value of wAlt1[2] *************/
    mov     x0,#-2 //Copies -2 into x0 register

    str     w0,[x1, #8] //Skips 8 bytes, and then stores the next 4 bytes of x1 with value from x0
                        //brackets dereference memory address to modify value at wAlt[2]

    /******* Change value of szMsg1 *************/
    mov     x0,'A' //Copies "And Sally" into x0 register
    ldr     x1,=szMsg1     //obtain address of szMsg1 and store it into x1
    strb    w0,[x1] //grabs the value from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at szMsg1
    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'n' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'d' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,' ' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'S' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'a' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'l' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1
    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1

    add x1,x1,#1    //THEN INCREMENT x1 to get next character in string

    mov      x0,'y' //Copies next character
    strb     w0,[x1] //grabs the value from x0 and stores it into address held by x1
                         //brackets dereference memory address to modify value at szMsg1   

    /******* Change value of dbBig *************/
    mov     x0,#9223372036854775807 //Copies 9223372036854775807 into x0 register
    ldr     x1,=dbBig //obtain address of dbBig and store it into x1

    //x1 holds address that needs to store x0

    str    x0,[x1] //grabs the value from x0 and stores it into address held by x1
                    //brackets dereference memory address to modify value at dbBig

    /***** Print sz1 and value of bA *********/
    ldr     x0,=sz1 //loading address of sz1 into x0
    bl      putstring //Display sz1

    ldr     x0,=bA // Loading the address of label bA
    ldrb    w0,[x0] //load a single byte from x0 ->
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value of bA into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of chInit ***********/
    ldr     x0,=sz2 //loading address of sz2 into x0
    bl      putstring //Display sz2

    ldr     x0,=chSingle //load value of chSingle to x0
    bl      putch //display chSingle

    ldr     x0,=chInit //load value of chInit to x0
    bl      putch //display chInit

    ldr     x0,=chSingle //load value of chSingle  to x0
    bl      putch //display chSingle

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of u16Hi ***********/
    ldr     x0,=sz3 //loading address of sz3 into x0
    bl      putstring //Display sz3

    ldr     x0,=u16Hi // gets the address of  u16Hi
    ldrh    w0,[x0] //load the halfword into memory 
    ldr     x1,=szBuffer //print szBuffer which has value of the halfword of u16Hi
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //retrieve szBuffer address
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[0] ***********/
    ldr     x0,=sz4 //loading address of sz4 into x0
    bl      putstring //Display sz4

    ldr     x0,=wAlt // gets the address of wAlt
    ldrh    w0,[x0] //load the first four bytes into memory 
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[1] ***********/
    ldr     x0,=sz5 //loading address of sz5 into x0
    bl      putstring //Display sz5

    ldr     x0,=wAlt // gets the address of wAlt
    ldrsw   x0,[x0, #4] //load the second four bytes into memory, and loads specifically a signed word
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[2] ***********/
    ldr     x0,=sz6 //loading address of sz6 into x0
    bl      putstring //Display sz6

    ldr     x0,=wAlt // gets the address of wAlt
    ldrsw   x0,[x0, #8] //load the third four bytes into memory, and loads specifically a signed word
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of szMsg1 ***********/
    ldr     x0,=sz7 //loading address of sz7 into x0
    bl      putstring //Display sz7

    ldr     x0,=chQuote //print "
    bl      putch 

    ldr     x0,=szMsg1 //loading address of szMsg1 into x0
    bl      putstring //Display szMsg1

    ldr     x0,=chQuote //print "
    bl      putch 

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of dbBig ***********/
    ldr     x0,=sz8 //loading address of sz8 into x0
    bl      putstring //Display sz8

    ldr     x0,=dbBig // gets the address of wAlt
    ldr     x0,[x0] //retrieves the value of dbBig from the address, storing into x0
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end