/* link_lost_diag__dump_false_alarms @ 0x8eae60, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PHY: false_alarms.in_txop_ad=%d    false_alarms.in_txop_cp=%d    false_alarms.in_txop_dp=%d
 *   DEBUG PHY: false_alarms.out_txop_ad=%d    false_alarms.out_txop_cp=%d    false_alarms.out_txop_dp=%d
 * Зовут его: fwq_tx__long_retry_failures, link_lost_diag__dump_all
 * Зовёт сам: __ld_r13_ret, fw_log__emit3, link_lost_diag__dump_phy
 */
	.section .text.link_lost_diag__dump_false_alarms,"ax",@progbits
	.global link_lost_diag__dump_false_alarms
link_lost_diag__dump_false_alarms:
	.global L_8eae60
L_8eae60:
	push_s blink
L_8eae62:
	push_s r13
L_8eae64:
	mov_s r13,0x854d80
L_8eae6a:
	ld r4,[r13, 0x8]
L_8eae6e:
	mov_s r2,0x1001180
L_8eae74:
	ld r5,[r13, 0xc]
L_8eae78:
	mov_s r0,0x0
L_8eae7a:
	mov_s r1,0x2
L_8eae7c:
	bl.d L_8ee034
L_8eae80:
	ld_s r3,[r13,0x10]
L_8eae82:
	mov_s r2,0x10011e4
L_8eae88:
	ld r4,[r13, 0x14]
L_8eae8c:
	mov_s r0,0x0
L_8eae8e:
	ld r5,[r13, 0x18]
L_8eae92:
	mov_s r1,0x2
L_8eae94:
	bl.d L_8ee034
L_8eae98:
	ld_s r3,[r13,0x1c]
L_8eae9a:
	bl L_8cf988
L_8eae9e:
	b L_8c033c
L_8eaea2:
	nop_s
