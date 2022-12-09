section .data

; Define a 256-byte array to store the tape
tape: times 256 db 0

section .text

; Entry point
global _start

_start:
    ; Initialize the tape pointer to the start of the tape
    mov rdi, tape

    ; Read the input string
    mov rsi, rsp
    mov rax, 0
    call read_string

    ; Parse and execute the Brainfuck code
    mov rbx, rsi
    mov rax, 0
    call parse_and_execute

    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall

; Reads a null-terminated string from stdin into the memory pointed to by rsi
read_string:
    ; Read a character from stdin
    mov rax, 0
    mov rdi, 0
    mov rdx, 1
    syscall

    ; Check if the character is a newline or null terminator
    cmp al, 10
    je .done
    cmp al, 0
    je .done

    ; Store the character in the memory pointed to by rsi and increment rsi
    mov [rsi], al
    inc rsi

    ; Continue reading characters
    jmp read_string

.done:
    ; Return the length of the string
    mov rax, rsi
    sub rax, [rsp]
    ret

; Parses and executes the Brainfuck code stored in the memory pointed to by rbx
parse_and_execute:
    ; Read the next character from the input string
    mov al, [rbx]
    inc rbx

    ; Check if the character is a valid Brainfuck instruction
    cmp al, '>'
    je .increment_pointer
    cmp al, '<'
    je .decrement_pointer
    cmp al, '+'
    je .increment_value
    cmp al, '-'
    je .decrement_value
    cmp al, '.'
    je .output
    cmp al, ','
    je .input
    cmp al, '['
    je .loop_start
    cmp al, ']'
    je .loop_end

    ; If the character is not a valid instruction, continue to the next character
    jmp parse_and_execute

.increment_pointer:
    ; Increment the tape pointer
    inc rdi
    jmp parse_and_execute

.decrement_pointer:
    ; Decrement the tape pointer
    dec rdi
    jmp parse_and_execute

.increment_value:
    ; Increment the value at the current tape location
    inc byte [rdi]
    jmp parse_and_execute

.decrement_value:
    ; Decrement the value at the current tape location
    dec byte [rdi]
    jmp parse_and_execute

.output:
    ; Output the value at the current tape location to stdout
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    mov rsi, rdi
    syscall
    jmp parse
