/* hwd_rfc_read_get_result @ 0x8f41ac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_get_result: returning result: %d
 * Зовут его: wmi_evt__notify_fw_ready
 * Зовёт сам: fw_log_emit1
 * Глобалы (через gp): 0x800245
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_read_get_result
hwd_rfc_read_get_result:
	.global L_8f41ac
L_8f41ac:
	push_s blink
L_8f41ae:
	ldb_s r0,[gp,0xc1]
L_8f41b0:
	mov_s r1,0x101ed30
L_8f41b6:
	add_s r2,r0,0x6
L_8f41b8:
	bl.d L_8dcc10
L_8f41bc:
	mov_s r0,0x20
L_8f41be:
	ldb_s r0,[gp,0xc1]
L_8f41c0:
	/* add_s r0,0x6 */
	.byte 0x06,0xe0
L_8f41c2:
	extb_s r0,r0
L_8f41c4:
	pop_s blink
L_8f41c6:
	j_s [blink]
