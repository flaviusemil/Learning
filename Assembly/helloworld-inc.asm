; Hello World Program (External file include)
; Compile with: nasm -f elf helloworld-inc.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-inc.o -o helloworld-inc
; Run with: ./helloworld-inc

%include 'functions.asm'                                ; include our external file

SECTION .data
msg1    db  'Hello, brave new world!', 0Ah              ; our first message string
msg2    db  'This is how we recycle in NASM.', 0Ah      ; our second message string

SECTION .text
global _start

_start:
    mov eax, msg1
    call sprint
    mov eax, msg2
    call sprint
    call quit