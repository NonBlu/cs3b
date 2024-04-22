//================================================================================
//Programmer: Aiden Sallows
//Lab 16
//Purpose: Create a linked list 
//Date Last Modified: March 5th, 2024
//================================================================================
    .global _start
    .equ NODE_SIZE, 16
    .equ BUFFER, 21

    .data 
szBuffer:      .skip BUFFER
chLF:          .byte 0xa // new line

str1:  .asciz "The Cat in the Hat\n"
str2:  .asciz "\n"
str3:  .asciz  "By Dr. Seuss\n"
str4:  .asciz  "\n"
str5:  .asciz "The sun did not shine.\n"
headPtr:  .quad  0
tailPtr:  .quad  0

newNodePtr:     .quad 0
currentPtr:     .quad 0

    .text
_start:

// -------------------------------
// | &data (quad) | &next (quad) |
// -------------------------------
   //                     NODE
   // ------------------------------------------------------
   // |       *DATA              |         *NEXT           |
   // | 00 00 00 00 00 00 00 00  | 00 00 00 00 00 00 00 00 |
   // ------------------------------------------------------
//Node 1
//Step 0 : create the new node
    mov     x0,NODE_SIZE //node size is 16 bytes
    bl      malloc //dynamically allocate 16 bytes

    ldr     x1,=newNodePtr
    str     x0,[x1] //newNodePtr is now pointing to newly allocated space

//step1:
//step 1 : Get some memory from malloc for str1. then copy str1 into the newly malloc'd memory
    ldr     x0,=str1
    bl      String_copy

    ldr     x1,=newNodePtr
    ldr     x1,[x1] //load address of address pointed to by newnode
    str     x0,[x1] //store newly allocated string1 into newly allocated newNode space.

//step2: create linked list

    ldr     x1,=newNodePtr
    ldr     x1,[x1]

    ldr     x0,=headPtr
    str     x1,[x0]

    ldr     x0,=tailPtr
    str     x1,[x0]

//Node 2
//Step 0 : create the new node
    mov     x1,#0
    mov     x0,NODE_SIZE //node size is 16 bytes
    bl      malloc //dynamically allocate 16 bytes

    ldr     x1,=newNodePtr
    str     x0,[x1] //newNodePtr is now pointing to newly allocated space

//step1:
//step 1 : Get some memory from malloc for str1. then copy str1 into the newly malloc'd memory
    ldr     x0,=str2
    bl      String_copy

    ldr     x1,=newNodePtr
    ldr     x1,[x1] //load address of address pointed to by newnode
    str     x0,[x1] //store newly allocated string1 into newly allocated newNode space.

//step2: create linked list

    ldr     x1,=newNodePtr //load address heald by newnodeptr
    ldr     x1,[x1]

    ldr     x0,=tailPtr //load address held by headptr
    ldr     x0,[x0]
    add     x0,x0,#8 //increment by 8 to get next

    str     x1,[x0] //store

    ldr     x0,=tailPtr         //loads tailptr into x0
    str     x1,[x0]             //tailPtr = newNodePtr

//step0:
//Step 0 : create the new node
    mov     x1,#0
    mov     x0,NODE_SIZE //node size is 16 bytes
    bl      malloc //dynamically allocate 16 bytes

    ldr     x1,=newNodePtr
    str     x0,[x1] //newNodePtr is now pointing to newly allocated space

//step1:
//step 1 : Get some memory from malloc for str1. then copy str1 into the newly malloc'd memory
    ldr     x0,=str3
    bl      String_copy

    ldr     x1,=newNodePtr
    ldr     x1,[x1] //load address of address pointed to by newnode
    str     x0,[x1] //store newly allocated string1 into newly allocated newNode space.

//step2: create linked list

    ldr     x1,=newNodePtr //load address heald by newnodeptr
    ldr     x1,[x1]

    ldr     x0,=tailPtr //load address held by headptr
    ldr     x0,[x0]
    add     x0,x0,#8 //increment by 8 to get next

    str     x1,[x0] //store
    
    ldr     x0,=tailPtr         //loads tailptr into x0
    str     x1,[x0]             //tailPtr = newNodePtr

//Node 4
//Step 0 : create the new node
    mov     x1,#0
    mov     x0,NODE_SIZE //node size is 16 bytes
    bl      malloc //dynamically allocate 16 bytes

    ldr     x1,=newNodePtr
    str     x0,[x1] //newNodePtr is now pointing to newly allocated space

//step1:
//step 1 : Get some memory from malloc for str1. then copy str1 into the newly malloc'd memory
    ldr     x0,=str4
    bl      String_copy

    ldr     x1,=newNodePtr
    ldr     x1,[x1] //load address of address pointed to by newnode
    str     x0,[x1] //store newly allocated string1 into newly allocated newNode space.

//step2: create linked list

    ldr     x1,=newNodePtr //load address heald by newnodeptr
    ldr     x1,[x1]

    ldr     x0,=tailPtr //load address held by headptr
    ldr     x0,[x0]
    add     x0,x0,#8 //increment by 8 to get next

    str     x1,[x0] //store

    ldr     x0,=tailPtr         //loads tailptr into x0
    str     x1,[x0]             //tailPtr = newNodePtr

//Node 5
//Step 0 : create the new node
    mov     x1,#0
    mov     x0,NODE_SIZE //node size is 16 bytes
    bl      malloc //dynamically allocate 16 bytes

    ldr     x1,=newNodePtr
    str     x0,[x1] //newNodePtr is now pointing to newly allocated space

//step1:
//step 1 : Get some memory from malloc for str1. then copy str1 into the newly malloc'd memory
    ldr     x0,=str5
    bl      String_copy

    ldr     x1,=newNodePtr
    ldr     x1,[x1] //load address of address pointed to by newnode
    str     x0,[x1] //store newly allocated string1 into newly allocated newNode space.

//step2: create linked list

    ldr     x1,=newNodePtr //load address heald by newnodeptr
    ldr     x1,[x1]

    ldr     x0,=tailPtr //load address held by headptr
    ldr     x0,[x0]
    add     x0,x0,#8 //increment by 8 to get next

    str     x1,[x0] //store

    ldr     x0,=tailPtr         //loads tailptr into x0
    str     x1,[x0]             //tailPtr = newNodePtr
//loop that starts at the head, goes to tail where next is equal to null
//head points to node 1 which points to string
//tail points to final node which points to string

    bl      traverse

    bl      free_ll
//RASM
//keep counter of bytes allocated in the malloc manually
//you can add single strings in a while loop 
//whenever you view all the strings, print an index!
//

//Extra credit search: 
//Formatting + counter for number of lines hit

//

exit_sequence:
    //setup to end program
    mov X0, #0
    mov X8, #93
    svc 0


//PRINT
traverse:
    //preserve registers that may get gonked by malloc
    STR     X19, [SP, #-16]!
    STR     x30, [SP, #-16]!

    ldr     x19,=headPtr

traverse_top:

    LDR     x19, [x19]

    cmp     x19,#0           //check if headptr is zero
    beq     traverse_exit   //if zero then jump to exit

    ldr     x0,[x19]        //doubly de-refrence
    BL      putstring

    add     x19, x19, #8    //jump to the next node

    b       traverse_top


traverse_exit:
    LDR     X30, [SP], #16
    LDR     X19, [SP], #16
    RET LR 


//call free on dereferenced node on each iteration **current pointer
// first free string AND THEN free the node whole 16 bytes
// have two pointers, current and previous 
// previous = current
// current = current->next
free_ll:
    //preserve registers that may get gonked by malloc
    STR     X20, [SP, #-16]!
    STR     X21, [SP, #-16]!
    STR     x30, [SP, #-16]!

    //X20 will be currentnodeptr
    //X21 will be previousnodeptr
    ldr     x20,=headPtr //load our head into currentNode
    mov     x21,x20      //set our previousNode to currentNode

free_loop:
    //1.save headptr.next
    //2.






free_ll_exit:
    LDR     X30, [SP], #16
    LDR     X21, [SP], #16
    LDR     X20, [SP], #16
    RET LR 

        
    .end