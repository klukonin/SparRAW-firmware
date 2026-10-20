/* ucode_pm__stamp_tsf_slots @ 0x93c7a8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_pm__set_busy_flag
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_pm__stamp_tsf_slots
ucode_pm__stamp_tsf_slots:
	.global L_93c7a8
L_93c7a8:
	push_s blink
L_93c7aa:
	bl L_920230
L_93c7ae:
	mov_s r13,0x0
L_93c7b0:
	mov_s r14,0x8
	.global L_93c7b2
L_93c7b2:
	mov_s r0,0x0
L_93c7b4:
	asl_s r15,r13,0x2
L_93c7b6:
	add2_s r15,r15,r15
L_93c7b8:
	add_s r15,r15,0x857e38
L_93c7be:
	bl.d L_9364c8
L_93c7c2:
	stw_s r0,[r15,0x2]
L_93c7c4:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_93c7c6:
	st_s r0,[r15,0xc]
L_93c7c8:
	/* brhs.d r14,0x1,0x0093c7b2 */
	.byte 0xeb,0x0e,0x75,0x90
L_93c7cc:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_93c7ce:
	b L_92029c
L_93c7d2:
	nop_s
