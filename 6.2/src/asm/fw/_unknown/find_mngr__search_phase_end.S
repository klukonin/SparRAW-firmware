/* find_mngr__search_phase_end @ 0x8e4ca0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: End of SEARCH phase.
 * Зовёт сам: __ld_r13_to_r13_ret, find_mng__listen, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__search_phase_end
find_mngr__search_phase_end:
	.global L_8e4ca0
L_8e4ca0:
	push_s blink
L_8e4ca2:
	push_s r13
L_8e4ca4:
	mov_s r13,r0
L_8e4ca6:
	mov_s r1,0x1017a94
L_8e4cac:
	bl.d L_8dcba8
L_8e4cb0:
	mov_s r0,0x2c
L_8e4cb2:
	mov_s r0,0x0
L_8e4cb4:
	st_s r0,[r13,0x18]
L_8e4cb6:
	ld_s r0,[r13,0xc]
L_8e4cb8:
	breq_s r0,0,L_8e4cc4
	.global L_8e4cba
L_8e4cba:
	bl.d L_8dafa8
L_8e4cbe:
	mov_s r0,r13
L_8e4cc0:
	b L_8c025c
	.global L_8e4cc4
L_8e4cc4:
	mov_s r0,blink
L_8e4cc6:
	mov_s r1,0x1245
L_8e4ccc:
	bl L_8c9b28
L_8e4cd0:
	b_s L_8e4cba
L_8e4cd2:
	nop_s
