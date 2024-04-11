/********************************************************************************
 * Programmer: Spencer Glenn
 *
 * Subroutine String_concat: Takes two strings as arguements and creates once 
 *			concatenated string
 * Date: 4/10/24
 * 
 *-------------------------------------------------------------------------------
 * Pre-conditions:
 *	x0: holds address of str1
 *	x1: holds address of str2
 * Post-conditions:
 *	x0: holds the concatenated str
 *		Registers x0-x3 Link Register and Frame Pointer will be modified
 ********************************************************************************/

	.global String_concat
	
	.text

String_concat:

	stp	LR,FP,[SP,#-16]!			// Load link register and frame pointer onto stack
	sub	SP,SP,#32			// Move stack pointer down 32 bytes (prepare buffer)
	mov FP,SP				//Sync frame pointer and stack pointer

	// *** Store str1.length() + str2.length() in Frame Pointer ***	
	str	x0,[FP,#0]			// Store first string at first block of memory in FP
	str	x1,[FP,#8]			// Store second string at second adjacent block in FP
	
	bl	String_length			// get str1.length();
	str	x0,[FP,#16]			// Store str1.length() in next index of FP
	
	ldr	x0,[FP,#8]			// Pop second string from FP, save in x0
	bl	String_length			// get str2.length();
	ldr	x1,[FP,#16]			// get str1.lenght() from FP store in x1

	add	x0,x0,x1			// x0 = str1.length() + str2.length()	
	add	x0,x0,#1			// add additional byte of mem for null
	str	x0,[FP,#16]			// Store length of concatenated str in FP array
	
	bl	malloc				// Branch link to reserve memory
	
	ldr	x1,[FP,#0]			// x1 = str1
	ldr	x2,[FP,#8]			// x2 = str2

main_loop:
	
	ldrb	w3,[x1],#1			// w3 = str1[++i];
	cbz	w3,cat				// if str1[i] == null jump to cat
	strb	w3,[x0],#1			// Store w3 into next byte of x0
	b	main_loop			// jump to main_loop

cat:
	
	ldrb	w3,[x2],#1			// Load next byte of str2
	strb	w3,[x0],#1			// Store next byte of str2 to x0
	cbz	w3,finish			// If next byte == null jump to finish
	b	cat				// Else, loop again
	
finish:
	
	ldr	x1,[FP,#16]			// Load x1 with length of concatenated strings in FP array
	sub	x0,x0,x1			// Move string pointer to begining of string
	
	add	SP,SP,#32			// Restore Stack pointer and empty
	ldp	LR,FP,[SP],#32			// pop Link Register and Frame Pointer from stack
	RET					// return to calling function

.end
		
