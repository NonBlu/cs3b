/****************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_replace: Replaces all instances of a char in a string
 *				 with a given char
 * Date: 4/10/24
 *
 *---------------------------------------------------------------------------------------
 * Pre-conditions: 
 *	x0: address of string1
 *	x1: ASCII char of char in string to be replaced
 *	x2: ASCII code of the char to go in its place
 * 
 * Post-conditions:
 *	x0: Returns string with replaced chars 
 *	Registers x0-x4 Link Register, Frame Pointer, and Stack Pointer will be modified
 *
 ****************************************************************************************/

	.global String_replace				// Starting address for linker

	.text

String_replace:

	// *** Reserve Space on Stack ***

	stp	LR,FP,[SP,#-16]!			// Loading Link Register and Frame Pointer to stack
	sub	SP,SP,#32				// Decrement stack pointer 32 Bytes 
	mov	FP,SP					// Decrement Frame Pointer 32 Bytes

	// *** Store original string and chars into Frame Pointer ***

	str	x0,[FP,#0]				// Store original string
	str	w1,[FP,#8]				// Store first char into FP at next index
	str	w2,[FP,#16]				// Store first char into FP at next index

	bl	String_length				// Branching and linking to of String_length og string
	
	add	x0,x0,#1				// Add one to move past null char 
	str	x0,[FP,#24]				// Store length of string 1 into next index of FP
	
	// *** Reserve memory for length of new string ***
	
	bl	malloc					// branch link to malloc

	ldr	x1,[FP,#0]				// Loading address of string into x1
	ldr	w2,[FP,#8]				// Load w2 with Char being replaced
	ldr	w3,[FP,#16]				// load w3 with Char replacing

main_loop:
	
	// *** Load next byte from string ***

	ldrb	w4,[x1],#1				// Load with next byte of string
	
	cmp	w4,w2					// check for equality, if true replace
	beq	replace					// if eq jump to replace
	b	store					// else, store char in new String/check for null

replace:

	strb	w3,[x0],#1				// Store replacing char in next byte of x0
	b	test_null				// test if at last index

store:

	strb	w4,[x0],#1				// Store replaced char on next byte of x0

test_null:
	
	cbnz	w4,main_loop				// If not at end return to loop top
	
	ldr	x1,[FP,#24]				// Load length of string from frame pointer into x1
	sub	x0,x0,x1				// Set string pointer to begining of line
	
	add	SP,SP, #32				// Restore stack pointer
	ldp	LR,FP,[SP]				// Restore link register and frame pointer
	RET						// Return to calling function

.end
	  
