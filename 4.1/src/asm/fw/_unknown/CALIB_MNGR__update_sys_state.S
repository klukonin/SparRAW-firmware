/* CALIB_MNGR__update_sys_state @ 0x8e5a2c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_ASSOCIATED
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_UNASSOC
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: fw_log__emit0
 */
	.section .text.CALIB_MNGR__update_sys_state,"ax",@progbits
	.global CALIB_MNGR__update_sys_state
CALIB_MNGR__update_sys_state:
	.global L_8e5a2c
L_8e5a2c:
	brhs.d r0,0x11,L_8e5a64
L_8e5a30:
	push_s blink
L_8e5a32:
	ldw.x.as r0,[0x801ce4,r0]
L_8e5a3a:
	add r1,pcl,0xa
L_8e5a3e:
	add1_s r1,r1,r0
L_8e5a40:
	j_s [r1]
L_8e5a42:
	mov_s r0,0x1
L_8e5a44:
	mov_s r2,0x100848c
L_8e5a4a:
	st.as r0,[gp,-0x2]
L_8e5a4e:
	b_s L_8e5a5c
L_8e5a50:
	mov_s r0,0x2
L_8e5a52:
	st.as r0,[gp,-0x2]
L_8e5a56:
	mov_s r2,0x10084d8
	.global L_8e5a5c
L_8e5a5c:
	mov_s r0,0x6
L_8e5a5e:
	bl.d L_8edfb0
L_8e5a62:
	mov_s r1,0x2
	.global L_8e5a64
L_8e5a64:
	pop_s blink
L_8e5a66:
	j_s [blink]
