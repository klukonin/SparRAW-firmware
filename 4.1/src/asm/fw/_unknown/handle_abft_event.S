/* handle_abft_event @ 0x8ebe88, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_abft_event() Discovery A-BFT link up status %d (BF Status %d) for CID %d.
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_mngr__link_up, fw_log__emit3
 */
	.section .text.handle_abft_event,"ax",@progbits
	.global handle_abft_event
handle_abft_event:
	.global L_8ebe88
L_8ebe88:
	push_s blink
L_8ebe8a:
	bl.d L_8c02c0
L_8ebe8e:
	mov_s r4,r2
L_8ebe90:
	mov_s r15,r0
L_8ebe92:
	mov_s r13,r1
L_8ebe94:
	cmp_s r2,0x1
L_8ebe96:
	mov_s r14,0x1
L_8ebe98:
	sub.eq r14,r14,r14
L_8ebe9c:
	ldb r5,[r1, 0x8]
L_8ebea0:
	mov_s r2,0x1012660
L_8ebea6:
	mov_s r0,0xc
L_8ebea8:
	mov_s r1,0x2
L_8ebeaa:
	bl.d L_8ee034
L_8ebeae:
	mov_s r3,r14
L_8ebeb0:
	add r0,r15,0xc
L_8ebeb4:
	mov_s r1,r13
L_8ebeb6:
	bl.d L_8c3f4c
L_8ebeba:
	mov_s r2,r14
L_8ebebc:
	b L_8c032c
