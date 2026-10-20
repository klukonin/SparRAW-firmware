/* hwd_spi__release_lock @ 0x8f93e4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_spi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_spi__release_lock
hwd_spi__release_lock:
	.global L_8f93e4
L_8f93e4:
	mov_s r0,0x880a3c
L_8f93ea:
	st 0x4321,[r0, 0x4c]
L_8f93f2:
	mov_s r1,0x0
L_8f93f4:
	mov_s r0,0x880180
L_8f93fa:
	st_s r1,[r0,0x28]
L_8f93fc:
	j_s [blink]
L_8f93fe:
	nop_s
