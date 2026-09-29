/* lm_sm__action_8dabdc @ 0x8dabdc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8dabdc
lm_sm__action_8dabdc:
	.global L_8dabdc
L_8dabdc:
	ld r2,[r0, 0x98]
L_8dabe0:
	breq r1,r2,L_8dabf8
L_8dabe4:
	mov_s r2,0x803c00
L_8dabea:
	ld_s r2,[r2,0x20]
L_8dabec:
	btst_s r2,0x2
L_8dabee:
	btst.eq r2,0x1
L_8dabf2:
	bne_s L_8dabf8
L_8dabf4:
	st r1,[r0, 0x98]
	.global L_8dabf8
L_8dabf8:
	j_s [blink]
L_8dabfa:
	nop_s
