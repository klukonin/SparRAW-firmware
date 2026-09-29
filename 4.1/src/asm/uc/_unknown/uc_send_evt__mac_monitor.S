/* uc_send_evt__mac_monitor @ 0x925b84, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_window_transition_prep
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, uc_send_event
 */
	.section .text.uc_send_evt__mac_monitor,"ax",@progbits
	.global uc_send_evt__mac_monitor
uc_send_evt__mac_monitor:
	.global L_925b84
L_925b84:
	push_s blink
L_925b86:
	push_s r13
L_925b88:
	mov_s r13,r0
L_925b8a:
	mov_s r0,0x801618
L_925b90:
	bl L_921930
L_925b94:
	mov_s r1,0x17
L_925b96:
	st_s r13,[r0]
L_925b98:
	mov_s r2,0x4
L_925b9a:
	bl.d L_925dd8
L_925b9e:
	mov_s r3,0x0
L_925ba0:
	b L_92028c
