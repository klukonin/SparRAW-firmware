/* tx_api__pause_for_ch_switch @ 0x8e2e30, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_api.cpp
 * Зовут его: rm_chan_sw_sm__on_ch_switch_kick
 * Зовёт сам: __ld_r13_ret, frag_8e2dbc, fw_sysassert_fatal
 */
	.section .text.tx_api__pause_for_ch_switch,"ax",@progbits
	.global tx_api__pause_for_ch_switch
tx_api__pause_for_ch_switch:
	.global L_8e2e30
L_8e2e30:
	push_s blink
L_8e2e32:
	push_s r13
L_8e2e34:
	ld_s r0,[gp,-0x10]
L_8e2e36:
	brne_s r0,0,L_8e2e60
	.global L_8e2e38
L_8e2e38:
	mov_s r0,0x1
L_8e2e3a:
	st.as r0,[gp,-0x4]
L_8e2e3e:
	mov_s r13,0x842410
L_8e2e44:
	bl.d L_8e2dbc
L_8e2e48:
	mov_s r0,r13
L_8e2e4a:
	mov_s r0,0x842530
L_8e2e50:
	bl L_8e2dbc
L_8e2e54:
	bl.d L_8e2dbc
L_8e2e58:
	add3 r0,r13,0x12
L_8e2e5c:
	b L_8c033c
	.global L_8e2e60
L_8e2e60:
	mov_s r0,blink
L_8e2e62:
	mov_s r2,0x1014cd4
L_8e2e68:
	mov_s r1,0x1223
L_8e2e6e:
	bl.d L_8c82c0
L_8e2e72:
	mov r3,0x335
L_8e2e76:
	b_s L_8e2e38
