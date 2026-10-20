/* hwd_phy__tx_play_buffer_start @ 0x8d2d40, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_play_buffer_start
hwd_phy__tx_play_buffer_start:
	.global L_8d2d40
L_8d2d40:
	push_s blink
L_8d2d42:
	bl L_8c01d8
L_8d2d46:
	mov_s r15,r0
L_8d2d48:
	mov_s r13,r1
L_8d2d4a:
	cmp_s r1,0x17ff
L_8d2d50:
	bhi.d L_8d2de4
L_8d2d54:
	mov_s r17,r2
	.global L_8d2d56
L_8d2d56:
	bclr.f 0x0,r15,0x0
L_8d2d5a:
	bne_s L_8d2df0
	.global L_8d2d5c
L_8d2d5c:
	mov_s r14,0x884100
L_8d2d62:
	ld_s r0,[r14,0x4c]
L_8d2d64:
	mov_s r1,0x884000
L_8d2d6a:
	bclr_s r0,r0,0x0
L_8d2d6c:
	or_s r0,r0,r15
L_8d2d6e:
	st_s r0,[r14,0x4c]
L_8d2d70:
	ld_s r0,[r1,0x8]
L_8d2d72:
	cmp r13,0x7ff
L_8d2d76:
	bset_s r0,r0,0x0
L_8d2d78:
	st_s r0,[r1,0x8]
L_8d2d7a:
	mov_s r15,0x1
L_8d2d7c:
	sub.ls r15,r15,r15
L_8d2d80:
	cmp_s r13,0xfff
L_8d2d86:
	mov r16,0x1
L_8d2d8a:
	sub.ls r16,r16,r16
L_8d2d8e:
	bclr.f 0x0,r15,0x0
L_8d2d92:
	bne_s L_8d2dfa
	.global L_8d2d94
L_8d2d94:
	bclr.f 0x0,r16,0x0
L_8d2d98:
	bne_s L_8d2e04
	.global L_8d2d9a
L_8d2d9a:
	mov_s r0,0x880180
L_8d2da0:
	ld_s r1,[r0,0x60]
L_8d2da2:
	/* asl_s r15,r15,0x7 */
	.byte 0x07,0xbf
L_8d2da4:
	bic r1,r1,0xc0
L_8d2da8:
	bset_s r1,r1,0x6
L_8d2daa:
	or_s r15,r15,r1
L_8d2dac:
	bclr_s r15,r15,0x8
L_8d2dae:
	asl r1,r16,0x8
L_8d2db2:
	or_s r1,r1,r15
L_8d2db4:
	st_s r1,[r0,0x60]
L_8d2db6:
	ld_s r0,[r14,0x50]
L_8d2db8:
	mov_s r15,0xffffe000
L_8d2dbe:
	and_s r0,r0,r15
L_8d2dc0:
	st_s r0,[r14,0x50]
L_8d2dc2:
	tst_s r13,r15
L_8d2dc4:
	bne_s L_8d2e0e
	.global L_8d2dc6
L_8d2dc6:
	ld_s r0,[r14,0x54]
L_8d2dc8:
	and_s r0,r0,r15
L_8d2dca:
	or_s r13,r13,r0
L_8d2dcc:
	st_s r13,[r14,0x54]
L_8d2dce:
	ld_s r0,[r14,0x40]
L_8d2dd0:
	bset_s r0,r0,0x0
L_8d2dd2:
	st_s r0,[r14,0x40]
L_8d2dd4:
	ld_s r0,[r14,0x58]
L_8d2dd6:
	st r17,[r14, 0x58]
L_8d2dda:
	ld_s r0,[r14,0x44]
L_8d2ddc:
	bset_s r0,r0,0x0
L_8d2dde:
	st_s r0,[r14,0x44]
L_8d2de0:
	b L_8c023c
	.global L_8d2de4
L_8d2de4:
	mov_s r0,blink
L_8d2de6:
	mov_s r1,0xdd
L_8d2de8:
	bl.d L_8c9b28
L_8d2dec:
	bset_s r1,r1,0xc
L_8d2dee:
	b_s L_8d2d56
	.global L_8d2df0
L_8d2df0:
	mov_s r0,blink
L_8d2df2:
	bl.d L_8c9b28
L_8d2df6:
	mov_s r1,0xac
L_8d2df8:
	b_s L_8d2d5c
	.global L_8d2dfa
L_8d2dfa:
	mov_s r0,blink
L_8d2dfc:
	bl.d L_8c9b28
L_8d2e00:
	mov_s r1,0xb0
L_8d2e02:
	b_s L_8d2d94
	.global L_8d2e04
L_8d2e04:
	mov_s r0,blink
L_8d2e06:
	bl.d L_8c9b28
L_8d2e0a:
	mov_s r1,0xb1
L_8d2e0c:
	b_s L_8d2d9a
	.global L_8d2e0e
L_8d2e0e:
	mov_s r0,blink
L_8d2e10:
	bl.d L_8c9b28
L_8d2e14:
	mov_s r1,0xac
L_8d2e16:
	b_s L_8d2dc6
