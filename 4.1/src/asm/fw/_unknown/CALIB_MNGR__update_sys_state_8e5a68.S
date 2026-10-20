/* CALIB_MNGR__update_sys_state_8e5a68 @ 0x8e5a68, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CALIB_MNGR::update_sys_state m_system_state=CALIB_SYSTEM_STATE_UNASSOC_WITH_PERIODIC_CALIB
 */
	.section .text.CALIB_MNGR__update_sys_state_8e5a68,"ax",@progbits
	.global CALIB_MNGR__update_sys_state_8e5a68
CALIB_MNGR__update_sys_state_8e5a68:
L_8e5a68:
	mov_s r0,0x3
L_8e5a6a:
	mov_s r2,0x1008520
L_8e5a70:
	st.as r0,[gp,-0x2]
L_8e5a74:
	/* b_s 0x008e5a5c */
	.byte 0xf4,0xf1
L_8e5a76:
	nop_s
