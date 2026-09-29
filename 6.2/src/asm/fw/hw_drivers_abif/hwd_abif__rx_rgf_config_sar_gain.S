/* hwd_abif__rx_rgf_config_sar_gain @ 0x8cef50, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_rgf_config_sar_gain
hwd_abif__rx_rgf_config_sar_gain:
	.global L_8cef50
L_8cef50:
	push_s blink
L_8cef52:
	bl L_8c01e0
L_8cef56:
	mov_s r14,r1
L_8cef58:
	mov_s r13,r2
L_8cef5a:
	brge.d r1,0x8,L_8cef88
L_8cef5e:
	mov_s r15,r3
	.global L_8cef60
L_8cef60:
	brge r13,0x2,L_8cef94
	.global L_8cef64
L_8cef64:
	rsub r0,r14,0x7
L_8cef68:
	extb_s r0,r0
L_8cef6a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8cef6c:
	extb_s r0,r0
L_8cef6e:
	mov_s r1,0x88af30
L_8cef74:
	add2_s r1,r1,r13
L_8cef76:
	ld_s r3,[r1]
L_8cef78:
	mov_s r2,0xf
L_8cef7a:
	asl_s r2,r2,r0
L_8cef7c:
	bic_s r3,r3,r2
L_8cef7e:
	asl_s r15,r15,r0
L_8cef80:
	or_s r15,r15,r3
L_8cef82:
	st_s r15,[r1]
L_8cef84:
	b L_8c024c
	.global L_8cef88
L_8cef88:
	mov_s r0,blink
L_8cef8a:
	mov_s r1,0xb3
L_8cef8c:
	bl.d L_8c9b28
L_8cef90:
	bset_s r1,r1,0xc
L_8cef92:
	b_s L_8cef60
	.global L_8cef94
L_8cef94:
	mov_s r0,blink
L_8cef96:
	mov_s r1,0xb4
L_8cef98:
	bl.d L_8c9b28
L_8cef9c:
	bset_s r1,r1,0xc
L_8cef9e:
	b_s L_8cef64
