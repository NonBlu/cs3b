/*************************************************************************************
 * Programmer: Spencer Glenn
 * 
 * Subroutine String_toUpperCase: Takes a string and converts it into all caps
 * 
 * Date: 4/11/24
 *
 *=====================================================================================
 * Pre-condition:
 *	x0: holds address to string
 *
 * Post-condition:
 *	x0: holds the all caps version of original string
 *	
 *	
 *	Registers x0-x2 Stack Pointer, Link Register, and Frame Pointer are modified 
 *************************************************************************************/

	.global	String_toUpperCase				// start address for linker

	.text

String_toUpperCase:

	// *** Initialize Stack and Frame Pointer ***
	stp	LR,FP,[SP,#-16]!				// Load Link Register and Frame Pointer onto stack
	sub	SP,SP,#16					// Move the Stack Pointer down 16bytes for string
	mov	FP,SP						// Sync Frame pointer with Stack Pointer

	// *** Reserve string.length() ***
	str	x0,[FP,#0]					// Store original string in first index of FP
	bl	String_length					// get length of string
	add	x0,x0,#1					// Add null byte
	str	x0,[FP,#8]					// Store the length of the string in FP[1]
	
	bl	malloc						// reserve memory for length of new string

	ldr	x1,[FP,#0]					// Load string into x1 from FP[0]

main_loop:
	
	// *** Load next byte of string ***

	ldrb	w2,[x1],#1					// load next byte of string into w2
	
	cmp	w2,#'z'						// check if w2 > 'z'
	bgt	is_upper						// Skip conversion

	cmp	w2,#'a'						// if(string.charAt(i) < 'a'
	blt	is_upper					// String is already upper

	sub	w2,w2,#32					// Subtract the ASCII value 
	
is_upper:
	
	// *** Store conversion ***
	strb	w2,[x0],#1					// store w2 into next byte of x0
	cbz	w2,finish					// if at null char, return converted string
	b	main_loop					// else, continue looping through string

finish:
	// *** move pointer to string to string[0] *** 
	ldr	x1,[FP,#8]					// Load x1 with string length from FP[1]
	sub	x0,x0,x1					// Move string pointer to begining of string

	// *** reset SP,FP,LR ***
	add 	SP,SP,#16					// Add #16 bytes to restore stack pointer
	ldp		LR,FP,[SP],#16					// restore link register and frame pointer
	RET 							// return to calling function
.end
