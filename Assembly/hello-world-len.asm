; Hello World Program (Calculating string length)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len

SECTION .data
msg db  'Hello, brave new world!', 0Ah ; we can modify this now without having to update anywhere else in the program

SECTION .text
global  _start

_start:

    mov eax, msg        ; move the address of our message string into EAX
    call strlen         ; call our function to calculate the length of the string

    mov edx, eax        ; our function leaves the result in EAX
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h

strlen:                 ; this is our first function declaration
    push ebx            ; push the value in EBX onto the stack to preserve it while we use EBX in this function
    mov ebx, eax        ; move the address in EAX into EBX (Both point to the same segment in memory)
 
nextchar:
    cmp byte[eax], 0    ; compare the byte pointed to by EAX at this address against zero (Zero is an end of string delimiter)
    jz  finished        ; jump (if the zero flagged has been set) to the point in the code labeled 'finished'
    inc eax             ; increment the address in EAX by one byte (if the zero flagged has NOT been set)
    jmp nextchar        ; jump to the point in the code labeled 'nextchar'

finished:
    sub eax, ebx        ; subtract the address in EBX from the address in EAX
                        ; remember both registers started pointing to the same address (see line 15)
                        ; but EAX has been incremented one byte for each character in the message string
                        ; when you subtract one memory address from another of the same type
                        ; the result is number of segments between them - in this case the number of bytes

    pop ebx             ; pop the value on the stack back into EBX
    ret                 ; return to where the function was called