/* tx_bcon__del_bcon @ 0x8c8be8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_bcon::del_bcon() - TX Beacon mid %d -> Stopping
 * Зовут его: find_mngr__del_discovery_bcon, pcp_stop, scan_mngr__sm_dwelling_ended
 * Зовёт сам: fw_log_emit1, lmac_if__send_bcon_del_0b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_bcon__del_bcon
tx_bcon__del_bcon:
	.global L_8c8be8
L_8c8be8:
	push_s blink
L_8c8bea:
	ldb_s r2,[r0,0x10]
L_8c8bec:
	mov_s r1,0x1017208
L_8c8bf2:
	bl.d L_8dcc10
L_8c8bf6:
	mov_s r0,0x2c
L_8c8bf8:
	bl L_8db304
L_8c8bfc:
	mov_s r0,0x0
L_8c8bfe:
	pop_s blink
L_8c8c00:
	j_s [blink]
L_8c8c02:
	nop_s
