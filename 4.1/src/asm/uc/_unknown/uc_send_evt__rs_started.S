/* uc_send_evt__rs_started @ 0x925cdc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, uc_send_event
 */
	.section .text.uc_send_evt__rs_started,"ax",@progbits
	.global uc_send_evt__rs_started
uc_send_evt__rs_started:
	.global L_925cdc
L_925cdc:
	push_s blink
L_925cde:
	push_s r13
L_925ce0:
	mov_s r13,r0
L_925ce2:
	mov_s r0,0x801618
L_925ce8:
	bl L_921930
L_925cec:
	mov_s r1,0x13
L_925cee:
	st_s r13,[r0]
L_925cf0:
	mov_s r2,0x4
L_925cf2:
	bl.d L_925dd8
L_925cf6:
	mov_s r3,0x0
L_925cf8:
	b L_92028c
