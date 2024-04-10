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
    .equ AT_FDCWD, -100
	.equ NR_openat, 56
	.equ NR_close, 57
	.equ NR_exit, 93
    .equ NR_write, 64
	.equ W, 0101 //writeonly + create

    .data 
//String variables used to display strings
szFileName:    .asciz "output.txt"
szWrite:       .asciz "cat in the hat" //string to be written in the file
szBuffer:      .skip BUFFER
chLF:          .byte 0xa // new line
iFD:           .byte 0
    .text
_start:
    //open file system call with name "output.txt"
    mov     x0, #AT_FDCWD //upons up our local directory
    ldr     x1,=szFileName //loads into x1 address of file name

    mov     x2, #W //open syscall arguments
    mov     x3, #S_RDWR //read and write access rights
    mov     x8, #NR_openat //NR register that contains openat system call
    svc     #0 //service call

    ldr     x1,=iFD //byte address of file descriptor
    strb    w0,[x1] //store into x0 the file descriptor byte

    //now x0 contains the file descriptor
    mov     x8, #NR_write //write NR value, moved into x8
    ldr     x1,=szWrite //load string value that we will write
    mov     x2,#16 //length of string + 1 for CR
    svc     #0 //service call

    //string has been written!


    exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
