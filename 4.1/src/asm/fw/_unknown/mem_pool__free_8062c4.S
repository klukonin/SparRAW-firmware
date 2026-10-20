/* mem_pool__free_8062c4 @ 0x8c9578, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_buf__free, rx_api__free_rx_buffer
 * Зовёт сам: __ld_r13_ret, mem_pool__free, mem_pool__put_block
 */
	.section .text.mem_pool__free_8062c4,"ax",@progbits
	.global mem_pool__free_8062c4
mem_pool__free_8062c4:
	.global L_8c9578
L_8c9578:
	push_s blink
L_8c957a:
	push_s r13
L_8c957c:
	mov_s r1,r0
L_8c957e:
	mov_s r13,0x8062c4
L_8c9584:
	bl.d L_8c9268
L_8c9588:
	add r0,r13,0x1c
L_8c958c:
	bl.d L_8c5740
L_8c9590:
	mov_s r0,r13
L_8c9592:
	b L_8c033c
L_8c9596:
	nop_s
