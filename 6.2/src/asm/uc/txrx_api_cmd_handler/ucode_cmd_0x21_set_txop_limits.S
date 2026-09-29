/* ucode_cmd_0x21_set_txop_limits @ 0x93a9b0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: txop__apply_limits_regs
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x21_set_txop_limits
ucode_cmd_0x21_set_txop_limits:
	.global L_93a9b0
L_93a9b0:
	mov lp_count,0x4
L_93a9b4:
	mov_s r2,0x0
L_93a9b6:
	lp L_93a9ca
L_93a9ba:
	ldw.as r3,[r0,r2]
L_93a9be:
	mov_s r1,0x802940
L_93a9c4:
	add2_s r1,r1,r2
L_93a9c6:
	st_s r3,[r1,0xc]
L_93a9c8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_93a9ca
L_93a9ca:
	b.d L_936ba8
L_93a9ce:
	mov_s r0,0x0
