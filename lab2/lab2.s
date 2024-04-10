
	.global _start // Provide program starting address

    .data

szMsg1:  .asciz  "The sun did not shine."
szMsg2:  .asciz  "It was too wet to play."
chLF:    .byte   0xa
chCR:    .byte   0xd

    .text

_start:

    ldr  x0,=szMsg1
    bl   putstring

    ldr  x0,=chLF
    bl   putch

    ldr  x0,=szMsg2
    bl   putstring

    ldr  x0,=chLF
    bl   putch

    mov X0, #0
    mov X8, #93
    svc 0


    .end
//every line must be commented