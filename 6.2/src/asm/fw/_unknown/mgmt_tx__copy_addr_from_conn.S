/* mgmt_tx__copy_addr_from_conn @ 0x8c0664, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__copy_addr_from_conn
mgmt_tx__copy_addr_from_conn:
	.global L_8c0664
L_8c0664:
	push_s blink
L_8c0666:
	ld.as r1,[r1,0x8f]
L_8c066a:
	add_s r1,r1,0x64
L_8c066c:
	bl.d L_8c0380
L_8c0670:
	mov_s r2,0x6
L_8c0672:
	mov_s r0,0x8
L_8c0674:
	pop_s blink
L_8c0676:
	j_s [blink]
