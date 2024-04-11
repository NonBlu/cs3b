/******************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_indexOf_3(string str,string str1):int
 *
 * Purpose: This method returns the index of the first occurrence of specified 
 *		substring str, returns a signed int
 *
 * Date: 4/9/24
 *
 *-----------------------------------------------------------------------------
 *
 * Pre-Conditions:
 *	x0: Holds the address to the str
 *	x1: Holds address of substring for comparison
 *
 * Post-Conditions:
 *	x0: returns the index of the first instance of substring
 * 
 ******************************************************************************/

	.global String_indexOf_3		// starting address for linker

	.text

String_indexOf_3:

	stp	LR,x19,[SP,#-16]!		// push link register and x19 onto stack/update SP
	stp	x20,x21,[SP,#-16]!		// push x20 + x21 onto stack/update SP
	stp	x22,x23,[SP,#-16]!		// push x22 + x23 onto stack/update SP

	// *** Preserve addresses ***
	mov	x19,x0				// move address of string to x19
	mov	x20,x1				// move address of substring to x20

	// *** length of str ***
	bl	String_length			// branch link to get length of string
	mov	x21,x0				// Store the length of string into x21

	// *** length of substring ***
	mov	x0,x20				// move address of substring into x0
	bl	String_length			// get string length of substring
	mov	x22,x0				// move length of substring into x22

	// *** Check if substring longer than string ***
	cmp	x21,x22				// compare length of string to substring
	blt	not_found			// Jump to not found if string has less chars

	// *** Find last index to be examined ***
	sub	x23,x21,x22			// Subtracts substring from string/stores in x23
	add	x23,x23,#1			// increment x23 to get to last index
	mov	x4,#0				// initialize counter

	// *** Loop through strings to test for equality ***

main_loop:	
	
	// *** Load characters for comparison ***
	ldrb	w2,[x19],#1			// Load first byte in x19
	ldrb	w3,[x20]			// Load byte in x20

	cmp	w2,w3				// compare characters
	beq	inc_test			// jump to increment pointers to indexes

not_eq:
	
	add	x4,x4,#1			// add 1 to index
	cmp	x4,x23				// check if at last index
	beq	not_found			// if at last index substring was not found
	b	main_loop			// else jump to loop top and continue process

inc_test:
	
	// *** if string[i] == substr[i] ***
	// mov	x5,x19				// move string index pointer to x5
	// add	x6,x20,#1			// increment and store substring index pointer

	// *** check character equality ***
	ldrb	w2,[x19],#1			// load char pointed to by x5
	ldrb	w3,[x20],#1			// load char pointed to by x6

	cmp	w2,w3				// compare equality string[i] == substring[i]
	beq	inc_test

	cbz	w3,match			// if substring[i]==0 then substring was found
	b	not_eq				// else, substring was not found

match:

	// *** Match is found return first instance of substring ***
	add	x4,x4,#1
	
	mov	w0,w4				// move index of found substring to reg 0
	b	exit				// jump to exit

not_found:

	// *** return -1 if not found ***
	mov	x0,#-1				// move -1 into register 0
	b	exit

exit:
	ldp	x22,x23,[SP],#16		// pop x22 + x23 from stack, increment stack pointer
	ldp	x20,x21,[SP],#16		// pop x20 + x21 from stack, increment stack pointer
	ldp	LR,x19,[SP],#16			// pop link register + x19 from the stack, incr SP
	RET					// return (end function)

.end  
