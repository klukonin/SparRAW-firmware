/* vring__busy_index_or_zero @ 0x8cad1c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: vring__find_busy_index
 */
	.section .text.vring__busy_index_or_zero,"ax",@progbits
	.global vring__busy_index_or_zero
vring__busy_index_or_zero:
	.global L_8cad1c
L_8cad1c:
	push_s blink
L_8cad1e:
	bl L_8cacf4
L_8cad22:
	cmp_s r0,0x0
L_8cad24:
	mov.eq r0,0x0
L_8cad28:
	beq_s L_8cad2c
L_8cad2a:
	ld_s r0,[r0,0x1c]
	.global L_8cad2c
L_8cad2c:
	pop_s blink
L_8cad2e:
	j_s [blink]
