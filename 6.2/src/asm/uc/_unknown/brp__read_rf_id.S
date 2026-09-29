/* brp__read_rf_id @ 0x92ed5c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_initiator_brp_transaction_flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brp__iterate_rf_mask, rf_utils__auto_fill_with_byte, rfca__get_rf_mask_uc, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__read_rf_id
brp__read_rf_id:
	.global L_92ed5c
L_92ed5c:
	push_s blink
L_92ed5e:
	bl L_920234
L_92ed62:
	bl.d L_928c68
L_92ed66:
	mov_s r13,r0
L_92ed68:
	mov_s r14,r0
L_92ed6a:
	mov_s r0,r13
L_92ed6c:
	bl.d L_92f160
L_92ed70:
	mov_s r1,0x1
L_92ed72:
	bl.d L_92efc8
L_92ed76:
	mov_s r0,r13
L_92ed78:
	mov_s r0,r14
L_92ed7a:
	bl.d L_928b8c
L_92ed7e:
	mov_s r1,0x0
L_92ed80:
	b L_9202a4
