/* hwd_phy__tx_self_transmit @ 0x8d2f88, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_self_transmit
hwd_phy__tx_self_transmit:
	.global L_8d2f88
L_8d2f88:
	push_s blink
L_8d2f8a:
	bl L_8c01d8
L_8d2f8e:
	mov_s r15,r0
L_8d2f90:
	mov_s r17,r1
L_8d2f92:
	mov_s r16,r2
L_8d2f94:
	brlt.d r15,0x1,L_8d2fee
L_8d2f98:
	mov_s r13,r3
	.global L_8d2f9a
L_8d2f9a:
	breq_s r13,0,L_8d2ffa
	.global L_8d2f9c
L_8d2f9c:
	mov_s r14,0x884000
L_8d2fa2:
	ld_s r0,[r14,0xc]
L_8d2fa4:
	st r17,[r14, 0xc]
L_8d2fa8:
	bic.f 0x0,r16,0x1f
L_8d2fac:
	bne_s L_8d3006
	.global L_8d2fae
L_8d2fae:
	ld_s r0,[r14,0x74]
L_8d2fb0:
	and.f 0x0,r13,0xfffc0000
L_8d2fb8:
	bic r1,r0,0x1f
L_8d2fbc:
	or r0,r16,r1
L_8d2fc0:
	st_s r0,[r14,0x74]
L_8d2fc2:
	bne_s L_8d3010
	.global L_8d2fc4
L_8d2fc4:
	ld_s r0,[r14,0x74]
L_8d2fc6:
	/* asl_s r13,r13,0x5 */
	.byte 0x05,0xbd
L_8d2fc8:
	and r0,r0,0xff80001f
L_8d2fd0:
	or_s r0,r0,r13
L_8d2fd2:
	st_s r0,[r14,0x74]
L_8d2fd4:
	mov_s r13,0xffff0000
L_8d2fda:
	tst_s r15,r13
L_8d2fdc:
	bne_s L_8d301a
	.global L_8d2fde
L_8d2fde:
	ld_s r0,[r14,0x54]
L_8d2fe0:
	and_s r0,r0,r13
L_8d2fe2:
	or_s r15,r15,r0
L_8d2fe4:
	st_s r15,[r14,0x54]
L_8d2fe6:
	mov_s r0,0x1
L_8d2fe8:
	st_s r0,[r14,0x58]
L_8d2fea:
	b L_8c023c
	.global L_8d2fee
L_8d2fee:
	mov_s r0,blink
L_8d2ff0:
	mov_s r1,0xda
L_8d2ff2:
	bl.d L_8c9b28
L_8d2ff6:
	bset_s r1,r1,0xc
L_8d2ff8:
	b_s L_8d2f9a
	.global L_8d2ffa
L_8d2ffa:
	mov_s r0,blink
L_8d2ffc:
	mov_s r1,0xdb
L_8d2ffe:
	bl.d L_8c9b28
L_8d3002:
	bset_s r1,r1,0xc
L_8d3004:
	b_s L_8d2f9c
	.global L_8d3006
L_8d3006:
	mov_s r0,blink
L_8d3008:
	bl.d L_8c9b28
L_8d300c:
	mov_s r1,0xac
L_8d300e:
	b_s L_8d2fae
	.global L_8d3010
L_8d3010:
	mov_s r0,blink
L_8d3012:
	bl.d L_8c9b28
L_8d3016:
	mov_s r1,0xac
L_8d3018:
	b_s L_8d2fc4
	.global L_8d301a
L_8d301a:
	mov_s r0,blink
L_8d301c:
	bl.d L_8c9b28
L_8d3020:
	mov_s r1,0xac
L_8d3022:
	b_s L_8d2fde
