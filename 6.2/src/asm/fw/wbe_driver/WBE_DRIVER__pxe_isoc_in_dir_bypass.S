/* WBE_DRIVER__pxe_isoc_in_dir_bypass @ 0x8f7eb0, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::pxe_isoc_in_dir_bypass: %d
 * Зовут его: mgmt_tx__copy_ie_max96, pxe__isoc_in_dir_bypass_off, pxe__isoc_in_dir_bypass_on
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global WBE_DRIVER__pxe_isoc_in_dir_bypass
WBE_DRIVER__pxe_isoc_in_dir_bypass:
	.global L_8f7eb0
L_8f7eb0:
	push_s blink
L_8f7eb2:
	bl L_8c01d8
L_8f7eb6:
	mov_s r15,r0
L_8f7eb8:
	mov_s r1,0x1003648
L_8f7ebe:
	mov_s r0,0x2f
L_8f7ec0:
	bl.d L_8dcc10
L_8f7ec4:
	mov_s r2,r15
L_8f7ec6:
	mov_s r13,0x882d80
L_8f7ecc:
	ld r17,[r13, 0x54]
L_8f7ed0:
	bclr.f r16,r15,0x0
L_8f7ed4:
	mov_s r0,r17
L_8f7ed6:
	bic r0,r0,0x46
L_8f7eda:
	st_s r0,[r13,0x54]
L_8f7edc:
	ld_s r0,[r13,0x54]
L_8f7ede:
	bset_s r0,r0,0x1f
L_8f7ee0:
	st_s r0,[r13,0x54]
L_8f7ee2:
	bne_s L_8f7f1a
	.global L_8f7ee4
L_8f7ee4:
	mov_s r14,0x882e00
L_8f7eea:
	ld_s r0,[r14,0x8]
L_8f7eec:
	asl_s r15,r15,0xe
L_8f7eee:
	bclr_s r0,r0,0xe
L_8f7ef0:
	or_s r0,r0,r15
L_8f7ef2:
	st_s r0,[r14,0x8]
L_8f7ef4:
	brne r16,0x0,L_8f7f24
	.global L_8f7ef8
L_8f7ef8:
	ld_s r0,[r14,0x1c]
L_8f7efa:
	bclr_s r0,r0,0xe
L_8f7efc:
	or_s r0,r0,r15
L_8f7efe:
	st_s r0,[r14,0x1c]
L_8f7f00:
	brne r16,0x0,L_8f7f2e
	.global L_8f7f04
L_8f7f04:
	ld_s r0,[r14,0x6c]
L_8f7f06:
	bclr_s r0,r0,0xe
L_8f7f08:
	or_s r0,r0,r15
L_8f7f0a:
	st_s r0,[r14,0x6c]
L_8f7f0c:
	st r17,[r13, 0x54]
L_8f7f10:
	ld_s r0,[r13,0x54]
L_8f7f12:
	bset_s r0,r0,0x1f
L_8f7f14:
	st_s r0,[r13,0x54]
L_8f7f16:
	b L_8c023c
	.global L_8f7f1a
L_8f7f1a:
	mov_s r0,blink
L_8f7f1c:
	bl.d L_8c9b28
L_8f7f20:
	mov_s r1,0xac
L_8f7f22:
	b_s L_8f7ee4
	.global L_8f7f24
L_8f7f24:
	mov_s r0,blink
L_8f7f26:
	bl.d L_8c9b28
L_8f7f2a:
	mov_s r1,0xac
L_8f7f2c:
	b_s L_8f7ef8
	.global L_8f7f2e
L_8f7f2e:
	mov_s r0,blink
L_8f7f30:
	bl.d L_8c9b28
L_8f7f34:
	mov_s r1,0xac
L_8f7f36:
	b_s L_8f7f04
