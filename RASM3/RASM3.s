    .global _start

    .equ MAX_LEN, 20 //const, used for getstring
    .equ BUFFER, 21

    .data 

//String variables used to display strings
szBuffer:      .skip BUFFER

szPromptSz1:     .asciz "s1 = "
szPromptSz2:     .asciz "s2 = "
szPromptSz3:     .asciz "s3 = "
szPromptSz4:     .asciz "s4 = "

szPrompt1:     .asciz "Enter String 1:"
szPrompt2:     .asciz "Enter String 2:"
szPrompt3:     .asciz "Enter String 3:"

szTrue:               .asciz "TRUE\n"
szFalse:              .asciz "FALSE\n"
szFAIL:               .asciz "FAIL\n"
szOutputStrLngth1:    .asciz "s1.length() = "
szOutputStrLngth2:    .asciz "s2.length() = "
szOutputStrLngth3:    .asciz "s3.length() = "
szOutputEq1:          .asciz "String_equals(s1,s3) = "
szOutputEq2:          .asciz "String_equals(s1,s1) = "
szOutputEqIC1:        .asciz "String_equalsIgnoreCase(s1,s3) = "
szOutputEqIC2:        .asciz "String_equalsIgnoreCase(s1,s2) = "
szOutputStrCpy:       .asciz "s4 = String_copy(s1)\n"
szOutputSub1:         .asciz "String_substring_1(s3,4,14) = "
szOutputSub2:         .asciz "String_substring_2(s3,7) = "
szOutputCharAt:       .asciz "String_charAt(s2,4) = "
szOutputStrStart1:    .asciz "String_startsWith_1(s1,11,\"hat.\") = " 
szOutputStrStart2:    .asciz "String_startsWith_2(s1,\"Cat\") = " 
szOutputStrEnds:      .asciz "String_endsWith(s1,\"in the hat.\") = "

szTest10Input:        .asciz "hat."
szTest11Input:        .asciz "Cat"
szTest12Input:        .asciz "in the hat."

szString1:            .skip 21 
szString2:            .skip 21 
szString3:            .skip 21
szString4:            .skip 21 
chLF:          .byte 0xa //new line
chQT:          .byte 0x22 // Quote character
chSQT:         .byte 0x27 //single quote character

    .text
_start:

    ldr     x0,=szPrompt1 //display prompt
    bl      putstring//branch and link putstring

    //receive input from user
    ldr     x0,=szString1 //loads address of szString1 into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt2 //display prompt
    bl      putstring//branch and link putstring

    //receive input from user
    ldr     x0,=szString2 //loads address of szString1 into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    ldr     x0,=szPrompt3 //display prompt
    bl      putstring//branch and link putstring

    //receive input from user
    ldr     x0,=szString3 //loads address of szString1 into x0
    mov     x1,MAX_LEN //moves what is in buffer to x1

    bl      getstring //branch and link getstring

    //prompt for string_equals
    ldr     x0,=chLF //print new line feed
    bl      putch

test1:
    //print string length of strings 1, 2, and 3
    ldr     x0,=szOutputStrLngth1
    bl      putstring

    ldr     x0,=szString1
    bl      String_length

    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    ldr     x0,=szOutputStrLngth2
    bl      putstring

    ldr     x0,=szString2
    bl      String_length

    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch 

    ldr     x0,=szOutputStrLngth3
    bl      putstring

    ldr     x0,=szString3
    bl      String_length

    ldr     x1,=szBuffer //retrieve szBuffer address
    bl      int64asc// bl(x0,*x1)

    ldr     x0,=szBuffer //store string value into x0
    bl      putstring // display x0

    ldr     x0,=chLF //print new line feed
    bl      putch

    ldr     x0,=chLF
	bl      putch
test2:
    ldr     x0,=szOutputEq1
    bl      putstring
    //load parameters for string_equals
    ldr     x0,=szString1
    ldr     x1,=szString3

    //call string_equals function
    bl      String_equals

    //check result
    cbz     x0, string_equals_false1
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test3
    
string_equals_false1:
    ldr     x0,=szFalse
    bl      putstring

test3:

    ldr     x0,=szOutputEq2
    bl      putstring
    //load parameters for string_equals
    ldr     x0,=szString1
    ldr     x1,=szString1

    //call string_equals function
    bl      String_equals

    //check result
    cbz     x0, string_equals_false2
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test4
    
string_equals_false2:
    ldr     x0,=szFalse
    bl      putstring



test4:
	ldr     x0,=chLF
	bl      putch

    ldr     x0,=szOutputEqIC1
    bl      putstring
    //load parameters for string_equalsIgnoreCase
    ldr     x0,=szString1
    ldr     x1,=szString3

    //call string_equalsIgnoreCase function
    bl      String_equalsIgnoreCase

    //check result
    cbz     x0, string_equals_IC_false1
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test5
    
string_equals_IC_false1:
    ldr     x0,=szFalse
    bl      putstring

test5:

    ldr     x0,=szOutputEqIC2
    bl      putstring
    //load parameters for string_equalsIgnoreCase
    ldr     x0,=szString1
    ldr     x1,=szString2

    //call string_equalsIgnoreCase function
    bl      String_equalsIgnoreCase

    //check result
    cbz     x0, string_equals_IC_false2
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test6
    
string_equals_IC_false2:
    ldr     x0,=szFalse
    bl      putstring

test6:
	ldr     x0,=chLF
	bl      putch
    //Now testing String_copy
    ldr     x0,=szOutputStrCpy
    bl      putstring

    ldr     x0,=szString1
	bl      String_copy
	
    //ERROR HERE LOOK AT LAB7 wALT
    ldr     x1, =szString4

    ldr     x2,[x0] //loads first 8 bytes and stores into szString4
	str     x2,[x1]
    
    ldr     x2,[x0,#8] //loads second 8 bytes and stores into szString4
    str     x2,[x1,#8]

	ldr     x0,=szPromptSz1
	bl      putstring

	ldr     x0, =szString1
	bl      putstring

	ldr     x0,=chLF
	bl      putch

	ldr     x0,=szPromptSz4
	bl      putstring

	ldr     x0, =szString4
	bl      putstring

	ldr     x0,=chLF
	bl      putch

test7:
	ldr     x0,=chLF
	bl      putch

   	ldr     x0,=szOutputSub1
	bl      putstring

	ldr     x0,=chQT
	bl      putch

    ldr     x0,=szString3
    mov     x1,#4
    mov     x2,#14

    bl      String_substring_1

    cbz     x0, substring1_fail
    //else substring was successful
    bl      putstring

	ldr     x0,=chQT
	bl      putch

    ldr     x0,=chLF
	bl      putch

    b       test8
substring1_fail:
    ldr     x0,=szFAIL
    bl      putstring

test8:
	ldr     x0,=chLF
	bl      putch

   	ldr     x0,=szOutputSub2
	bl      putstring

	ldr     x0,=chQT
	bl      putch

    ldr     x0,=szString3
    mov     x1,#7

    bl      String_substring_2

    cbz     x0, substring2_fail
    //else substring was successful
    bl      putstring

	ldr     x0,=chQT
	bl      putch

    ldr     x0,=chLF
	bl      putch

    b       test9
substring2_fail:
    ldr     x0,=szFAIL
    bl      putstring

test9:
	ldr     x0,=chLF
	bl      putch

   	ldr     x0,=szOutputCharAt
	bl      putstring

	ldr     x0,=chSQT
	bl      putch

    ldr     x0,=szString2
    mov     x1,#4

    bl      String_charAt

    cbz     x0, charat_fail
    //else charAt was successful
    bl      putch

	ldr     x0,=chSQT
	bl      putch

    ldr     x0,=chLF
	bl      putch

    b       test10
charat_fail:
    ldr     x0,=szFAIL
    bl      putstring

test10:
    ldr     x0,=chLF
    bl      putch

    ldr     x0,=szOutputStrStart1
    bl      putstring

    //load parameters for String_startsWith_1
    ldr     x0,=szString1
    mov     x1,#11
    ldr     x2,=szTest10Input

    //call string_equalsIgnoreCase function
    bl      String_startsWith_1

    //check result
    cbz     x0, stringStartsWith1_false
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test11
    
stringStartsWith1_false:
    ldr     x0,=szFalse
    bl      putstring

test11:
    ldr     x0,=chLF
    bl      putch

    ldr     x0,=szOutputStrStart2
    bl      putstring

    //load parameters for String_startsWith_2
    ldr     x0,=szString1
    ldr     x1,=szTest11Input

    //call string_equalsIgnoreCase function
    bl      String_startsWith_2

    //check result
    cbz     x0, stringStartsWith2_false
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test12
    
stringStartsWith2_false:
    ldr     x0,=szFalse
    bl      putstring

test12:
    ldr     x0,=chLF
    bl      putch

    ldr     x0,=szOutputStrEnds
    bl      putstring

    //load parameters for String_startsWith_2
    ldr     x0,=szString1
    ldr     x1,=szTest12Input

    //call String_endsWith function
    bl      String_endsWith

    //check result
    cbz     x0, stringEndsWith_false
    //else result was true
    ldr     x0,=szTrue
    bl      putstring

    b       test13
    
stringEndsWith_false:
    ldr     x0,=szFalse
    bl      putstring

test13:

exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0

    .end
