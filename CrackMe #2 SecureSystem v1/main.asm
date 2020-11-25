section .text
global _start

extern puts
extern printf
extern exit
extern scanf
extern strcmp
extern sleep
extern fopen
extern fgets
extern fscanf
extern strlen

_start:
    lea edi, [welcomeMessage]
    call puts
    lea edi, [putPassword]
    call puts
    lea edi, [toString]
    lea esi, [password]
    call scanf
    lea edi, [validPassword]
    lea esi, [password]
    call strcmp
    cmp eax, 0
    je password_granted
    jmp password_invalid
    
password_granted:
    lea edi, [newline]
    call puts
    lea edi, [welcomeAdmin]
    call puts
    lea edi, [loggedAsAdmin]
    call puts
    lea edi, [newline]
    call puts
    lea edi, [checkingLicense]
    call puts
    lea edi, [licenseFile]
    lea esi, [readMode]
    call fopen
    mov r9d, eax; FILE *ptr
    cmp eax, 0
    je license_not_valid
    lea edi, [licenseFileDetected]
    call puts
    lea edi, [licenseKey]
    mov esi, 0x50
    mov edx, r9d
    call fgets
    cmp eax, 0
    je license_not_valid
    lea edi, [verifyingLicense]
    lea esi, [licenseKey]
    call printf
    ;key-generator
    lea edi, [licenseKey]
    call strlen
    cmp eax, 0x20
    jne license_not_valid
    ;length ok
    mov r9b, [licenseKey]
    cmp r9b, 0x4E ;N
    jne license_not_valid
    mov r9b, [licenseKey + 0x4]
    cmp r9b, 0x4C ; L
    jne license_not_valid
    mov r9b, [licenseKey + 0x8]
    cmp r9b, 0x59  ; Z
    jle license_not_valid
    mov r9b, [licenseKey + 0xA]
    cmp r9b, 0x59
    jna license_not_valid; good Z [
    jmp license_accepted

license_accepted:
    lea edi, [licenseAccepted]
    call puts
    mov edi, 0x1
    call sleep
    jmp close_system
    
password_invalid:
    lea edi, [invalidPassword]
    call puts
    jmp close_system

close_system:
    lea edi, [exitSystemMessage]
    call puts
    mov edi, 0x1
    call sleep
    lea edi, [closingOpenedData]
    call puts
    mov edi, 0x1
    call sleep
    lea edi, [savingSystemFiles]
    call puts
    mov edi, 0x0
    call exit

license_not_valid:
    lea edi, [licenseReadFailure]
    call puts
    jmp close_system

section .data
    welcomeMessage db "Welcome in SecureSystem v1.0", 0
    putPassword db "Please put your administrator password: ", 0
    welcomeAdmin db "Welcome in SecureSystem!", 0
    loggedAsAdmin db "You are logged as Administrator!", 0
    invalidPassword db "I'm sorry your password is not valid", 0
    exitSystemMessage db "[SecureSystem] Shutting down...", 0
    closingOpenedData db "[SecureSystem] Closing opened data...", 0
    savingSystemFiles db "[SecureSystem] Save data...", 0
    licenseFileDetected db "[SecureSystem] License file detected..", 0
    checkingLicense db "[SecureSystem] Checking system license...", 0
    verifyingLicense db "[SecureSystem] Verifying license key %s", 0
    licenseReadFailure db "[SecureSystem] Something went wrong while reading license file :(", 0
    licenseAccepted db "[SecureSystem] Your license is accepted... See you soon in next task!", 0
    licenseFile db "license.txt", 0
    readMode db "r", 0
    password db "NULL", 0
    validPassword db "Secur3R00T", 0
    toString db "%s", 0
    newline db 10
    stars db "******************************************", 0
    licenseKey db "LICENSEKEY", 0