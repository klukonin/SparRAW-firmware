/* rf_mgmt__set_state_flag @ 0x8eab30, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_mgmt_sm__action_8c6010, rf_mgmt_sm__action_8c8fcc, rf_mgmt_sm__action_8e247c, rf_mgmt_sm__action_8e248c, rf_mgmt_sm__action_8eaaa8
 * Глобалы (через gp): 0x800190, 0x800194
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_mgmt__set_state_flag
rf_mgmt__set_state_flag:
	.global L_8eab30
L_8eab30:
	cmp_s r0,0x1
L_8eab32:
	mov_s r0,0x1
L_8eab34:
	sub_s.ne r0,r0,r0
L_8eab36:
	brne_s r1,0,L_8eab3e
L_8eab38:
	st.as r0,[gp,0x3]
L_8eab3c:
	b_s L_8eab42
	.global L_8eab3e
L_8eab3e:
	st.as r0,[gp,0x4]
	.global L_8eab42
L_8eab42:
	j_s [blink]
