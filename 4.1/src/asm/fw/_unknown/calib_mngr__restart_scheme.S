/* calib_mngr__restart_scheme @ 0x8dfdd8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, calib_cfg__get_scheme, calib_engine__start_step, calib_mngr__cancel_all_schemes
 * Глобалы (через gp): 0x80023b
 */
	.section .text.calib_mngr__restart_scheme,"ax",@progbits
	.global calib_mngr__restart_scheme
calib_mngr__restart_scheme:
	.global L_8dfdd8
L_8dfdd8:
	push_s blink
L_8dfdda:
	bl L_8c02c4
L_8dfdde:
	mov_s r13,r1
L_8dfde0:
	ldb r1,[gp, 0xc7]
L_8dfde4:
	mov_s r14,r2
L_8dfde6:
	breq_s r1,0,L_8dfdfc
L_8dfde8:
	cmp_s r0,0x0
L_8dfdea:
	bl.ne L_8dfd4c
L_8dfdee:
	breq_s r13,0,L_8dfdfc
L_8dfdf0:
	ldb_s r0,[gp,0xcb]
L_8dfdf2:
	bl.d L_8ca4a4
L_8dfdf6:
	mov_s r1,r14
L_8dfdf8:
	bl L_8dfd78
	.global L_8dfdfc
L_8dfdfc:
	b L_8c0334
