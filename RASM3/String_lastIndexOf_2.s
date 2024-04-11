/*****************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_lastIndexOf_2: Returns last occurrence of char in a string from
 *					specified index
 *----------------------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: address of string passed in
 *	x1: address of char for comparison
 *	x2: carries string index started from
 * Post-conditions:
 *	x0: returns index of final insatance of char held in register x1
 *	Registers x0-x4 will be modified
 *
 *****************************************************************************************/

	.global String_lastIndexOf_2			// Start address for linker

	.text

String_lastIndexOf_2:

	mov	x3,x2					// move start index to x3
	add	x0,x0,x2				// add starting index to addr of string

	// *** load first char to test ***

	ldrb	w4,[x0],#-1				// Load char into w4

main_loop:

	cmp	w3,#-1					// test if at end of string
	beq	no_match				// jump to no match if at end of string
	
	cmp	w1,w4					// compare the char in string to char
	beq	match					// if string[i] == char jump to match

	sub	w3,w3,#0x1				// decrement index
	ldrb	w4,[x0],#-1				// load char into w4
	b	main_loop				// run loop again

match:
	mov	x0,x3					// move x3 into x0 to return index found at
	RET

no_match:
	
	mov	x0,#-1					// return -1 to indicate no match found
	RET

.end
