/* uc_send_evt_typed @ 0x925da8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler, ucode_cmd__rx_off, ucode_cmd__rx_on
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, basic_if__alloc_evt_slot, uc_read_tsf_lo, uc_send_event
 */
	.section .text.uc_send_evt_typed,"ax",@progbits
	.global uc_send_evt_typed
uc_send_evt_typed:
	.global L_925da8
L_925da8:
	push_s blink
L_925daa:
	bl L_920210
L_925dae:
	mov_s r15,r0
L_925db0:
	mov_s r0,0x801618
L_925db6:
	bl.d L_921930
L_925dba:
	mov_s r14,r1
L_925dbc:
	bl.d L_9315e8
L_925dc0:
	mov_s r13,r0
L_925dc2:
	st_s r0,[r13]
L_925dc4:
	st_s r14,[r13,0x4]
L_925dc6:
	extw_s r1,r15
L_925dc8:
	mov_s r0,r13
L_925dca:
	mov_s r2,0x8
L_925dcc:
	bl.d L_925dd8
L_925dd0:
	mov_s r3,0x0
L_925dd2:
	b L_92027c
L_925dd6:
	nop_s
