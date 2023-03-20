section .data
filename db 'file.txt', 0
msg1 db 'Введите ваше имя: '
msg2 db 'Пользователю ', 0
msg3 db ' разрешены действия в системе.', 0
format db '%d.%m.%Y %H:%M:%S', 0

section .bss
name resb 64
buffer resb 64

section .text
global _start

; Вывод запроса пользователю на ввод его имени
_start:
mov eax, 4      ; sys_write
mov ebx, 1      ; stdout
mov ecx, msg1   ; message
mov edx, 18     ; message length
int 0x80        ; system call

; Ввод имени с клавиатуры
mov eax, 3      ; sys_read
mov ebx, 0      ; stdin
mov ecx, name   ; buffer
mov edx, 64     ; buffer size
int 0x80        ; system call

; Вывод сообщения
mov eax, 4      ; sys_write
mov ebx, 1      ; stdout
mov ecx, msg2   ; message
mov edx, 14     ; message length
int 0x80        ; system call

mov eax, 4      ; sys_write
mov ebx, 1      ; stdout
mov ecx, name   ; name
mov edx, 64     ; name length
int 0x80        ; system call

mov eax, 4      ; sys_write
mov ebx, 1      ; stdout
mov ecx, msg3   ; message
mov edx, 30     ; message length
int 0x80        ; system call

; Создание файла
mov eax, 8      ; sys_creat
mov ebx, filename   ; file name
mov ecx, 0644   ; file permissions
int 0x80        ; system call

; Открытие файла для записи
mov eax, 5      ; sys_open
mov ebx, filename   ; file name
mov ecx, 1      ; O_WRONLY
mov edx, 0644   ; file permissions
int 0x80        ; system call
mov ebx, eax    ; сохраняем файловый дескриптор в ebx

; Запись даты и времени в файл
mov eax, 0      ; sys_time
int 0x80        ; system call
mov dword [buffer], eax  ; сохраняем количество секунд в buffer
mov eax, 4      ; sys_write
mov ebx, 2      ; stderr
mov ecx, buffer ; buffer
mov edx, 4      ; buffer length
int 0x80        ; system call

mov eax, 0      ; sys_time
mov ebx, buffer ; buffer
mov ecx, format ; format
int 0x80        ; system call
mov dword [buffer], eax  ; сохраняем время в buffer

mov eax, 4      ; sys_write
mov ebx, 2      ; stderr
mov ecx, buffer ; buffer
mov edx, 20     ; buffer length
int 0x80        ; system call

mov eax, 4      ; sys_write
mov ebx, ebx    ; file descriptor
mov ecx, buffer ; buffer
mov edx, 20     ; buffer length
int 0x80        ; system call

;
