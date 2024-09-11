; MILIX Kernel - kernel.asm

org 100h  ; Origin for .COM file

section .data
    boot_msg db 'MILIX Kernel - Booting...', 0
    shell_name db 'SHELL.COM', 0
    welcome_msg db 'Welcome to MILIX!', 0

section .text
start:
    ; Set video mode to 80x25 text mode (default)
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Clear the screen
    mov ah, 0x06
    mov al, 0x00
    mov ch, 0x00
    mov cl, 0x00
    mov dh, 0x19
    mov dl, 0x4F
    int 0x10

    ; Display welcome message
    mov ah, 0x0E
    mov si, welcome_msg
print_welcome:
    lodsb
    cmp al, 0
    je end_print_welcome
    int 0x10
    jmp print_welcome
end_print_welcome:

    ; Display boot message
    mov ah, 0x0E
    mov si, boot_msg
print_boot:
    lodsb
    cmp al, 0
    je end_print_boot
    int 0x10
    jmp print_boot
end_print_boot:

    ; Load and execute the shell
    mov ah, 0x4B       ; DOS function to load and execute a program
    lea dx, [shell_name]
    int 0x21
    ; If the shell execution fails, halt the system
    mov ah, 0x4C
    int 0x21

; Optional: Add more functionalities like handling system calls or managing other modules

