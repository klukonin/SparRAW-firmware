/* mem_pool__put_block @ 0x8c6414, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__free__8cb19c
 * Зовёт сам: __ld_r13_to_r13_ret, mem_pool__get_field14, tx_api__mask_from_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__put_block
mem_pool__put_block:
	.global L_8c6414
L_8c6414:
	push_s blink
L_8c6416:
	push_s r13
L_8c6418:
	add_s r13,r0,0x4
L_8c641a:
	bl.d L_8e0904
L_8c641e:
	mov_s r0,r13
L_8c6420:
	cmp_s r0,0x0
L_8c6422:
	bl.ne.d L_8e97e8
L_8c6426:
	mov.ne r0,r13
L_8c642a:
	b L_8c025c
L_8c642e:
	nop_s
