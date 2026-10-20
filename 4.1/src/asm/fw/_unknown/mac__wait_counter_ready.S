/* mac__wait_counter_ready @ 0x8e47d0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__read_counter_886d64
 */
	.section .text.mac__wait_counter_ready,"ax",@progbits
	.global mac__wait_counter_ready
mac__wait_counter_ready:
	.global L_8e47d0
L_8e47d0:
	breq_s r2,0,L_8e47de
	.global L_8e47d2
L_8e47d2:
	mov_s r0,0x886e80
L_8e47d8:
	ld_s r0,[r0,0x34]
L_8e47da:
	bbit0 r0,0x1f,L_8e47d2
	.global L_8e47de
L_8e47de:
	mov_s r2,0x886f80
L_8e47e4:
	ld_s r3,[r2,0x44]
L_8e47e6:
	st_s r3,[r1]
L_8e47e8:
	ld_s r0,[r2,0x48]
L_8e47ea:
	st_s r0,[r1,0x4]
L_8e47ec:
	ld_s r0,[r2,0x44]
L_8e47ee:
	brne r3,r0,L_8e47de
L_8e47f2:
	j_s [blink]
