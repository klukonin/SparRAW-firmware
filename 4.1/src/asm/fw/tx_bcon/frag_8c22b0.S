/* frag_8c22b0 @ 0x8c22b0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__on_bf_results, lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_read_timer, get_reg_880a3c_8d7210, lm_if__deliver_bf_results, memcpy_fw
 */
	.section .text.frag_8c22b0,"ax",@progbits
	.global frag_8c22b0
frag_8c22b0:
	.global L_8c22b0
L_8c22b0:
	push_s blink
L_8c22b2:
	bl L_8c02c4
L_8c22b6:
	mov_s r13,r0
L_8c22b8:
	bl.d L_8d7210
L_8c22bc:
	mov_s r14,r1
L_8c22be:
	brne_s r0,0,L_8c22de
L_8c22c0:
	add r0,r13,0xc
L_8c22c4:
	mov_s r1,r14
L_8c22c6:
	bl.d L_8c0460
L_8c22ca:
	mov_s r2,0x20
L_8c22cc:
	bl L_8e4694
L_8c22d0:
	st_s r0,[r13,0x8]
L_8c22d2:
	ld_s r0,[r13]
L_8c22d4:
	cmp_s r0,0x0
L_8c22d6:
	bl.ne.d L_8dbee8
L_8c22da:
	mov.ne r1,r14
	.global L_8c22de
L_8c22de:
	b L_8c0334
L_8c22e2:
	nop_s
