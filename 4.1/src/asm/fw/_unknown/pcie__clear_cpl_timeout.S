/* pcie__clear_cpl_timeout @ 0x8f28d4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dpal__cpl_timeout_evt
 */
	.section .text.pcie__clear_cpl_timeout,"ax",@progbits
	.global pcie__clear_cpl_timeout
pcie__clear_cpl_timeout:
	.global L_8f28d4
L_8f28d4:
	mov r1,0x3e7
L_8f28d8:
	mov_s r0,0x882d00
L_8f28de:
	st_s r1,[r0,0x4]
L_8f28e0:
	mov_s r0,0x882680
L_8f28e6:
	st 0x1000,[r0, 0xc]
L_8f28ee:
	st 0x1000,[r0, 0x20]
L_8f28f6:
	j_s [blink]
