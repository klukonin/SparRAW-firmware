/* lm_sm__action_8dab0c @ 0x8dab0c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LINK LOST NTF -> DISCONNECT
 * Зовёт сам: __ld_r13_to_r13_ret, conn__disconnect, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8dab0c
lm_sm__action_8dab0c:
	.global L_8dab0c
L_8dab0c:
	b.d L_8dab14
L_8dab10:
	ld_s r0,[r0,0x8]
L_8dab12:
	nop_s
	.global L_8dab14
L_8dab14:
	push_s blink
L_8dab16:
	push_s r13
L_8dab18:
	mov_s r13,r0
L_8dab1a:
	mov_s r1,0x1014270
L_8dab20:
	bl.d L_8dcba8
L_8dab24:
	mov_s r0,0x2b
L_8dab26:
	ld_s r0,[r13,0x4]
L_8dab28:
	mov_s r1,0x1
L_8dab2a:
	bl.d L_8f2540
L_8dab2e:
	mov_s r2,r1
L_8dab30:
	b L_8c025c
