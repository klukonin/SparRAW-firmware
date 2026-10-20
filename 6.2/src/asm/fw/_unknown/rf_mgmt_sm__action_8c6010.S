/* rf_mgmt_sm__action_8c6010 @ 0x8c6010, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, low_sme__send_rf_mgmt_status, rf_mgmt__set_state_flag
 * Глобалы (через gp): 0x800190, 0x800194
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mgmt_sm__action_8c6010
rf_mgmt_sm__action_8c6010:
	.global L_8c6010
L_8c6010:
	push_s blink
L_8c6012:
	push_s r13
L_8c6014:
	mov_s r13,r0
L_8c6016:
	bl.d L_8eab30
L_8c601a:
	mov_s r0,0x0
L_8c601c:
	ld_s r0,[gp,0xc]
L_8c601e:
	brne_s r0,0,L_8c6036
L_8c6020:
	ld_s r0,[gp,0x10]
L_8c6022:
	brne_s r0,0,L_8c6036
L_8c6024:
	mov_s r0,r13
L_8c6026:
	mov_s r1,0x3
L_8c6028:
	mov_s r2,0x0
L_8c602a:
	mov_s r3,0x0
L_8c602c:
	bl.d L_8d9b6c
L_8c6030:
	mov r4,0x0
L_8c6034:
	b_s L_8c603a
	.global L_8c6036
L_8c6036:
	bl L_8e5ce0
	.global L_8c603a
L_8c603a:
	b L_8c025c
L_8c603e:
	nop_s
