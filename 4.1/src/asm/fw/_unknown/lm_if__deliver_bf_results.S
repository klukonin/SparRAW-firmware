/* lm_if__deliver_bf_results @ 0x8dbee8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8c22b0
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event
 */
	.section .text.lm_if__deliver_bf_results,"ax",@progbits
	.global lm_if__deliver_bf_results
lm_if__deliver_bf_results:
	.global L_8dbee8
L_8dbee8:
	push_s blink
L_8dbeea:
	bl.d L_8c02c4
L_8dbeee:
	mov_s r3,0x0
L_8dbef0:
	mov_s r14,r0
L_8dbef2:
	mov_s r13,r1
L_8dbef4:
	mov_s r1,0x4
L_8dbef6:
	mov_s r2,r13
L_8dbef8:
	bl.d L_8d6a1c
L_8dbefc:
	mov_s r4,r3
L_8dbefe:
	add r0,r14,0x34
L_8dbf02:
	mov_s r1,0x1
L_8dbf04:
	mov_s r2,r13
L_8dbf06:
	mov_s r3,0x0
L_8dbf08:
	bl.d L_8d6a1c
L_8dbf0c:
	mov_s r4,r3
L_8dbf0e:
	b L_8c0334
L_8dbf12:
	nop_s
