/*************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_lastIndexOf_3: Returns index of last instance of 
 *					substring within given string
 *
 * Date: 4/10/24
 *
 *------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: address of string
 *	x1: address of substring
 * 
 * Post-conditions:
 *	x0: Returns the index of first instance of substring 
 *
 *	Registers x0 - x6 + Link Register and Stack Pointer will be modified
 *
 *************************************************************************/

	.global String_lastIndexOf_3			//Start address for linker

	.text

String_lastIndexOf_3:

	stp	LR,x19,[SP,#-16]!			// Push LR and x19 onto stack
	stp	x20,x21,[SP,#-16]!			// Push x20 and x21 onto stack
	stp	x22,x23,[SP,#-16]!			// Push x22 and x23 onto stack

	// *** Store addresses ***
	mov	x19,x0					// move address of string to x19
	mov	x20,x1					// move substring into x20

	// *** Get length of string ***
	bl	String_length				// Branch link to get length of string
	mov	x21,x0					// store length of given string in x21
	
	add	x19,x19,x21				// Increment string pointer by length of string
	sub	x19,x19,#1				// Set string pointer to end of string

	// *** Get length of substring ***
	mov	x0,x20					// move addr of substring into x0
	bl	String_length				// Branch link to get length of substring
	mov	x22,x0					// store length in x22
	
	add	x20,x20,x22				// move pointer to end of substring
	sub	x20,x20,#1				// subtract 1 to skip null

	// *** Test if (substr.length() > string.length()) ***
	cmp	x22,x21
	bge	no_match				// if (substr.length() > string.length()){end}

	// *** Find last index to test ***
	sub	x23,x22,#1				// Decrement size
	mov	x4,x21					// init index counter var
	sub	x4,x4,#1				// Set index to represent end of string

main_loop:
	
	// *** Get characters to test ***
	ldrb	w2,[x19],#-1				// Get string.at(i)
	ldrb	w3,[x20]				// Get char substring currently pointing to

	// *** Test if (string[i] == sub[i]) ***
	cmp	w2,w3					// Compare chars for equality
	beq	match					// if index matches char jump to match

no_match:						// (string[i] != sub[i]
	
	// *** Move string index ***
	sub	x4,x4,#1				// Move over one char to the left

	// *** check for final index ***
	cmp	x4,x23					// Compare if at first index of string (last iteration of loop)	
	beq	fail					// If final index prepare to return -1

	b	main_loop				// Else Try loop again

match:
	// *** If string[i] == substring[i] ***
	mov	x5,x19					// store string[i] in x5
	
	// *** Stores str current index pointer ***
	sub	x6,x20,#1				// substring[i--]
	
	// *** Init x22 = substr.length() ***
	mov	x22,x0					// x22 -> substr.length();
	
test_word:
	
	// *** retrieve characters saved ***
	ldrb	w2,[x5],#-1				// Load w5 into w2, decrement register
	ldrb	w3,[x6],#-1				// Load byte into w3, decrement register
	
	sub	x22,x22,#1				// decrement size counter

	// *** if(string[i] == sub[i]) ***
	cmp	w2,w3					 
	beq test_word					// jump to test next char
	
	// *** else if (sub[i] == sub[i].end())
	cmp	x22,#0					// if(x22 - 0 == 0)
	beq	true					// match found 
	b	no_match				// else no match

true:
	
	// *** Return index in string substring starts ***
	sub	w0,w4,w23				// w0 = w4 - w23 (starting index found)
	b	quit					// Jump to end 

fail:
	
	// *** Not found return false ***
	mov	x0,#-1					// x0 = -1
	b	quit					// jump to end

quit:
	
	// *** pop registers and link register from stack ***

	ldp	x22,x23,[SP],#16			// pop x22 + x23 from stack
	ldp	x20,x21,[SP],#16			// pop x20 + x21 from stack  
	ldp	LR,x19,[SP],#16				// pop link register + x19 

	RET						// Return to calling function

.end
