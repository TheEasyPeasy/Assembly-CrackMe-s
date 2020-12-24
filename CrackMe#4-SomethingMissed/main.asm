extern puts
extern exit
extern ptrace
extern printf

section .text
global _start

_start:
    xor rdi, rdi
    xor rsi, rsi
    xor rdx, rdx
    call ptrace
    cmp al, 0
    jl close
    push rdi
    jmp flow


flow:
    xor rax, rax
    push rax
    mov rax, 0x58419503
    xor rax, rax
    mov rax, 0x54396032
    push rdi
    mov rdi, 0x63082211
    xor rax, rdi
    jmp flow2

flow2:
    xor eax, eax
    cmp eax, 0x0
    jle flow3
    jne flow4
    

flow3:
    mov rax, 0
    cmp rax, 0
    je flow5

flow4:
    push rax
    push rdx
    mov rax, 0
    mov rdx, 0
    inc rdx
    dec rax
    inc rax
    inc rdx
    jmp flow3

flow5:
    push rdx
    xor rdx, rdx
    push r9
    lea r9, [encFlag]
    mov rdx, 1
    lea rax, [encFlag]
    lea r11, [ourFlag]
    jmp dump_me


dump_me:
    mov rdx, 0
    mov BYTE [rax + rdx], 0x74
    mov BYTE[r11 + rdx], 0x73
    inc rdx
    mov BYTE [rax + rdx], 0x65
    mov BYTE[r11 + rdx], 0x62
    inc rdx
    mov BYTE[r11 + rdx], 0x73
    dec rdx
    mov BYTE[r11 + rdx], 0x55
    mov BYTE [rax + rdx], 0x33
    mov BYTE[r11 + rdx], 0x61
    dec rdx
    mov BYTE[rax + rdx], 0x55
    inc rdx
    inc rdx
    mov BYTE[r11 + rdx], 0x50
    mov rdx, 0
    mov BYTE[rax + rdx], 0x68
    mov rdx, 2
    mov BYTE[rax + rdx], 0x4D
    mov BYTE[r11 + rdx], 0x55
    mov BYTE[r11 + rdx], 0x33
    push r9
    mov r9, rdx
    inc r9
    inc r9
    inc rdx
    dec r9
    dec rdx
    mov BYTE[rax + rdx], 0x4C
    inc rdx
    mov BYTE[rax + rdx], 0x54
    mov BYTE[rax + rdx], 0x52
    dec rdx
    inc rdx
    dec rdx
    inc rdx
    inc rdx
    inc rdx
    dec rdx
    inc rdx
    dec rdx
    dec rdx
    mov BYTE[rax + rdx], 0x4C
    dec rdx
    inc rdx
    dec rdx
    inc rdx
    inc rdx
    inc rdx
    dec rdx
    mov BYTE[rax + rdx], 0x4C
    inc rdx
    dec rdx
    dec rdx
    inc rdx
    mov BYTE[rax + rdx], 0x30
    lea rdi, [hopeSaw]
    call puts
    jmp end

close:
    push rdi
    mov rdi, [detectedMessage]
    call puts
    jmp end

end:
    mov rdi, 0
    call exit


section .data
    detectedMessage db "Please turn off your debugger! :)", 0
    hopeSaw db "I hope you saw your password in debugger! :)", 0
    newLine db 10
    ourFlag db "", 0
    encFlag db "asdb", 0