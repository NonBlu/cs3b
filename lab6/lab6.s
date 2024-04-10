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
bA:        .byte     155
bFlag:     .byte     1
chInit:    .byte     'j'
u16Hi:     .hword    88
u16Lo:     .hword    45
wAlt:      .word     16, -1, -2
szMsg1:    .asciz    "And Sally and I"
dbBig:     .quad     9223372036854775807

//strings to format display to console
sz1:        .asciz "bA = "
sz2:        .asciz "bFlag = "
sz3:        .asciz "chInit = "
sz4:        .asciz "u16Hi = "
sz5:        .asciz "u16Lo = "
sz6:        .asciz "wAlt[0] = "
sz7:        .asciz "wAlt[1] = "
sz8:        .asciz "wAlt[2] = "
sz9:        .asciz "szMsg1 = "
sz10:       .asciz "dbBig = "

chQuote:    .byte 0x22
chSingle:   .byte 0x27
chLF:   .byte 0xa

szBuffer:   .skip BUFFER

    .text
_start:

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

    /******* Print value of bFlag ***********/
    ldr     x0,=sz2 //loading address of sz2 into x0
    bl      putstring //Display sz2

    ldr     x0,=bFlag // Loading the address of label bFlag
    ldrb    w0,[x0] //load a single byte from x0 ->
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value of bFlag into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of chInit ***********/
    ldr     x0,=sz3 //loading address of sz3 into x0
    bl      putstring //Display sz3

    ldr     x0,=chSingle //load value of chSingle to x0
    bl      putch //display chSingle

    ldr     x0,=chInit //load value of chInit to x0
    bl      putch //display chInit

    ldr     x0,=chSingle //load value of chSingle  to x0
    bl      putch //display chSingle

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of u16Hi ***********/
    ldr     x0,=sz4 //loading address of sz4 into x0
    bl      putstring //Display sz4

    ldr     x0,=u16Hi // gets the address of  u16Hi
    ldrh    w0,[x0] //load the halfword into memory 
    ldr     x1,=szBuffer //print szBuffer which has value of the halfword of u16Hi
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //retrieve szBuffer address
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of u16Lo ***********/
    ldr     x0,=sz5 //loading address of sz5 into x0
    bl      putstring //Display sz5

    ldr     x0,=u16Lo // gets the address of u16Lo
    ldrh    w0,[x0] //load the halfword into memory 
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value of u16Lo into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[0] ***********/
    ldr     x0,=sz6 //loading address of sz6 into x0
    bl      putstring //Display sz6

    ldr     x0,=wAlt // gets the address of wAlt
    ldrh    w0,[x0] //load the first four bytes into memory 
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[1] ***********/
    ldr     x0,=sz7 //loading address of sz7 into x0
    bl      putstring //Display sz7

    ldr     x0,=wAlt // gets the address of wAlt
    ldrsw   x0,[x0, #4] //load the second four bytes into memory, and loads specifically a signed word
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of wAlt[1] ***********/
    ldr     x0,=sz8 //loading address of sz8 into x0
    bl      putstring //Display sz8

    ldr     x0,=wAlt // gets the address of wAlt
    ldrsw   x0,[x0, #8] //load the third four bytes into memory, and loads specifically a signed word
    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of szMsg1 ***********/
    ldr     x0,=sz9 //loading address of sz9 into x0
    bl      putstring //Display sz9

    ldr     x0,=chQuote //print "
    bl      putch 

    ldr     x0,=szMsg1 //loading address of szMsg1 into x0
    bl      putstring //Display szMsg1

    ldr     x0,=chQuote //print "
    bl      putch 

    ldr     x0,=chLF //print new line feed
    bl      putch 

    /******* Print value of dbBig ***********/
    ldr     x0,=sz10 //loading address of sz10 into x0
    bl      putstring //Display sz10

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