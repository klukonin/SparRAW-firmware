/* mac__set_880afc_bits26_31_fw @ 0x8d04b8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880afc_bits26_31_fw
mac__set_880afc_bits26_31_fw:
	.global L_8d04b8
L_8d04b8:
	mov_s r3,0xbc
L_8d04ba:
	asl_s r3,r3,0x18
L_8d04bc:
	mov_s r1,0x880a80
L_8d04c2:
	cmp_s r0,0x0
L_8d04c4:
	ld_s r0,[r1,0x7c]
L_8d04c6:
	mov_s r2,0x43ffffff
L_8d04cc:
	and_s r0,r0,r2
L_8d04ce:
	or.ne r0,r0,r3
L_8d04d2:
	st_s r0,[r1,0x7c]
L_8d04d4:
	j_s [blink]
L_8d04d6:
	nop_s
