//================================================================================
//Programmer: Aiden Sallows
//Lab 13
//Purpose: Write a program that writes "cat in the hat" to a textfile "output.txt"
//Date Last Modified: March 5th, 2024
//================================================================================
    .global _start

    .equ MAX_LEN, 20 //const, used for getstring
    .equ BUFFER, 21
    //Input/Output constants
    .equ O_RDONLY, 0 //readonly
    .equ O_WRONLY, 1 //writeonly
    .equ O_CREAT, 0100 //create file
    .equ O_EXCL, 0200 //if set with O_EXCL, fails if file exists
    .equ S_RDWR, 0666
    .equ RW_RW____, 0660
    .equ RW_______, 0600
    .equ AT_FDCWD, -100
	.equ NR_openat, 56
	.equ NR_close, 57
	.equ NR_exit, 93
    .equ NR_write, 64
	.equ C_W, 0101 //writeonly + create
    .equ T_RW, 01002

    .data 
//String variables used to display strings
szFileName:    .asciz "output.txt"
fileBuf:       .skip  512
szEOF:         .asciz "Reached the End of file\n"
szBuffer:      .skip BUFFER
szERROR:       .asciz "FILE READ ERROR"
chLF:          .byte 0xa // new line
iFD:           .byte 0

    .text
_start:
    //open file system call with name "output.txt"
    mov     x0, #AT_FDCWD //upons up our local directory
    mov     x8, #56 //openat
    ldr     x1,=szFileName //loads into x1 address of file name

    mov     x2,#O_RDONLY //flags 
    mov     x3,#RW_______ //mode read/write
    svc     0 //service call

    //x0 now contains the file descriptor

    //save x0 to iFD
    ldr     x1,=iFD
    strb    w0,[x1]

//now read from file
top1: 
    ldr     x1,=fileBuf    //grab file buffer

    bl      getline //call getline function
    cbz     x0,last //jump to last when null is reached

    //else
    ldr     x0,=fileBuf
    bl      putstring //putstring value retrieved from getline

    ldr     x0,=iFD 
    ldrb    w0,[x0] //load iFD into x0

    b       top1 //loop

last:
    ldr     x0,=iFD 
    ldrb    w0,[x0] //load iFD into x0

    mov     x8,#57 //close file
    svc     0 //system call
//=======================================
//Getchar function
//Prereqs:
// X0 - contains fd
// X1 - contains *buf
//returns:
// X0 - contains a string
    b      exit_sequence
    
getchar:
    str     x30,[SP, #-16]!
    mov     x2,#1 //move 1 into x2
    
    //ssize_t read(int fd, void *buf, size_t count);
    //X0 contains fd
    //x1 contains fileBuf
    //x2 contains count
    mov     x8,#63 //READ
    svc     0

    ldr     x30,[SP],#16

    ret

//=======================================
//Getline function
//Prereqs:
// X0 - contains fd
// X1 - contains *buf
//returns:
// X0 - contains a string

getline:
    str     x30,[SP,#-16]!

top:
    bl      getchar //call getchar function
    
    ldrb    w2,[x1] //load character from x1 into x2
    cmp     w2,#0xa //is character retrieved newline?
    beq     eoline //if so, endline

    //else
    cmp     w0,#0x0 //is it null?
    beq     eof //if it is, its the end of the file
    blt     error //if its less than 0, error

    //else we have a character
    add     x1,x1,#1

    ldr     x0,=iFD //reload file descriptor
    ldrb    w0,[x0] //retrieve byte
    b       top //loop

eoline:
    add     x1,x1,#1 //make fileBuf into a cstring
    mov     w2,#0 //move into w2 0
    strb    w2,[x1] //store that into x1
    b       skip

eof:
    mov     x19,x0 //store contents of x0 into x19 
    ldr     x0,=szEOF //grab end of file string
    bl      putstring //print

    mov     x0,x19 //retrive x0 contents
    b       skip

error:
    mov     x19,x0 //store contents of x0 into x19 
    ldr     x0,=szERROR //grab error string
    bl      putstring //print

    mov     x0,x19 //retrive x0 contents
    b       skip

skip:
//popped in reverse order
    ldr     x30, [SP], #16  //#popped
    ret 


exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end

.end