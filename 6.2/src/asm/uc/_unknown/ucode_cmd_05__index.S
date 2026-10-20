/* ucode_cmd_05__index @ 0x920cdc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x05_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_05__index
ucode_cmd_05__index:
	.global L_920cdc
L_920cdc:
	push_s blink
L_920cde:
	bl L_920234
L_920ce2:
	mov_s r14,r0
L_920ce4:
	mov_s r13,r1
L_920ce6:
	add2 r0,r1,r1
L_920cea:
	add_s r0,r0,r14
L_920cec:
	bl.d L_920a84
L_920cf0:
	mov_s r1,0x5
L_920cf2:
	ldb r0,[r14, 0x29]
L_920cf6:
	bset r0,r0,r13
L_920cfa:
	b.d L_9202a4
L_920cfe:
	stb r0,[r14, 0x29]
L_920d02:
	nop_s
