/* hwd_abif__tx_table_index_force_mode @ 0x8cfef8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_index_force_mode
hwd_abif__tx_table_index_force_mode:
	.global L_8cfef8
L_8cfef8:
	push_s blink
L_8cfefa:
	bl L_8c01e4
L_8cfefe:
	mov_s r14,r0
L_8cff00:
	bclr.f r0,r0,0x0
L_8cff04:
	mov_s r13,r1
L_8cff06:
	bne_s L_8cff28
	.global L_8cff08
L_8cff08:
	bic.f 0x0,r13,0x1f
L_8cff0c:
	bne_s L_8cff32
	.global L_8cff0e
L_8cff0e:
	mov_s r1,0x88a000
L_8cff14:
	ld_s r0,[r1]
L_8cff16:
	asl_s r13,r13
L_8cff18:
	bclr_s r0,r0,0x0
L_8cff1a:
	or_s r0,r0,r14
L_8cff1c:
	bic r0,r0,0x3e
L_8cff20:
	or_s r13,r13,r0
L_8cff22:
	st_s r13,[r1]
L_8cff24:
	b L_8c0254
	.global L_8cff28
L_8cff28:
	mov_s r0,blink
L_8cff2a:
	bl.d L_8c9b28
L_8cff2e:
	mov_s r1,0xad
L_8cff30:
	b_s L_8cff08
	.global L_8cff32
L_8cff32:
	mov_s r0,blink
L_8cff34:
	bl.d L_8c9b28
L_8cff38:
	mov_s r1,0xae
L_8cff3a:
	b_s L_8cff0e
