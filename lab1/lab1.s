//
// Assembler program to print "Hello World!"
// to stdout.
//
// X0-X2 - parameters to Linux function services
// X8 - Linux function number
//
	.global _start // Provide program starting address
// Setup the parameters to print hello world
// and then call Linux to do it.


	.data//preprocessing directive
helloworld: .ascii "Aiden Sallows :D\n"

	.text//preprocessing directive

_start: mov X0, #1 // 1 = StdOut
	ldr X1, =helloworld // string to print
	mov X2, #17 // length of our string

	mov X8, #64 // Linux write systemcall
	svc 0 // Call Linux to output the string

	// Setup the parameters to exit the program
	// and then call Linux to do it.
	mov X0, #0 // Use 0 return code
	mov X8, #93 // Service code 93 terminates
	svc 0 // Call Linux to terminate

	.end