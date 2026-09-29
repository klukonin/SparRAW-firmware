/* hwd_abif__rx_rgf_config_sar_dc @ 0x8ceee0, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_rgf_config_sar_dc
hwd_abif__rx_rgf_config_sar_dc:
	.global L_8ceee0
L_8ceee0:
	push_s blink
L_8ceee2:
	bl L_8c01dc
L_8ceee6:
	mov_s r14,r0
L_8ceee8:
	mov_s r15,r1
L_8ceeea:
	mov_s r13,r2
L_8ceeec:
	brge.d r0,0x8,L_8cef2a
L_8ceef0:
	mov_s r16,r3
	.global L_8ceef2
L_8ceef2:
	brge r15,0x2,L_8cef36
	.global L_8ceef6
L_8ceef6:
	brge r13,0x2,L_8cef42
	.global L_8ceefa
L_8ceefa:
	rsub r0,r14,0x7
L_8ceefe:
	extb_s r0,r0
L_8cef00:
	/* asl_s r15,r15,0x2 */
	.byte 0x02,0xbf
L_8cef02:
	add1_s r15,r15,r13
L_8cef04:
	asr_s r2,r0,0x2
L_8cef06:
	add_s r2,r2,r15
L_8cef08:
	extb_s r2,r2
L_8cef0a:
	bmsk_s r0,r0,0x1
L_8cef0c:
	asl_s r1,r0,0x3
L_8cef0e:
	mov_s r0,0x88af10
L_8cef14:
	add2_s r0,r0,r2
L_8cef16:
	ld_s r3,[r0]
L_8cef18:
	mov_s r2,0x1f
L_8cef1a:
	asl_s r2,r2,r1
L_8cef1c:
	bic_s r3,r3,r2
L_8cef1e:
	asl r2,r16,r1
L_8cef22:
	or_s r3,r3,r2
L_8cef24:
	st_s r3,[r0]
L_8cef26:
	b L_8c0244
	.global L_8cef2a
L_8cef2a:
	mov_s r0,blink
L_8cef2c:
	mov_s r1,0xae
L_8cef2e:
	bl.d L_8c9b28
L_8cef32:
	bset_s r1,r1,0xc
L_8cef34:
	b_s L_8ceef2
	.global L_8cef36
L_8cef36:
	mov_s r0,blink
L_8cef38:
	mov_s r1,0xaf
L_8cef3a:
	bl.d L_8c9b28
L_8cef3e:
	bset_s r1,r1,0xc
L_8cef40:
	b_s L_8ceef6
	.global L_8cef42
L_8cef42:
	mov_s r0,blink
L_8cef44:
	mov_s r1,0xb0
L_8cef46:
	bl.d L_8c9b28
L_8cef4a:
	bset_s r1,r1,0xc
L_8cef4c:
	b_s L_8ceefa
L_8cef4e:
	nop_s
