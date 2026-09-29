/* state_sm_8030f4__action_8f96a8 @ 0x8f96a8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: Start listen
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__listen_end, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f96a8
state_sm_8030f4__action_8f96a8:
	.global L_8f96a8
L_8f96a8:
	push_s blink
L_8f96aa:
	push_s r13
L_8f96ac:
	mov_s r13,r0
L_8f96ae:
	mov_s r1,0x1017bb4
L_8f96b4:
	bl.d L_8dcba8
L_8f96b8:
	mov_s r0,0x2c
L_8f96ba:
	bl.d L_8daff0
L_8f96be:
	ld_s r0,[r13,0x10]
L_8f96c0:
	b L_8c025c
