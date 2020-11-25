extern puts
extern printf
extern exit
extern scanf
extern strlen
extern strcmp

section .text
global _start

_start:
    lea edi, [inputPassword]
    call puts
    lea edi, [toString]
    lea esi, [inputString]
    call scanf
    mov esi, 0 ;clear argument
    lea edi, [inputString]
    call strlen
    mov edi, 0 ;clear argument
    cmp eax, 0xF
    jne not_valid_length
    mov r9d, 0
    jmp printf_password

printf_password:
    cmp r9d, 0xE
    jle decrypt_password
    lea edi, [inputString]
    lea esi, [inputStringConst]
    call strcmp
    cmp eax, 0
    je show_password
    lea edi, [notValidPassword]
    call puts
    jmp end


decrypt_password:
    mov rax, [inputString + r9d]
    mov rdi, rax
    mov eax, r9d
    mov edx, 0
    mov ecx, 0x2
    div ecx
    cmp edx, 0
    je dividable
    add rdi, 0x5
    mov rax, rdi
    mov [inputString + r9d], rax
    inc r9d
    jmp printf_password

dividable:
    sub rdi, 0x3
    mov rax, rdi
    mov [inputString + r9d], rax
    inc r9d
    jmp printf_password


show_password:
    lea edi, [correctPassword]
    call printf
    lea edi, [newLine]
    call puts
    jmp end

not_valid_length:
    lea edi, [notValidLength]
    mov esi, eax
    call printf
    lea edi, [newLine]
    call puts
    jmp end

end:
    mov rdi, 0xa
    call exit


section .data
    inputPassword db "Please input your password to access: ", 0
    encryptChar dw 50
    toString db "%s", 0
    toChar db "%c", 0
    debug db "DEBUG", 0
    notValidPassword db "Your password is invalid!", 0
    notValidLength db "Your string is not valid length %i", 0
    correctPassword db "Congratulations our secret password is correct!", 0
    inputString db "p8`w0y\u=xp|-wa", 0
    inputStringConst db "p8`w0y\u=xp|-wa", 0
    newLine db 10