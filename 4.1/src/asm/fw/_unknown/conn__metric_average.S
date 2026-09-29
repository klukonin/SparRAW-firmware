/* conn__metric_average @ 0x8e2428, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_metric, connection__on_bf_result, connection__update_rs_metric
 * Зовёт сам: fw_div_unsigned
 */
	.section .text.conn__metric_average,"ax",@progbits
	.global conn__metric_average
conn__metric_average:
	.global L_8e2428
L_8e2428:
	push_s blink
L_8e242a:
	ldb r1,[r0, 0x60]
L_8e242e:
	bl.d L_8c03b4
L_8e2432:
	ld_s r0,[r0,0x5c]
L_8e2434:
	extb_s r0,r0
L_8e2436:
	pop_s blink
L_8e2438:
	j_s [blink]
L_8e243a:
	nop_s
