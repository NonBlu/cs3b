/********************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_toLowerCase: Set all characters in a string to lowercase
 *
 * Date: 4/10/24
 *
 *-------------------------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: holds address of original string
 *
 * Post-conditions:
 *	x0: holds converted lowercase version of original string
 *	
 *	Registers x0-x2 Link Register, Stack Pointer, and Frame Pointer will be modified
 *
 ********************************************************************************************/
.global String_toLowerCase	

String_toLowerCase:

	// *** Copy to Stack ***
	stp	LR,FP,[SP,#-16]!		// Load Link Register and Frame Pointer to Stack
	sub	SP,SP,#16			// Decrement stack by 16 bytes to reserve mem for string
	mov	FP,SP				// Move Frame Pointer to sync with Stack
	
	str	x0,[FP,#0]			// Store x0 in first index of Frame pointer 
	bl	String_length			// Branch and link to string length to get the length of string
	add	x0,x0,#1			// Skip null
	str	x0,[FP,#8]			// Store length in first index of Frame pointer

	bl	malloc				// reserve space for new string with malloc

	ldr	x1,[FP,#0]			// Load address of string into x1

main_loop:

	// *** test if lower case ***
	ldrb	w2,[x1],#1			// Load w2 with next byte from string
	
	cmp	w2,#'Z'				// Test if char greater than 'Z'
	bgt	is_lower			// Jump to is lower if string.charAt(i) > 'Z'

	cmp	w2,#'A'				// Test string.At(i) > 'A'
	blt	is_lower			// If yes, jump to skip conversion

	// *** else convert *** 
	add	w2,w2,#32			// Subtract 32 ('a'-'A') 
	
is_lower:
	
	// *** store lower case ***
	strb	w2,[x0],#1			// store w2 on in next byte of x0
	cbz	w2,finish			// if w2 is null, jump finish
	b	main_loop			// else continue looping

finish:
	
	// *** finished converting, restore SP, FP, LR ***
	ldr	x1,[FP,#8]			// load string length
	sub	x0,x0,x1			// x0 = string.charAt(0);
	
	add	SP,SP,#16			// Restore stack pointer
	ldp	LR,FP,[SP],#16			// Restore Link Register Frame pointer
	RET					// Return to calling function

.end
 
