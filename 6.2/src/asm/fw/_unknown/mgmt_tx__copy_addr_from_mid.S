/* mgmt_tx__copy_addr_from_mid @ 0x8c0678, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_build_step
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mgmt_tx__copy_addr_from_mid
mgmt_tx__copy_addr_from_mid:
	.global L_8c0678
L_8c0678:
	push_s blink
L_8c067a:
	add r1,r1,0x14f
L_8c067e:
	bl.d L_8c0380
L_8c0682:
	mov_s r2,0x6
L_8c0684:
	mov_s r0,0x6
L_8c0686:
	pop_s blink
L_8c0688:
	j_s [blink]
L_8c068a:
	nop_s
