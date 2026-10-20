/* hwd_phy__rgf_883200 @ 0x8cf8a8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.hwd_phy__rgf_883200,"ax",@progbits
	.global hwd_phy__rgf_883200
hwd_phy__rgf_883200:
	.global L_8cf8a8
L_8cf8a8:
	push_s r13
L_8cf8aa:
	mov_s r3,0x883200
L_8cf8b0:
	ld_s r13,[r3,0x18]
L_8cf8b2:
	st_s r0,[r3,0x18]
L_8cf8b4:
	ld_s r0,[r3,0x1c]
L_8cf8b6:
	st_s r1,[r3,0x1c]
L_8cf8b8:
	ld_s r0,[r3,0x20]
L_8cf8ba:
	st_s r2,[r3,0x20]
L_8cf8bc:
	j_s.d [blink]
L_8cf8be:
	pop_s r13
