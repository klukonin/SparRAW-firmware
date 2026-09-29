/* lmac_if__bf_done_and_new_link @ 0x8db518, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2_mgr__lmac_new_link_evt_handler, lmac_if__bf_done_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__bf_done_and_new_link
lmac_if__bf_done_and_new_link:
	.global L_8db518
L_8db518:
	push_s blink
L_8db51a:
	bl L_8c01e4
L_8db51e:
	mov_s r13,r0
L_8db520:
	bl.d L_8db3c8
L_8db524:
	mov_s r14,r1
L_8db526:
	mov_s r0,r13
L_8db528:
	bl.d L_8f603c
L_8db52c:
	mov_s r1,r14
L_8db52e:
	b L_8c0254
L_8db532:
	nop_s
