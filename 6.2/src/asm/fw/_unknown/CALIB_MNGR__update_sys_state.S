/* CALIB_MNGR__update_sys_state @ 0x8ead00, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_ASSOCIATED
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_UNASSOC
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_UNASSOC_WITH_PERIODIC_CALIB
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global CALIB_MNGR__update_sys_state
CALIB_MNGR__update_sys_state:
	.global L_8ead00
L_8ead00:
	brhs.d r0,0x11,L_8ead44
L_8ead04:
	push_s blink
L_8ead06:
	ldw.x.as r0,[0x8021e8,r0]
L_8ead0e:
	add r1,pcl,0xa
L_8ead12:
	add1_s r1,r1,r0
L_8ead14:
	j_s [r1]
L_8ead16:
	mov_s r0,0x2
L_8ead18:
	mov_s r1,0x1009154
L_8ead1e:
	st.as r0,[gp,-0x5]
L_8ead22:
	b_s L_8ead3e
L_8ead24:
	mov_s r0,0x3
L_8ead26:
	mov_s r1,0x10091a0
L_8ead2c:
	st.as r0,[gp,-0x5]
L_8ead30:
	b_s L_8ead3e
L_8ead32:
	mov_s r0,0x4
L_8ead34:
	st.as r0,[gp,-0x5]
L_8ead38:
	mov_s r1,0x10091e8
	.global L_8ead3e
L_8ead3e:
	bl.d L_8dcba8
L_8ead42:
	mov_s r0,0x26
	.global L_8ead44
L_8ead44:
	pop_s blink
L_8ead46:
	j_s [blink]
