/* hwd_phy__tx_predist_dc_config @ 0x8d2eb8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_predist_dc_config
hwd_phy__tx_predist_dc_config:
	.global L_8d2eb8
L_8d2eb8:
	push_s blink
L_8d2eba:
	bl L_8c01dc
L_8d2ebe:
	mov_s r15,r1
L_8d2ec0:
	mov_s r16,r2
L_8d2ec2:
	mov_s r14,0x884100
L_8d2ec8:
	mov r13,-0x400
L_8d2ecc:
	breq_s r0,0,L_8d2f08
L_8d2ece:
	mov_s r0,0x0
L_8d2ed0:
	st_s r0,[r14,0x3c]
L_8d2ed2:
	tst_s r15,r13
L_8d2ed4:
	bne_s L_8d2ef4
	.global L_8d2ed6
L_8d2ed6:
	tst r16,r13
L_8d2eda:
	bne_s L_8d2efe
	.global L_8d2edc
L_8d2edc:
	ld_s r1,[r14,0x38]
L_8d2ede:
	mov_s r0,0xfc00ffff
L_8d2ee4:
	and_s r13,r13,r1
L_8d2ee6:
	and_s r13,r13,r0
L_8d2ee8:
	and_s r15,r15,r0
L_8d2eea:
	or_s r15,r15,r13
L_8d2eec:
	asl r0,r16,0x10
L_8d2ef0:
	or_s r0,r0,r15
L_8d2ef2:
	b_s L_8d2f16
	.global L_8d2ef4
L_8d2ef4:
	mov_s r0,blink
L_8d2ef6:
	bl.d L_8c9b28
L_8d2efa:
	mov_s r1,0xad
L_8d2efc:
	b_s L_8d2ed6
	.global L_8d2efe
L_8d2efe:
	mov_s r0,blink
L_8d2f00:
	bl.d L_8c9b28
L_8d2f04:
	mov_s r1,0xae
L_8d2f06:
	b_s L_8d2edc
	.global L_8d2f08
L_8d2f08:
	mov_s r0,0x1
L_8d2f0a:
	st_s r0,[r14,0x3c]
L_8d2f0c:
	ld_s r0,[r14,0x38]
L_8d2f0e:
	and r0,r0,0xfc00fc00
	.global L_8d2f16
L_8d2f16:
	st_s r0,[r14,0x38]
L_8d2f18:
	b L_8c0244
