/* calib_engine__abort_all @ 0x8e49fc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_mngr__restart_scheme
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event__r1_5_r2_0, calib_engine__cancel_timer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__abort_all
calib_engine__abort_all:
	.global L_8e49fc
L_8e49fc:
	push_s blink
L_8e49fe:
	bl L_8c01e4
L_8e4a02:
	mov_s r14,0x0
L_8e4a04:
	mov_s r13,0x6
	.global L_8e4a06
L_8e4a06:
	mul64 r14,0x44
L_8e4a0a:
	add r0,mlo,0x804944
L_8e4a12:
	/* bl.d 0x008c1d98 */
	.byte 0x8a,0x0b,0xaf,0xee
L_8e4a16:
	/* _sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e4a18:
	bl.d L_8c68ec
L_8e4a1c:
	mov_s r0,r14
L_8e4a1e:
	/* brhs.d r13,0x1,0x008e4a06 */
	.byte 0xeb,0x0d,0x75,0x90
L_8e4a22:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e4a24:
	b L_8c0254
