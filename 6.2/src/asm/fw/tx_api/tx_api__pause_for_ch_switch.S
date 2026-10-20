/* tx_api__pause_for_ch_switch @ 0x8e7f2c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__action_8c5be8
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, tx_api__check_state_2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__pause_for_ch_switch
tx_api__pause_for_ch_switch:
	.global L_8e7f2c
L_8e7f2c:
	push_s blink
L_8e7f2e:
	push_s r13
L_8e7f30:
	ld_s r0,[gp,-0x1c]
L_8e7f32:
	brne_s r0,0,L_8e7f5c
	.global L_8e7f34
L_8e7f34:
	mov_s r0,0x1
L_8e7f36:
	st.as r0,[gp,-0x7]
L_8e7f3a:
	mov_s r13,0x842154
L_8e7f40:
	bl.d L_8e7ec4
L_8e7f44:
	mov_s r0,r13
L_8e7f46:
	mov_s r0,0x842274
L_8e7f4c:
	bl L_8e7ec4
L_8e7f50:
	bl.d L_8e7ec4
L_8e7f54:
	add3 r0,r13,0x12
L_8e7f58:
	b L_8c025c
	.global L_8e7f5c
L_8e7f5c:
	mov_s r0,blink
L_8e7f5e:
	mov_s r1,0x1223
L_8e7f64:
	bl L_8c9b28
L_8e7f68:
	b_s L_8e7f34
L_8e7f6a:
	nop_s
