/* ucode_cmd_0x12_handler_uc @ 0x9301e4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, rs_abort, rs_start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x12_handler_uc
ucode_cmd_0x12_handler_uc:
	.global L_9301e4
L_9301e4:
	push_s blink
L_9301e6:
	push_s r13
L_9301e8:
	mov_s r13,r0
L_9301ea:
	bl.d L_92fb80
L_9301ee:
	ldb_s r0,[r0]
L_9301f0:
	ldb_s r0,[r13]
L_9301f2:
	bl.d L_9300ec
L_9301f6:
	mov_s r1,0x0
L_9301f8:
	b L_9202ac
