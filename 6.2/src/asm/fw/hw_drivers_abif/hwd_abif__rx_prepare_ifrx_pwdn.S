/* hwd_abif__rx_prepare_ifrx_pwdn @ 0x8cee2c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_hw_b, calib__setup_loopback_rx_path, hwf_calib__release_hw
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_prepare_ifrx_pwdn
hwd_abif__rx_prepare_ifrx_pwdn:
	.global L_8cee2c
L_8cee2c:
	push_s blink
L_8cee2e:
	bl L_8c01e0
L_8cee32:
	bmsk r14,r0,0x0
L_8cee36:
	and r13,r0,0x2
L_8cee3a:
	asr_s r13,r13
L_8cee3c:
	bclr.f 0x0,r14,0x0
L_8cee40:
	bic r0,r0,-0x5
L_8cee44:
	asr_s r15,r0,0x2
L_8cee46:
	bne_s L_8cee76
	.global L_8cee48
L_8cee48:
	bclr.f 0x0,r13,0x0
L_8cee4c:
	bne_s L_8cee80
	.global L_8cee4e
L_8cee4e:
	bclr.f 0x0,r15,0x0
L_8cee52:
	bne_s L_8cee8a
	.global L_8cee54
L_8cee54:
	mov_s r0,0x88ae00
L_8cee5a:
	ld_s r1,[r0,0x60]
L_8cee5c:
	asl_s r14,r14,0xb
L_8cee5e:
	bclr_s r1,r1,0xb
L_8cee60:
	bclr_s r1,r1,0xc
L_8cee62:
	bclr_s r14,r14,0xc
L_8cee64:
	or_s r1,r1,r14
L_8cee66:
	asl_s r13,r13,0xc
L_8cee68:
	or_s r1,r1,r13
L_8cee6a:
	bclr_s r1,r1,0xd
L_8cee6c:
	asl_s r15,r15,0xd
L_8cee6e:
	or_s r15,r15,r1
L_8cee70:
	st_s r15,[r0,0x60]
L_8cee72:
	b L_8c024c
	.global L_8cee76
L_8cee76:
	mov_s r0,blink
L_8cee78:
	bl.d L_8c9b28
L_8cee7c:
	mov_s r1,0xaf
L_8cee7e:
	b_s L_8cee48
	.global L_8cee80
L_8cee80:
	mov_s r0,blink
L_8cee82:
	bl.d L_8c9b28
L_8cee86:
	mov_s r1,0xb0
L_8cee88:
	b_s L_8cee4e
	.global L_8cee8a
L_8cee8a:
	mov_s r0,blink
L_8cee8c:
	bl.d L_8c9b28
L_8cee90:
	mov_s r1,0xb1
L_8cee92:
	b_s L_8cee54
