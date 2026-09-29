/* rgf_reg_881b00_8db334 @ 0x8db334, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_dma__build_desc
 */
	.section .text.rgf_reg_881b00_8db334,"ax",@progbits
	.global rgf_reg_881b00_8db334
rgf_reg_881b00_8db334:
	.global L_8db334
L_8db334:
	mov_s r1,0x881b00
L_8db33a:
	ld_s r0,[r1,0x24]
L_8db33c:
	bset_s r0,r0,0x1
L_8db33e:
	st_s r0,[r1,0x24]
