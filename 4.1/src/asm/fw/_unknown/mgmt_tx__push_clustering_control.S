/* mgmt_tx__push_clustering_control @ 0x8e894c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.mgmt_tx__push_clustering_control,"ax",@progbits
	.global mgmt_tx__push_clustering_control
mgmt_tx__push_clustering_control:
	.global L_8e894c
L_8e894c:
	push_s blink
L_8e894e:
	ld.as r1,[r1,0x8f]
L_8e8952:
	add_s r1,r1,0x64
L_8e8954:
	bl.d L_8c0460
L_8e8958:
	mov_s r2,0x6
L_8e895a:
	mov_s r0,0x8
L_8e895c:
	pop_s blink
L_8e895e:
	j_s [blink]
