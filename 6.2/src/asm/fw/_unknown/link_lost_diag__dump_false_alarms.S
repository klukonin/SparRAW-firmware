/* link_lost_diag__dump_false_alarms @ 0x8c8678, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PHY: false_alarms.in_txop_ad=%d    false_alarms.in_txop_cp=%d    false_alarms.in_txop_dp=%d
 *   DEBUG PHY: false_alarms.out_txop_ad=%d    false_alarms.out_txop_cp=%d    false_alarms.out_txop_dp=%d
 * Зовут его: fwq_tx__long_retry_failures, link_lost_diag__dump_all
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3, link_lost_diag__dump_phy
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_false_alarms
link_lost_diag__dump_false_alarms:
	.global L_8c8678
L_8c8678:
	push_s blink
L_8c867a:
	push_s r13
L_8c867c:
	mov_s r13,0x853900
L_8c8682:
	ld r4,[r13, 0x2c]
L_8c8686:
	mov_s r1,0x1000fec
L_8c868c:
	ld_s r2,[r13,0x30]
L_8c868e:
	mov_s r0,0x20
L_8c8690:
	bl.d L_8dcd00
L_8c8694:
	ld_s r3,[r13,0x28]
L_8c8696:
	mov_s r1,0x1001050
L_8c869c:
	ld r4,[r13, 0x38]
L_8c86a0:
	mov_s r0,0x20
L_8c86a2:
	ld_s r2,[r13,0x3c]
L_8c86a4:
	bl.d L_8dcd00
L_8c86a8:
	ld_s r3,[r13,0x34]
L_8c86aa:
	bl L_8d2660
L_8c86ae:
	b L_8c025c
L_8c86b2:
	nop_s
