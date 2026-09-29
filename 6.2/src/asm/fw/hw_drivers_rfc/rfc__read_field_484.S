/* rfc__read_field_484 @ 0x8d32b0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_obj__reset_results, hwf_calib_lo_power_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_field_484
rfc__read_field_484:
	.global L_8d32b0
L_8d32b0:
	push_s blink
L_8d32b2:
	bl L_8c01e4
L_8d32b6:
	mov_s r14,r1
L_8d32b8:
	extb_s r13,r0
L_8d32ba:
	mov_s r0,r13
L_8d32bc:
	bl.d L_8d3588
L_8d32c0:
	mov r1,0x1e4
L_8d32c4:
	st_s r0,[r14]
L_8d32c6:
	mov_s r0,r13
L_8d32c8:
	bl.d L_8d3588
L_8d32cc:
	mov r1,0x1e8
L_8d32d0:
	st_s r0,[r14,0x4]
L_8d32d2:
	mov_s r0,r13
L_8d32d4:
	bl.d L_8d3588
L_8d32d8:
	mov r1,0x1ec
L_8d32dc:
	b.d L_8c0254
L_8d32e0:
	st_s r0,[r14,0x8]
L_8d32e2:
	nop_s
