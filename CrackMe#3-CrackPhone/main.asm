extern puts
extern gets
extern strlen
extern exit

section .text
global _start

_start:
    lea rdi, [welcomeMessage]
    call puts
    lea rdi, [inputPinMessage]
    call puts
    lea rdi, [enteredKey]
    call gets
    call validate_key

validate_key:
    push rbp
    mov rbp, rsp
    lea rax, [enteredKey]
    mov rdi, rax
    call strlen
    cmp eax, 0x6
    jne invalid_key
    push rdx
    mov rdx, 0x5
    mov rcx, rdx
    pop rdx
    sub rcx, 0x1
    sub rcx, 0x5
    push rdx
    mov rdx, rcx
    pop rcx
    add rdx, 0xFFFFF
    sub rdx, 0x5
    pop rdx
    push r9
    mov r9b, [enteredKey + 0x1]
    cmp r9b, 0x34
    jne invalid_key
    nop
    mov rcx, 5
    push rax
    mov r9b, [enteredKey + 0x2]
    cmp r9b, 0x33
    je invalid_key
    pop r9
    push r10
    mov r10, 0x5
    pop r10
    pop rax
    sub rcx, 5
    mov r11b, [enteredKey + 0x3]
    cmp r11b, 0x37
    jne invalid_key
    pop rcx
    push r9
    mov r9b, [enteredKey + 0x4]
    cmp r9b, 0x34
    je invalid_key
    cmp r9b, 0x35
    je invalid_key
    cmp r9b, 0x33
    je invalid_key
    cmp r9b, 0x32
    je invalid_key
    cmp r9b, 0x31
    je invalid_key
    mov rcx, r9
    mov rdx, rcx
    sub rcx, 0x33
    nop
    cmp rdx, 0x30
    jne invalid_key
    mov rcx, 5
    push rax
    pop rax
    sub rcx, 5
    add rcx, 5
    sub rcx, 5
    add rcx, 5
    mov rcx, [enteredKey + 0x5]
    sub rcx, 0x9
    add rcx, 0x5
    add rcx, 0x4
    cmp cl, 0x39
    jne invalid_key
    jmp valid_key

valid_key:
    lea rdi, [congratulationsMessage]
    call puts
    jmp end

invalid_key:
    lea rdi, [invalidMessage]
    call puts
    jmp end

end:
    mov edi, 0
    call exit

section .data
    welcomeMessage db "[!] Welcome in CrackPhone [!]", 0
    inputPinMessage db "Please input your PIN", 0
    congratulationsMessage db "Congratulations your pin is valid!", 0
    invalidMessage db "Your pin is not valid, try again :(", 0
    enteredKey db "", 0
