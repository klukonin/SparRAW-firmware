/* hwd_mac__uses_rgf_886200 @ 0x8d0fb4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_corr__estimate_and_apply_rx_gain, hwf_calib__restore_path
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__uses_rgf_886200
hwd_mac__uses_rgf_886200:
	.global L_8d0fb4
L_8d0fb4:
	push_s blink
L_8d0fb6:
	push_s r13
L_8d0fb8:
	mov_s r13,r0
L_8d0fba:
	bclr.f r0,r0,0x0
L_8d0fbe:
	bne_s L_8d0fd4
	.global L_8d0fc0
L_8d0fc0:
	mov_s r1,0x886200
L_8d0fc6:
	ld_s r0,[r1]
L_8d0fc8:
	asl_s r13,r13,0xb
L_8d0fca:
	bclr_s r0,r0,0xb
L_8d0fcc:
	or_s r13,r13,r0
L_8d0fce:
	st_s r13,[r1]
L_8d0fd0:
	b L_8c025c
	.global L_8d0fd4
L_8d0fd4:
	mov_s r0,blink
L_8d0fd6:
	bl.d L_8c9b28
L_8d0fda:
	mov_s r1,0xac
L_8d0fdc:
	b_s L_8d0fc0
L_8d0fde:
	nop_s
