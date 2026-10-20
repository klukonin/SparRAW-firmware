/* hwd_phy__tx_predist_atten_man_config @ 0x8d2e48, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_calib__release_hw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_predist_atten_man_config
hwd_phy__tx_predist_atten_man_config:
	.global L_8d2e48
L_8d2e48:
	push_s blink
L_8d2e4a:
	bl L_8c01d8
L_8d2e4e:
	mov_s r14,0x884100
L_8d2e54:
	st_s r0,[r14,0x30]
L_8d2e56:
	mov r17,-0x100
L_8d2e5a:
	tst r1,r17
L_8d2e5e:
	mov_s r13,r1
L_8d2e60:
	mov_s r16,r2
L_8d2e62:
	bne_s L_8d2e8a
	.global L_8d2e64
L_8d2e64:
	tst r16,r17
L_8d2e68:
	bne_s L_8d2e94
	.global L_8d2e6a
L_8d2e6a:
	ld_s r2,[r14,0x34]
L_8d2e6c:
	mov_s r0,0xffff00ff
L_8d2e72:
	mov_s r1,0xffff0000
L_8d2e78:
	and_s r1,r1,r2
L_8d2e7a:
	and_s r13,r13,r0
L_8d2e7c:
	or_s r13,r13,r1
L_8d2e7e:
	asl r0,r16,0x8
L_8d2e82:
	or_s r0,r0,r13
L_8d2e84:
	st_s r0,[r14,0x34]
L_8d2e86:
	b L_8c023c
	.global L_8d2e8a
L_8d2e8a:
	mov_s r0,blink
L_8d2e8c:
	bl.d L_8c9b28
L_8d2e90:
	mov_s r1,0xad
L_8d2e92:
	b_s L_8d2e64
	.global L_8d2e94
L_8d2e94:
	mov_s r0,blink
L_8d2e96:
	bl.d L_8c9b28
L_8d2e9a:
	mov_s r1,0xae
L_8d2e9c:
	b_s L_8d2e6a
L_8d2e9e:
	nop_s
