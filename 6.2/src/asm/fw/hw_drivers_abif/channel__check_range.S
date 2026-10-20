/* channel__check_range @ 0x8cfadc, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channel num  %d is out of range, should be <=%d
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_sysapi__set_freq_ratio, hwm_analog_channel_switch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channel__check_range
channel__check_range:
	.global L_8cfadc
L_8cfadc:
	push_s blink
L_8cfade:
	bl L_8c01dc
L_8cfae2:
	cmp_s r0,0x3
L_8cfae4:
	mov_s r15,r1
L_8cfae6:
	bhi.d L_8cfbe4
L_8cfaea:
	mov_s r13,r2
L_8cfaec:
	add r2,pcl,0x18
L_8cfaf0:
	ldb.x r0,[0x803954,r0]
L_8cfaf8:
	mov r16,-0x400
L_8cfafc:
	add1_s r2,r2,r0
L_8cfafe:
	j_s.d [r2]
L_8cfb00:
	and r1,r15,r16
L_8cfb04:
	brne_s r1,0,L_8cfb28
	.global L_8cfb06
L_8cfb06:
	mov_s r14,0x889400
L_8cfb0c:
	ld_s r1,[r14,0x20]
L_8cfb0e:
	and r0,r1,r16
L_8cfb12:
	or_s r15,r15,r0
L_8cfb14:
	st_s r15,[r14,0x20]
L_8cfb16:
	mov_s r15,0xff
L_8cfb18:
	asl_s r15,r15,0x18
L_8cfb1a:
	tst_s r13,r15
L_8cfb1c:
	bne_s L_8cfb32
	.global L_8cfb1e
L_8cfb1e:
	ld_s r0,[r14,0x24]
L_8cfb20:
	and_s r15,r15,r0
L_8cfb22:
	or_s r13,r13,r15
L_8cfb24:
	st_s r13,[r14,0x24]
L_8cfb26:
	b_s L_8cfbe8
	.global L_8cfb28
L_8cfb28:
	mov_s r0,blink
L_8cfb2a:
	bl.d L_8c9b28
L_8cfb2e:
	mov_s r1,0xac
L_8cfb30:
	b_s L_8cfb06
	.global L_8cfb32
L_8cfb32:
	mov_s r0,blink
L_8cfb34:
	bl.d L_8c9b28
L_8cfb38:
	mov_s r1,0xac
L_8cfb3a:
	b_s L_8cfb1e
L_8cfb3c:
	brne_s r1,0,L_8cfb60
	.global L_8cfb3e
L_8cfb3e:
	mov_s r14,0x889400
L_8cfb44:
	ld_s r1,[r14,0x28]
L_8cfb46:
	and r0,r1,r16
L_8cfb4a:
	or_s r15,r15,r0
L_8cfb4c:
	st_s r15,[r14,0x28]
L_8cfb4e:
	mov_s r15,0xff
L_8cfb50:
	asl_s r15,r15,0x18
L_8cfb52:
	tst_s r13,r15
L_8cfb54:
	bne_s L_8cfb6a
	.global L_8cfb56
L_8cfb56:
	ld_s r0,[r14,0x2c]
L_8cfb58:
	and_s r0,r0,r15
L_8cfb5a:
	or_s r0,r0,r13
L_8cfb5c:
	st_s r0,[r14,0x2c]
L_8cfb5e:
	b_s L_8cfbe8
	.global L_8cfb60
L_8cfb60:
	mov_s r0,blink
L_8cfb62:
	bl.d L_8c9b28
L_8cfb66:
	mov_s r1,0xac
L_8cfb68:
	b_s L_8cfb3e
	.global L_8cfb6a
L_8cfb6a:
	mov_s r0,blink
L_8cfb6c:
	bl.d L_8c9b28
L_8cfb70:
	mov_s r1,0xac
L_8cfb72:
	b_s L_8cfb56
L_8cfb74:
	brne_s r1,0,L_8cfb98
	.global L_8cfb76
L_8cfb76:
	mov_s r14,0x889400
L_8cfb7c:
	ld_s r1,[r14,0x30]
L_8cfb7e:
	and r0,r1,r16
L_8cfb82:
	or_s r15,r15,r0
L_8cfb84:
	st_s r15,[r14,0x30]
L_8cfb86:
	mov_s r15,0xff
L_8cfb88:
	asl_s r15,r15,0x18
L_8cfb8a:
	tst_s r13,r15
L_8cfb8c:
	bne_s L_8cfba2
	.global L_8cfb8e
L_8cfb8e:
	ld_s r0,[r14,0x34]
L_8cfb90:
	and_s r0,r0,r15
L_8cfb92:
	or_s r0,r0,r13
L_8cfb94:
	st_s r0,[r14,0x34]
L_8cfb96:
	b_s L_8cfbe8
	.global L_8cfb98
L_8cfb98:
	mov_s r0,blink
L_8cfb9a:
	bl.d L_8c9b28
L_8cfb9e:
	mov_s r1,0xac
L_8cfba0:
	b_s L_8cfb76
	.global L_8cfba2
L_8cfba2:
	mov_s r0,blink
L_8cfba4:
	bl.d L_8c9b28
L_8cfba8:
	mov_s r1,0xac
L_8cfbaa:
	b_s L_8cfb8e
L_8cfbac:
	brne_s r1,0,L_8cfbd0
	.global L_8cfbae
L_8cfbae:
	mov_s r14,0x889400
L_8cfbb4:
	ld_s r0,[r14,0x38]
L_8cfbb6:
	and r0,r0,r16
L_8cfbba:
	or_s r15,r15,r0
L_8cfbbc:
	st_s r15,[r14,0x38]
L_8cfbbe:
	mov_s r15,0xff
L_8cfbc0:
	asl_s r15,r15,0x18
L_8cfbc2:
	tst_s r13,r15
L_8cfbc4:
	bne_s L_8cfbda
	.global L_8cfbc6
L_8cfbc6:
	ld_s r0,[r14,0x3c]
L_8cfbc8:
	and_s r0,r0,r15
L_8cfbca:
	or_s r0,r0,r13
L_8cfbcc:
	st_s r0,[r14,0x3c]
L_8cfbce:
	b_s L_8cfbe8
	.global L_8cfbd0
L_8cfbd0:
	mov_s r0,blink
L_8cfbd2:
	bl.d L_8c9b28
L_8cfbd6:
	mov_s r1,0xac
L_8cfbd8:
	b_s L_8cfbae
	.global L_8cfbda
L_8cfbda:
	mov_s r0,blink
L_8cfbdc:
	bl.d L_8c9b28
L_8cfbe0:
	mov_s r1,0xac
L_8cfbe2:
	b_s L_8cfbc6
	.global L_8cfbe4
L_8cfbe4:
	brhs r0,0x4,L_8cfbec
	.global L_8cfbe8
L_8cfbe8:
	b L_8c0244
	.global L_8cfbec
L_8cfbec:
	mov_s r1,0x101f0d4
L_8cfbf2:
	add_s r2,r0,0x1
L_8cfbf4:
	mov_s r0,0x0
L_8cfbf6:
	mov_s r3,0x4
L_8cfbf8:
	bl.d L_8dcd00
L_8cfbfc:
	mov_s r4,r0
L_8cfbfe:
	mov_s r0,blink
L_8cfc00:
	mov_s r1,0x1457
L_8cfc06:
	bl L_8c9b28
L_8cfc0a:
	b_s L_8cfbe8
