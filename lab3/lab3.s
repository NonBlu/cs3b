    .global _start

    .data 
szX:        .asciz "10"
szY:        .asciz "15"
szSum:      .skip   21
dbX:        .quad 0
dbY:        .quad 0
dbSum:      .quad 0
chLF:       .byte 0xa //(NL Line feed, new line)
szPlus:     .asciz " + "
szEquals:   .asciz " = "

    .text

_start:
    //**Loads converts and stores szX into dbX**
    ldr     x0,=szX //loads address of szX into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbX //load into X1 the address of dbX
    str     x0,[x1] //dbX = result in x0

    //print szX    
    ldr     x0,=szX
    bl      putstring


    //*** Print +
    ldr    x0,=szPlus
    bl  putstring

    //NOW DO STRING Y
    //**Loads converts and stores szY into dby**
    ldr     x0,=szY //loads address of szX into X0
    bl      ascint64 //branch and link to ascint64 (convert cstring to int)

    ldr     x1,=dbY //load into X1 the address of dbX
    str     x0,[x1] //dbY = result in x0

    //print y
    ldr     x0,=szY
    bl      putstring

    //***********************

    //dbSum = dBX + dbY
    ldr     x1,=dbX //X1 -> address of dbX
    ldr     x1,[x1] //X1 = dbX

    ldr     x2,=dbY //X2 -> address of dbY
    ldr     x2,[x2] //X2 = dbY

    add     x0,x1,x2 //X0 = X1 + X2 .. X0 = dbX + dbY

    //now save X0 -> dbSum (dbSum = X0)
    ldr     x3,=dbSum //X3 -> address of dbSum
    str     x0,[x3] //contents of x0 stored in address x3

    ldr     x1,=szSum //converts sum to ascii
    bl      int64asc //branch and link int 64 to ascii

    //*** Print =
    ldr    x0,=szEquals
    bl  putstring

    //====NOW PRINT DB SUM=====
    ldr     x0,=szSum
    bl      putstring

    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end