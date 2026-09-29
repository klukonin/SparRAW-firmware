/* mem_pool__put_block @ 0x8c5740, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__free_8062c4
 * Зовёт сам: __ld_r13_ret, frag_8dc6f0, mem_pool__notify_dma
 */
	.section .text.mem_pool__put_block,"ax",@progbits
	.global mem_pool__put_block
mem_pool__put_block:
	.global L_8c5740
L_8c5740:
	push_s blink
L_8c5742:
	push_s r13
L_8c5744:
	add_s r13,r0,0x4
L_8c5746:
	bl.d L_8dc6f0
L_8c574a:
	mov_s r0,r13
L_8c574c:
	cmp_s r0,0x0
L_8c574e:
	bl.ne.d L_8e4728
L_8c5752:
	mov.ne r0,r13
L_8c5756:
	b L_8c033c
L_8c575a:
	nop_s
