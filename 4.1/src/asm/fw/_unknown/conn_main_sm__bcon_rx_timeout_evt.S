/* conn_main_sm__bcon_rx_timeout_evt @ 0x8c3ef0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    conn_main_sm::bcon_rx_timeout_evt
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.conn_main_sm__bcon_rx_timeout_evt,"ax",@progbits
	.global conn_main_sm__bcon_rx_timeout_evt
conn_main_sm__bcon_rx_timeout_evt:
L_8c3ef0:
	j_s [blink]
	.global fwlog_conn_main_sm_bcon_rx_timeout_evt
fwlog_conn_main_sm_bcon_rx_timeout_evt:
L_8c3ef2:
	nop_s
L_8c3ef4:
	push_s blink
L_8c3ef6:
	push_s r13
L_8c3ef8:
	mov_s r13,r0
L_8c3efa:
	mov_s r2,0x100f860
L_8c3f00:
	mov_s r0,0xb
L_8c3f02:
	bl.d L_8edfb0
L_8c3f06:
	mov_s r1,0x1
L_8c3f08:
	mov_s r2,0x0
L_8c3f0a:
	st_s r2,[r13,0x74]
L_8c3f0c:
	mov_s r0,r13
L_8c3f0e:
	mov_s r1,0x1
L_8c3f10:
	mov_s r3,r2
L_8c3f12:
	bl.d L_8d6a1c
L_8c3f16:
	mov_s r4,r2
L_8c3f18:
	b L_8c033c
