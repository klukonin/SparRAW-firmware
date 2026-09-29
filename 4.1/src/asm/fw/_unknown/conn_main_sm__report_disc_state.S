/* conn_main_sm__report_disc_state @ 0x8eb504, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__start_disc
 * Зовёт сам: L2MGR__system_state_evt_handler
 */
	.section .text.conn_main_sm__report_disc_state,"ax",@progbits
	.global conn_main_sm__report_disc_state
conn_main_sm__report_disc_state:
	.global L_8eb504
L_8eb504:
	ldb_s r1,[r0,0x8]
L_8eb506:
	b.d L_8e3a08
L_8eb50a:
	mov_s r0,0x7
