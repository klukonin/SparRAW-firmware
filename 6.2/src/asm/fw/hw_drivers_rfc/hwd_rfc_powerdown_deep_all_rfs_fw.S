/* hwd_rfc_powerdown_deep_all_rfs_fw @ 0x8d3424, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_powerdown_deep_all_rfs
 *   hwd_rfc_powerdown_deep_all_rfs - orig_rfc:%d
 * Зовут его: hwm_analog_channel_switch, power_halt_seq
 * Зовёт сам: fw_log_emit0, fw_log_emit1, hwd__setup_pair, hwd_abif__dvs_rfca_cmd_enable
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_powerdown_deep_all_rfs_fw
hwd_rfc_powerdown_deep_all_rfs_fw:
	.global L_8d3424
L_8d3424:
	push_s blink
L_8d3426:
	sub_s sp,sp,0x4
L_8d3428:
	mov_s r1,0x101e3c0
L_8d342e:
	bl.d L_8dcba8
L_8d3432:
	mov_s r0,0x21
L_8d3434:
	mov_s r1,sp
L_8d3436:
	bl.d L_8ce910
L_8d343a:
	mov_s r0,0xff
L_8d343c:
	bl.d L_8d33f8
L_8d3440:
	mov_s r0,0x0
L_8d3442:
	ldb_s r0,[sp,0x0]
L_8d3444:
	bl.d L_8ce910
L_8d3448:
	mov_s r1,0x0
L_8d344a:
	mov_s r1,0x101e3e0
L_8d3450:
	mov_s r0,0x21
L_8d3452:
	bl.d L_8dcc10
L_8d3456:
	ldb_s r2,[sp,0x0]
L_8d3458:
	add_s sp,sp,0x4
L_8d345a:
	pop_s blink
L_8d345c:
	j_s [blink]
L_8d345e:
	nop_s
