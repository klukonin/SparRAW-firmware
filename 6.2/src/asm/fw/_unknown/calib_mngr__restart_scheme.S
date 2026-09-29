/* calib_mngr__restart_scheme @ 0x8e4a94, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: CALIB_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, calib_cfg__get_scheme, calib_engine__abort_all, calib_engine__run_requested
 * Глобалы (через gp): 0x800252
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_mngr__restart_scheme
calib_mngr__restart_scheme:
	.global L_8e4a94
L_8e4a94:
	push_s blink
L_8e4a96:
	bl L_8c01e4
L_8e4a9a:
	mov_s r13,r1
L_8e4a9c:
	ldb r1,[gp, 0xca]
L_8e4aa0:
	mov_s r14,r2
L_8e4aa2:
	breq_s r1,0,L_8e4ab8
L_8e4aa4:
	cmp_s r0,0x0
L_8e4aa6:
	bl.ne L_8e49fc
L_8e4aaa:
	breq_s r13,0,L_8e4ab8
L_8e4aac:
	ldb_s r0,[gp,0xce]
L_8e4aae:
	bl.d L_8cc6bc
L_8e4ab2:
	mov_s r1,r14
L_8e4ab4:
	bl L_8e4a28
	.global L_8e4ab8
L_8e4ab8:
	b L_8c0254
