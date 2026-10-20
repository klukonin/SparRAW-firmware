/* uc_send_evt__new_link @ 0x925c6c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker, bf_sm_step, mac_mode_program_c
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__new_link,"ax",@progbits
	.global uc_send_evt__new_link
uc_send_evt__new_link:
	.global L_925c6c
L_925c6c:
	sub_s sp,sp,0x20
L_925c6e:
	push_s blink
L_925c70:
	push_s r13
L_925c72:
	st_s r0,[sp,0x8]
L_925c74:
	st_s r1,[sp,0xc]
L_925c76:
	st_s r2,[sp,0x10]
L_925c78:
	st_s r3,[sp,0x14]
L_925c7a:
	st r4,[sp, 0x18]
L_925c7e:
	st r5,[sp, 0x1c]
L_925c82:
	st r6,[sp, 0x20]
L_925c86:
	mov_s r0,0x801618
L_925c8c:
	bl.d L_921930
L_925c90:
	st r7,[sp, 0x24]
L_925c94:
	mov_s r13,r0
L_925c96:
	add_s r1,sp,0x8
L_925c98:
	bl.d L_920310
L_925c9c:
	mov_s r2,0x20
L_925c9e:
	mov_s r0,r13
L_925ca0:
	mov_s r1,0x5
L_925ca2:
	mov_s r2,0x20
L_925ca4:
	bl.d L_925dd8
L_925ca8:
	mov_s r3,0x0
L_925caa:
	mov_s r12,0x24
L_925cac:
	b L_92028e
