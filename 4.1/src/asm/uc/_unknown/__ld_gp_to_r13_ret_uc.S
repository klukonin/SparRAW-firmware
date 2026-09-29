/* __ld_gp_to_r13_ret_uc @ 0x920224, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.__ld_gp_to_r13_ret_uc,"ax",@progbits
	.global __ld_gp_to_r13_ret_uc
__ld_gp_to_r13_ret_uc:
L_920224:
	mov_s r12,0x4
L_920226:
	mov_s r13,0x38
L_920228:
	/* b_s 0x00920298 */
	.byte 0x38,0xf0
L_92022a:
	nop_s
