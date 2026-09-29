/* state_sm_8030f4__action_8f9ce0 @ 0x8f9ce0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, find_mngr__del_discovery_bcon, find_mngr__listen_end
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f9ce0
state_sm_8030f4__action_8f9ce0:
	.global L_8f9ce0
L_8f9ce0:
	push_s blink
L_8f9ce2:
	push_s r13
L_8f9ce4:
	mov_s r13,r0
L_8f9ce6:
	bl.d L_8c8d6c
L_8f9cea:
	ld_s r0,[r0,0x10]
L_8f9cec:
	bl.d L_8daff0
L_8f9cf0:
	ld_s r0,[r13,0x10]
L_8f9cf2:
	b L_8c025c
L_8f9cf6:
	nop_s
L_8f9cf8:
	j_s [blink]
L_8f9cfa:
	nop_s
