/* tx_bcon__del_bcon @ 0x8c7578, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_bcon::del_bcon() - TX Beacon mid %d -> Stopping
 * Зовут его: find_mngr__del_discovery_bcon, pcp_stop, scan_mngr__sm_dwelling_ended
 * Зовёт сам: fw_log__emit1, lmac_if__stop_beacon
 */
	.section .text.tx_bcon__del_bcon,"ax",@progbits
	.global tx_bcon__del_bcon
tx_bcon__del_bcon:
	.global L_8c7578
L_8c7578:
	push_s blink
L_8c757a:
	ldb_s r3,[r0,0x10]
L_8c757c:
	mov_s r2,0x1012a10
L_8c7582:
	mov_s r0,0xc
L_8c7584:
	bl.d L_8edfcc
L_8c7588:
	mov_s r1,0x2
L_8c758a:
	bl L_8d815c
L_8c758e:
	mov_s r0,0x0
L_8c7590:
	pop_s blink
L_8c7592:
	j_s [blink]
