/* discovery__inject_sm_event @ 0x8c3ecc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__handle_rx_frame
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event
 */
	.section .text.discovery__inject_sm_event,"ax",@progbits
	.global discovery__inject_sm_event
discovery__inject_sm_event:
	.global L_8c3ecc
L_8c3ecc:
	push_s blink
L_8c3ece:
	bl.d L_8c02c4
L_8c3ed2:
	mov_s r3,r1
L_8c3ed4:
	add2 r13,r0,0x3f
L_8c3ed8:
	mov_s r2,0x0
L_8c3eda:
	st_s r2,[r13,0x28]
L_8c3edc:
	mov_s r0,r13
L_8c3ede:
	mov_s r14,0x1
L_8c3ee0:
	mov_s r1,r14
L_8c3ee2:
	bl.d L_8d6a1c
L_8c3ee6:
	mov_s r4,r2
L_8c3ee8:
	b.d L_8c0334
