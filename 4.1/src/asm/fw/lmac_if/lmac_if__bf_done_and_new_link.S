/* lmac_if__bf_done_and_new_link @ 0x8d8374, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, l2_mgr__lmac_new_link_evt_handler, lmac_if__bf_done_evt
 */
	.section .text.lmac_if__bf_done_and_new_link,"ax",@progbits
	.global lmac_if__bf_done_and_new_link
lmac_if__bf_done_and_new_link:
	.global L_8d8374
L_8d8374:
	push_s blink
L_8d8376:
	bl L_8c02c4
L_8d837a:
	mov_s r13,r0
L_8d837c:
	bl.d L_8d8218
L_8d8380:
	mov_s r14,r1
L_8d8382:
	mov_s r0,r13
L_8d8384:
	bl.d L_8edd08
L_8d8388:
	mov_s r1,r14
L_8d838a:
	b L_8c0334
L_8d838e:
	nop_s
