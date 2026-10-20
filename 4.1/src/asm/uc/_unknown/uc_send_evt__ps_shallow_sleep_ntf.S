/* uc_send_evt__ps_shallow_sleep_ntf @ 0x925d28, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: perform_shallow_sleep
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__ps_shallow_sleep_ntf,"ax",@progbits
	.global uc_send_evt__ps_shallow_sleep_ntf
uc_send_evt__ps_shallow_sleep_ntf:
	.global L_925d28
L_925d28:
	push_s blink
L_925d2a:
	bl L_920214
L_925d2e:
	mov_s r14,r0
L_925d30:
	mov_s r0,0x801618
L_925d36:
	bl L_921930
L_925d3a:
	mov_s r1,r14
L_925d3c:
	mov_s r13,r0
L_925d3e:
	bl.d L_920310
L_925d42:
	mov_s r2,0xc
L_925d44:
	mov_s r0,r13
L_925d46:
	mov_s r1,0x15
L_925d48:
	mov_s r2,0xc
L_925d4a:
	bl.d L_925dd8
L_925d4e:
	mov_s r3,0x0
L_925d50:
	b L_920284
