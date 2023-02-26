section .data
	msg1 db "Enter a number x: ", 0
	msg2 db "y = ", 0

section .bss
	x resb 10
	y resb 10

section .text
	global _start

_start:
	; Выводим на экран сообщение "Enter a number x: "
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, 17
	int 0x80

	; Читаем число x с клавиатуры
	mov eax, 3
	mov ebx, 0
	mov ecx, x
	mov edx, 1
	int 0x80

	; Конвертируем символ в число
	sub byte [x], '0'

	; Вычисляем y
	; первая дробь
	mov al, 2
	add al, byte [x]
	mov bl, 2
	add bl, 3
	div bl
	mov cl,al

	;вторая дробь
	mov al, 12
	mov dl, 6
	div dl

	sub cl,al
	;третья дробь
	mov al,13
	mul byte [x]
	mov bl,6
	div bl

	add cl,al

	; Конвертируем число в символ и сохраняем его в y
	add cl, '0'
	mov byte [y], cl

	; Выводим на экран сообщение "y = " и значение y
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, 4
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, y
	mov edx, 1
	int 0x80

	; Завершаем программу
	mov eax, 1
	xor ebx, ebx
	int 0x80