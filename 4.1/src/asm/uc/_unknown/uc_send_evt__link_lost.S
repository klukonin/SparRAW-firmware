/* uc_send_evt__link_lost @ 0x925c40, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_bi_trigger_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__link_lost,"ax",@progbits
	.global uc_send_evt__link_lost
uc_send_evt__link_lost:
	.global L_925c40
L_925c40:
	push_s blink
L_925c42:
	bl L_920214
L_925c46:
	mov_s r14,r0
L_925c48:
	mov_s r0,0x801618
L_925c4e:
	bl L_921930
L_925c52:
	mov_s r1,r14
L_925c54:
	mov_s r13,r0
L_925c56:
	bl.d L_920310
L_925c5a:
	mov_s r2,0xc
L_925c5c:
	mov_s r0,r13
L_925c5e:
	mov_s r1,0x9
L_925c60:
	mov_s r2,0xc
L_925c62:
	bl.d L_925dd8
L_925c66:
	mov_s r3,0x0
L_925c68:
	b L_920284
