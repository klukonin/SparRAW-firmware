/* mgmt_tx__push_bi_control @ 0x8e8960, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.mgmt_tx__push_bi_control,"ax",@progbits
	.global mgmt_tx__push_bi_control
mgmt_tx__push_bi_control:
	.global L_8e8960
L_8e8960:
	push_s blink
L_8e8962:
	add r1,r1,0x14f
L_8e8966:
	bl.d L_8c0460
L_8e896a:
	mov_s r2,0x6
L_8e896c:
	mov_s r0,0x6
L_8e896e:
	pop_s blink
L_8e8970:
	j_s [blink]
L_8e8972:
	nop_s
