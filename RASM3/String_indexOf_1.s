/*************************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine: String_indexOf_1: Returns the index of first occurence of the specified 
 *				char in string
 *
 * Date: 4/9/24
 *
 *------------------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: Holds address of string
 *	x1: Holds address of char
 * Post-conditions:
 *	x0: Returns the index of first instance of character held in x1
 *	
 *	Registers x0-x4 will be modified
 *
 *************************************************************************************/

	.global String_indexOf_1		// Starting address for linker

	.text

String_indexOf_1:

	// *** get char in string ***
	ldrb	w3,[x0],#1			// load first char in x0, increments x0
	mov	w2,#0x0				// init counter variable

main_loop:
	
	// *** Test if at end of string ***
	cbz	w3,not_found			// jump to not found if w3 == null
	
	// *** Test string[i] == char ***
	cmp	w1,w3				
	beq	found_char			// jump to found char if string[i] == char

	// *** if(string[i] != char) ***
	ldrb	w3,[x0],#1			// load next byte into w3, increment x0
	add	w2,w2,#0x1			// increment index
	b	main_loop			// jump to main loop to repeat process

found_char:
	
	// *** return answer ***
	mov	w0,w2				// move index into w0
	RET

not_found:
	
	// *** return -1 for not found ***
	mov	x0,#-1				// move -1 into x0
	RET					// Return

.end 
