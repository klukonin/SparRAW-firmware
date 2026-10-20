/* vring__busy_index_or_ff @ 0x8cad30, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__is_queue_busy
 * Зовёт сам: vring__find_busy_index
 */
	.section .text.vring__busy_index_or_ff,"ax",@progbits
	.global vring__busy_index_or_ff
vring__busy_index_or_ff:
	.global L_8cad30
L_8cad30:
	push_s blink
L_8cad32:
	bl L_8cacf4
L_8cad36:
	cmp_s r0,0x0
L_8cad38:
	mov.eq r0,0xff
L_8cad40:
	beq_s L_8cad44
L_8cad42:
	ldb_s r0,[r0,0x9]
	.global L_8cad44
L_8cad44:
	pop_s blink
L_8cad46:
	j_s [blink]
