/* l2mgr__set_edca_defaults @ 0x8d97a4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults
 * Зовёт сам: bits__set32_s0_w4, edca__fill_default_ac_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__set_edca_defaults
l2mgr__set_edca_defaults:
	.global L_8d97a4
L_8d97a4:
	push_s blink
L_8d97a6:
	mov_s r2,r0
L_8d97a8:
	mov_s r0,0xc
L_8d97aa:
	stb_s r0,[r2,0x12]
L_8d97ac:
	mov_s r0,0x12
L_8d97ae:
	stb_s r0,[r2,0x13]
L_8d97b0:
	mov_s r1,0x0
L_8d97b2:
	add r0,r2,0x14
L_8d97b6:
	bl L_8ed370
L_8d97ba:
	ld_s r0,[r2,0x14]
L_8d97bc:
	bic r0,r0,0x30
L_8d97c0:
	bic r0,r0,0xc0
L_8d97c4:
	st_s r0,[r2,0x14]
L_8d97c6:
	stb_s r1,[r2,0x15]
L_8d97c8:
	bl.d L_8e63f4
L_8d97cc:
	mov_s r0,r2
L_8d97ce:
	pop_s blink
L_8d97d0:
	j_s [blink]
L_8d97d2:
	nop_s
