/***************************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_lastIndexOf_1: Returns the last instance of char in string
 *
 * Date: 4/9/24
 *
 *--------------------------------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: holds address of passed string
 *	x1: holds character to test for
 *
 * Post-conditions:
 *	x0: contains last instance of specified char
 *
 *	Registers x0-x4 stack pointer and link register will be modified
 *
 ***************************************************************************************************/

	.global	String_lastIndexOf_1			// Starting address for linker

	.text

String_lastIndexOf_1:

	str	LR,[SP,#-16]!				// Push link register onto stack update top of stack
	stp	x19,x20,[SP,#-16]!			// Push x19 and x20 onto the stack

	mov	x19,x0					// store string in x19 
	mov	x20,x1					// store char in x20

	// *** Get the length of the string ***
	bl	String_length				// branch link to String_length

	// *** Set index counter variable ***
	sub	w0,w0,#1				
	add	x19,x19,x0				// increase pointer by length of string

	ldrb	w2,[x19],#-1				// get char

main_loop:
	
	// *** Test for end of string ***
	cmp	w0,#-1					// compare w0 to -1
	beq	no_match				// branch if index is equal to -1
	
	// *** Test if char matches ***
	cmp	w20,w2					// check if char is found
	beq	match					// jump to match if char found

	sub	w0,w0,#0x1				// decrement string pointer
	ldrb	w2,[x19],#-1				// get next char in string
	b	main_loop				// loop again

no_match:

	mov	x0,#-1					// return -1 because match not found

match:
	ldp	x19,x20,[SP],#16			// pop x19 and x20 from stack
	ldr	LR,[SP],#16				// pop link reg from stack
	RET

.end
