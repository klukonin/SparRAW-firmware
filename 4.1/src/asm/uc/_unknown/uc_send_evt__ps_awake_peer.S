/* uc_send_evt__ps_awake_peer @ 0x925ba4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps__notify_awake_peers, ps_awake_peer__build_evt, ps_awake_peer__send_clear_peer, ps_awake_peer__send_full
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__ps_awake_peer,"ax",@progbits
	.global uc_send_evt__ps_awake_peer
uc_send_evt__ps_awake_peer:
	.global L_925ba4
L_925ba4:
	push_s blink
L_925ba6:
	bl L_920214
L_925baa:
	mov_s r14,r0
L_925bac:
	mov_s r0,0x801618
L_925bb2:
	bl L_921930
L_925bb6:
	mov_s r1,r14
L_925bb8:
	mov_s r13,r0
L_925bba:
	bl.d L_920310
L_925bbe:
	mov_s r2,0x4
L_925bc0:
	mov_s r0,r13
L_925bc2:
	mov_s r1,0x16
L_925bc4:
	mov_s r2,0x4
L_925bc6:
	bl.d L_925dd8
L_925bca:
	mov_s r3,0x0
L_925bcc:
	b L_920284
