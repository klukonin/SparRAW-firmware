/* hwd_phy__tx_predist_iq_config @ 0x8d2f1c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_predist_iq_config
hwd_phy__tx_predist_iq_config:
	.global L_8d2f1c
L_8d2f1c:
	push_s blink
L_8d2f1e:
	bl L_8c01dc
L_8d2f22:
	mov_s r14,r1
L_8d2f24:
	mov_s r13,r2
L_8d2f26:
	mov r16,-0x400
L_8d2f2a:
	breq_s r0,0,L_8d2f6e
L_8d2f2c:
	tst r14,r16
L_8d2f30:
	bne_s L_8d2f5a
	.global L_8d2f32
L_8d2f32:
	tst r13,r16
L_8d2f36:
	bne_s L_8d2f64
	.global L_8d2f38
L_8d2f38:
	mov_s r0,0x884000
L_8d2f3e:
	ld_s r3,[r0,0x24]
L_8d2f40:
	mov_s r1,0xfc00ffff
L_8d2f46:
	mov_s r2,0xec00fc00
L_8d2f4c:
	and_s r2,r2,r3
L_8d2f4e:
	and_s r1,r1,r14
L_8d2f50:
	or_s r1,r1,r2
L_8d2f52:
	asl_s r13,r13,0x10
L_8d2f54:
	or_s r13,r13,r1
L_8d2f56:
	st_s r13,[r0,0x24]
L_8d2f58:
	b_s L_8d2f82
	.global L_8d2f5a
L_8d2f5a:
	mov_s r0,blink
L_8d2f5c:
	bl.d L_8c9b28
L_8d2f60:
	mov_s r1,0xb0
L_8d2f62:
	b_s L_8d2f32
	.global L_8d2f64
L_8d2f64:
	mov_s r0,blink
L_8d2f66:
	bl.d L_8c9b28
L_8d2f6a:
	mov_s r1,0xb1
L_8d2f6c:
	b_s L_8d2f38
	.global L_8d2f6e
L_8d2f6e:
	mov_s r1,0x884000
L_8d2f74:
	ld_s r0,[r1,0x24]
L_8d2f76:
	and r0,r0,0xec00fc00
L_8d2f7e:
	bset_s r0,r0,0x1c
L_8d2f80:
	st_s r0,[r1,0x24]
	.global L_8d2f82
L_8d2f82:
	b L_8c0244
L_8d2f86:
	nop_s
