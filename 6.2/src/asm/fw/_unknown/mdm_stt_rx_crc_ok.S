/* mdm_stt_rx_crc_ok @ 0x8caeac, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mdm_stt_rx_crc_ok: %d
 * Зовут его: rfc__collect_rx_crc_stats
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mdm_stt_rx_crc_ok
mdm_stt_rx_crc_ok:
	.global L_8caeac
L_8caeac:
	push_s blink
L_8caeae:
	push_s r13
L_8caeb0:
	mov_s r0,0x0
L_8caeb2:
	bl.d L_8d3588
L_8caeb6:
	mov r1,0x428
L_8caeba:
	mov_s r13,r0
L_8caebc:
	mov_s r1,0x10060b4
L_8caec2:
	mov_s r0,0x20
L_8caec4:
	bl.d L_8dcc10
L_8caec8:
	mov_s r2,r13
L_8caeca:
	b.d L_8c025c
L_8caece:
	mov_s r0,r13
