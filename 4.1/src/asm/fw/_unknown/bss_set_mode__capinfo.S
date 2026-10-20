/* bss_set_mode__capinfo @ 0x8c438c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    FINAL -> Result m_capinfo %x (BSS TYPE = 0x%x, privacy %x)
 * Зовут его: bss_set_mode
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_w_s0_w2, fw_log__emit3
 */
	.section .text.bss_set_mode__capinfo,"ax",@progbits
	.global bss_set_mode__capinfo
bss_set_mode__capinfo:
	.global L_8c438c
L_8c438c:
	push_s blink
L_8c438e:
	bl.d L_8c02c4
L_8c4392:
	bmsk_s r1,r1,0x1
L_8c4394:
	mov_s r13,r0
L_8c4396:
	add_s r0,r0,0x5c
L_8c4398:
	bl.d L_8e8330
L_8c439c:
	bmsk_s r2,r2,0x0
L_8c439e:
	ld_s r0,[r13,0x5c]
L_8c43a0:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8c43a2:
	bset_s r0,r0,0x2
L_8c43a4:
	bic r0,r0,0x18
L_8c43a8:
	or_s r0,r0,r2
L_8c43aa:
	bclr_s r0,r0,0x5
L_8c43ac:
	st_s r0,[r13,0x5c]
L_8c43ae:
	add3 r3,r13,0x8
L_8c43b2:
	ldb_s r0,[r3,0x1d]
L_8c43b4:
	mov_s r2,0x100aee4
L_8c43ba:
	bic r0,r0,0x11
L_8c43be:
	stb_s r0,[r3,0x1d]
L_8c43c0:
	ld_s r14,[r13,0x5c]
L_8c43c2:
	mov_s r0,0xb
L_8c43c4:
	lsr r13,r14,0x4
L_8c43c8:
	mov_s r1,0x2
L_8c43ca:
	ldw_s r3,[r3,0x1c]
L_8c43cc:
	bmsk r4,r14,0x1
L_8c43d0:
	bl.d L_8ee034
L_8c43d4:
	bmsk r5,r13,0x0
L_8c43d8:
	b L_8c0334
