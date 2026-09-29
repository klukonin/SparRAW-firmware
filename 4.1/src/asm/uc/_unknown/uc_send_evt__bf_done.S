/* uc_send_evt__bf_done @ 0x925bd0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker, bf_sm_step, mac_mode_program_c
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__bf_done,"ax",@progbits
	.global uc_send_evt__bf_done
uc_send_evt__bf_done:
	.global L_925bd0
L_925bd0:
	sub_s sp,sp,0x20
L_925bd2:
	push_s blink
L_925bd4:
	push_s r13
L_925bd6:
	st_s r0,[sp,0x8]
L_925bd8:
	st_s r1,[sp,0xc]
L_925bda:
	st_s r2,[sp,0x10]
L_925bdc:
	st_s r3,[sp,0x14]
L_925bde:
	st r4,[sp, 0x18]
L_925be2:
	st r5,[sp, 0x1c]
L_925be6:
	st r6,[sp, 0x20]
L_925bea:
	mov_s r0,0x801618
L_925bf0:
	bl.d L_921930
L_925bf4:
	st r7,[sp, 0x24]
L_925bf8:
	mov_s r13,r0
L_925bfa:
	add_s r1,sp,0x8
L_925bfc:
	bl.d L_920310
L_925c00:
	mov_s r2,0x20
L_925c02:
	mov_s r0,r13
L_925c04:
	mov_s r1,0x6
L_925c06:
	mov_s r2,0x20
L_925c08:
	bl.d L_925dd8
L_925c0c:
	mov_s r3,0x0
L_925c0e:
	mov_s r12,0x24
L_925c10:
	b L_92028e
