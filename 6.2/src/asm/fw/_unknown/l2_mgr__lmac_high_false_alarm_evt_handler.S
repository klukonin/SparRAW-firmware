/* l2_mgr__lmac_high_false_alarm_evt_handler @ 0x8f5f90, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::lmac_high_false_alarm_evt_handler locking secondary
 *   l2_mgr::lmac_high_false_alarm_evt_handler already locked m_radio_handle=0x%06x
 * Зовут его: lmac_if_link_lost_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, radio_mgr__request, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__lmac_high_false_alarm_evt_handler
l2_mgr__lmac_high_false_alarm_evt_handler:
	.global L_8f5f90
L_8f5f90:
	push_s blink
L_8f5f92:
	push_s r13
L_8f5f94:
	ld.as r2,[gp,-0x12]
L_8f5f98:
	brne_s r2,0,L_8f5fc8
L_8f5f9a:
	bl L_8e9524
L_8f5f9e:
	mov_s r1,0x100f370
L_8f5fa4:
	mov_s r13,r0
L_8f5fa6:
	bl.d L_8dcba8
L_8f5faa:
	mov_s r0,0x2b
L_8f5fac:
	mov_s r0,0x33ce8
L_8f5fb2:
	mov_s r1,r13
L_8f5fb4:
	mov_s r2,0x0
L_8f5fb6:
	mov_s r3,0xffff
L_8f5fbc:
	bl.d L_8dcaf4
L_8f5fc0:
	mov_s r4,r2
L_8f5fc2:
	st.as r0,[gp,-0x12]
L_8f5fc6:
	b_s L_8f5fd4
	.global L_8f5fc8
L_8f5fc8:
	mov_s r1,0x100f3ac
L_8f5fce:
	bl.d L_8dcc10
L_8f5fd2:
	mov_s r0,0x2b
	.global L_8f5fd4
L_8f5fd4:
	b L_8c025c
