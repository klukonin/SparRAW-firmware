/* rf_mgmt_sm__action_8c8fcc @ 0x8c8fcc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, low_sme__handle_rf_kill, rf_mgmt__set_state_flag
 * Глобалы (через gp): 0x800241
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mgmt_sm__action_8c8fcc
rf_mgmt_sm__action_8c8fcc:
	.global L_8c8fcc
L_8c8fcc:
	push_s blink
L_8c8fce:
	bl L_8c01e4
L_8c8fd2:
	mov_s r14,r1
L_8c8fd4:
	mov_s r13,0x1
L_8c8fd6:
	bl.d L_8eab30
L_8c8fda:
	mov_s r0,r13
L_8c8fdc:
	brne_s r14,0,L_8c8fe2
L_8c8fde:
	ldb_s r0,[gp,0xbd]
L_8c8fe0:
	breq_s r0,0,L_8c8fe6
	.global L_8c8fe2
L_8c8fe2:
	mov_s r0,r13
L_8c8fe4:
	b_s L_8c8fe8
	.global L_8c8fe6
L_8c8fe6:
	mov_s r0,0x0
	.global L_8c8fe8
L_8c8fe8:
	bl L_8cdb28
L_8c8fec:
	b L_8c0254
