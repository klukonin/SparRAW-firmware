/* uc_send_evt__rs_done @ 0x925cb0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__rs_done,"ax",@progbits
	.global uc_send_evt__rs_done
uc_send_evt__rs_done:
	.global L_925cb0
L_925cb0:
	push_s blink
L_925cb2:
	bl L_920214
L_925cb6:
	mov_s r14,r0
L_925cb8:
	mov_s r0,0x801618
L_925cbe:
	bl L_921930
L_925cc2:
	mov_s r1,r14
L_925cc4:
	mov_s r13,r0
L_925cc6:
	bl.d L_920310
L_925cca:
	mov_s r2,0x10
L_925ccc:
	mov_s r0,r13
L_925cce:
	mov_s r1,0x14
L_925cd0:
	mov_s r2,0x10
L_925cd2:
	bl.d L_925dd8
L_925cd6:
	mov_s r3,0x0
L_925cd8:
	b L_920284
