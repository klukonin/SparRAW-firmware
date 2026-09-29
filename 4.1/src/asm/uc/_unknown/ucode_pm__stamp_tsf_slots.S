/* ucode_pm__stamp_tsf_slots @ 0x936c7c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_pm__set_busy_flag
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, uc_read_tsf_lo
 */
	.section .text.ucode_pm__stamp_tsf_slots,"ax",@progbits
	.global ucode_pm__stamp_tsf_slots
ucode_pm__stamp_tsf_slots:
	.global L_936c7c
L_936c7c:
	push_s blink
L_936c7e:
	bl L_920210
L_936c82:
	mov_s r13,0x0
L_936c84:
	mov_s r14,0x8
	.global L_936c86
L_936c86:
	mov_s r0,0x0
L_936c88:
	asl_s r15,r13,0x2
L_936c8a:
	add2_s r15,r15,r15
L_936c8c:
	add_s r15,r15,0x857838
L_936c92:
	bl.d L_9315e8
L_936c96:
	stw_s r0,[r15,0x2]
L_936c98:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_936c9a:
	st_s r0,[r15,0xc]
L_936c9c:
	/* brhs.d r14,0x1,0x00936c86 */
	.byte 0xeb,0x0e,0x75,0x90
L_936ca0:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_936ca2:
	b L_92027c
L_936ca6:
	nop_s
