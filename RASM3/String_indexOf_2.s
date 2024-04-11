/****************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_indexOf_2:  Return the index of the first instance of a specified
 *				char in a string starting from a specified index 
 *
 * Date: 4/9/24
 *
 *---------------------------------------------------------------------------------------
 * Preconditions:
 *	x0: holds the address of specified string
 *	x1: holds specified character
 *	x2: holds starting index
 * 
 * Postconditions:
 *	x0: Returns index of first occurance of specified char in string from given index
 *	
 *	Registers x0-x4 will be modified
 * 
 ****************************************************************************************/

	.global String_indexOf_2
	
	.text

String_indexOf_2:

	// *** move pointer to starting position in string ***
	add	x0,x0,x2

	// *** get char pointed to ***
	ldrb	w4,[x0],#1					// w4 holds char in x0

	mov	w3,#0x0						// init index counter

main_loop:
	
	// *** Test if the pointer is at end of string ***
	cbz	w4,not_found					// if w4 == null end

	// *** Test if char found ***
	cmp	w1,w4						// check if string[i] == char
	beq	match						// if string[i] == char jump to match

	// *** if not match, continue loop ***
	ldrb	w4,[x0],#1					// save next char in string in w4
	add	w3,w3,#0x1					// increment index
	b	main_loop					// repeat loop

match:

	// *** if(string[i] == char) {return i;} ***
	mov	w0,w3						// move index into w0
	RET							// Return (end function)

not_found:
	
	// *** If char not found in string ***
	mov	x0,#-1						// move -1 in x0
	RET							// return 

.end	 
