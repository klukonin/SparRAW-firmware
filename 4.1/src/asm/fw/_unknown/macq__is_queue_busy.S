/* macq__is_queue_busy @ 0x8cac60, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_ret, hwd_dma__get_881c80, vring__busy_index_or_ff
 */
	.section .text.macq__is_queue_busy,"ax",@progbits
	.global macq__is_queue_busy
macq__is_queue_busy:
	.global L_8cac60
L_8cac60:
	push_s blink
L_8cac62:
	push_s r13
L_8cac64:
	bl.d L_8cad30
L_8cac68:
	mov_s r13,r0
L_8cac6a:
	cmp r0,0xff
L_8cac6e:
	beq_s L_8cac76
L_8cac70:
	bl L_8cdae8
L_8cac74:
	b_s L_8cac78
	.global L_8cac76
L_8cac76:
	mov_s r0,0x0
	.global L_8cac78
L_8cac78:
	mov_s r1,0x0
L_8cac7a:
	mov_s r2,0x857000
L_8cac80:
	ld.as r3,[r2,0x77]
L_8cac84:
	bset r1,r1,r13
L_8cac88:
	ld_s r2,[r2,0x78]
L_8cac8a:
	and_s r3,r3,r1
L_8cac8c:
	and_s r1,r1,r2
L_8cac8e:
	mov_s r2,0x0
L_8cac90:
	cmp_s r0,0x0
L_8cac92:
	cmp.eq r3,0x0
L_8cac96:
	cmp.eq r1,0x0
L_8cac9a:
	mov.eq r0,r2
L_8cac9e:
	beq_s L_8caca2
L_8caca0:
	mov_s r0,0x1
	.global L_8caca2
L_8caca2:
	b.d L_8c033c
L_8caca6:
	extb_s r0,r0
