/* bss_set_mode__capinfo @ 0x8c4cd8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    FINAL -> Result m_capinfo %x (BSS TYPE = 0x%x, privacy %x)
 * Зовут его: bss_set_mode
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s0_w2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bss_set_mode__capinfo
bss_set_mode__capinfo:
	.global L_8c4cd8
L_8c4cd8:
	push_s blink
L_8c4cda:
	mov_s r3,r0
L_8c4cdc:
	bmsk_s r1,r1,0x1
L_8c4cde:
	add_s r0,r0,0x5c
L_8c4ce0:
	bl.d L_8ed358
L_8c4ce4:
	push_s r13
L_8c4ce6:
	ld_s r0,[r3,0x5c]
L_8c4ce8:
	bmsk_s r2,r2,0x0
L_8c4cea:
	bset_s r0,r0,0x2
L_8c4cec:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8c4cee:
	bic r0,r0,0x18
L_8c4cf2:
	or_s r0,r0,r2
L_8c4cf4:
	bclr_s r0,r0,0x5
L_8c4cf6:
	st_s r0,[r3,0x5c]
L_8c4cf8:
	add3 r2,r3,0x8
L_8c4cfc:
	ldb_s r0,[r2,0x1d]
L_8c4cfe:
	mov_s r1,0x100c368
L_8c4d04:
	bic r0,r0,0x11
L_8c4d08:
	stb_s r0,[r2,0x1d]
L_8c4d0a:
	ld_s r3,[r3,0x5c]
L_8c4d0c:
	mov_s r0,0x2b
L_8c4d0e:
	lsr r13,r3,0x4
L_8c4d12:
	ldw_s r2,[r2,0x1c]
L_8c4d14:
	bmsk_s r3,r3,0x1
L_8c4d16:
	bl.d L_8dcd00
L_8c4d1a:
	bmsk r4,r13,0x0
L_8c4d1e:
	b L_8c025c
L_8c4d22:
	nop_s
