<h1>Solution</h1>

Let's look on start function

```assembly
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
```

Program load input from user and check length is equal 0xF = 15, if not exit program



```assembly
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
```

Next we check our int is less or equal 0xE = 14 and jump into decrypt_password function



```assembly
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
```

In this function user input is "decrypted", every char is casted to (char) and check modulo(char % 2 ==0)
and then jump to dividable function

```assembly
dividable:
    sub rdi, 0x3
    mov rax, rdi
    mov [inputString + r9d], rax
    inc r9d
    jmp printf_password
```

Dividable function take char and just add 0x3 into it (look at ascii table)
and increment our loop integer then jump back into printf_password

Let's focus what happen if our char is not dividable by 2

```assembly
    add rdi, 0x5
    mov rax, rdi
    mov [inputString + r9d], rax
    inc r9d
    jmp printf_password
```

We just do similar thing, now just we substract our char by 0x5


```assembly
    lea edi, [inputString]
    lea esi, [inputStringConst]
    call strcmp
    cmp eax, 0
    je show_password
    lea edi, [notValidPassword]
    call puts
    jmp end
```

After all we check if our encrypted input is equal <b>p8`w0y\u=xp|-wa</b>
We can just imagine it's our password "hash" =)