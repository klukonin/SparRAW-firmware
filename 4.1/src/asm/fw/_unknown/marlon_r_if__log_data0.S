/* marlon_r_if__log_data0 @ 0x8d12c0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   data0 is 0x%x
 * Зовут его: marlon_r_if__otp_write
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, hwd_rfc_write_core
 */
	.section .text.marlon_r_if__log_data0,"ax",@progbits
	.global marlon_r_if__log_data0
marlon_r_if__log_data0:
	.global L_8d12c0
L_8d12c0:
	push_s blink
L_8d12c2:
	bl.d L_8c02c0
L_8d12c6:
	bmsk_s r2,r2,0x0
L_8d12c8:
	mov_s r15,r0
L_8d12ca:
	stw.a r1,[sp,-0x4]
L_8d12ce:
	ld_s r13,[sp,0x0]
L_8d12d0:
	asl r14,r2,0x11
L_8d12d4:
	bclr_s r13,r13,0x10
L_8d12d6:
	bclr_s r13,r13,0x11
L_8d12d8:
	bset_s r13,r13,0x10
L_8d12da:
	mov_s r2,0x10191d0
L_8d12e0:
	mov_s r0,0x0
L_8d12e2:
	mov_s r1,0x2
L_8d12e4:
	bl.d L_8edfcc
L_8d12e8:
	or r3,r13,r14
L_8d12ec:
	extb_s r0,r15
L_8d12ee:
	mov_s r1,0xc
L_8d12f0:
	mov_s r2,0x0
L_8d12f2:
	bl.d L_8d0f80
L_8d12f6:
	or r3,r13,r14
L_8d12fa:
	b.d L_8c032c
L_8d12fe:
	add_s sp,sp,0x4
