/* calib_mngr__cancel_all_schemes @ 0x8dfd4c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_mngr__restart_scheme
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, calib_mngr__cancel_scheme_step, tail_basic_sm__inject_event
 */
	.section .text.calib_mngr__cancel_all_schemes,"ax",@progbits
	.global calib_mngr__cancel_all_schemes
calib_mngr__cancel_all_schemes:
	.global L_8dfd4c
L_8dfd4c:
	push_s blink
L_8dfd4e:
	bl L_8c02c4
L_8dfd52:
	mov_s r13,0x0
L_8dfd54:
	mov_s r14,0x6
	.global L_8dfd56
L_8dfd56:
	asl_s r1,r13,0x5
L_8dfd58:
	add1_s r1,r1,r1
L_8dfd5a:
	add r0,r1,0x842860
L_8dfd62:
	/* bl.d 0x008c1b38 */
	.byte 0xda,0x0d,0xef,0xf0
L_8dfd66:
	/* _sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8dfd68:
	bl.d L_8c5b48
L_8dfd6c:
	mov_s r0,r13
L_8dfd6e:
	/* brhs.d r14,0x1,0x008dfd56 */
	.byte 0xeb,0x0e,0x75,0x90
L_8dfd72:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8dfd74:
	b L_8c0334
