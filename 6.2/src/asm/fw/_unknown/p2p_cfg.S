/* p2p_cfg @ 0x8f6d20, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   p2p_cfg()
 * Зовут его: l2_mgr__wmi_cmd_handler_p2p_cfg
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, find_mngr__cfg_offload, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global p2p_cfg
p2p_cfg:
	.global L_8f6d20
L_8f6d20:
	push_s blink
L_8f6d22:
	bl L_8c01d8
L_8f6d26:
	mov_s r14,r0
L_8f6d28:
	mov_s r17,r1
L_8f6d2a:
	mov_s r13,r2
L_8f6d2c:
	mov_s r16,r3
L_8f6d2e:
	mov_s r15,r4
L_8f6d30:
	mov_s r1,0x1016fc8
L_8f6d36:
	bl.d L_8dcba8
L_8f6d3a:
	mov_s r0,0x2c
L_8f6d3c:
	add r0,r14,0xc
L_8f6d40:
	extb_s r3,r13
L_8f6d42:
	ld_s r1,[r14,0x4]
L_8f6d44:
	mov_s r2,r17
L_8f6d46:
	mov r4,r16
L_8f6d4a:
	bl.d L_8c6b88
L_8f6d4e:
	mov_s r5,r15
L_8f6d50:
	b L_8c023c
