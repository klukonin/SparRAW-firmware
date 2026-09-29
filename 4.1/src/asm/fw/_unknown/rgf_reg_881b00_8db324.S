/* rgf_reg_881b00_8db324 @ 0x8db324, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__setup_bcast_vring
 */
	.section .text.rgf_reg_881b00_8db324,"ax",@progbits
	.global rgf_reg_881b00_8db324
rgf_reg_881b00_8db324:
	.global L_8db324
L_8db324:
	mov_s r1,0x881b00
L_8db32a:
	ld_s r0,[r1,0x24]
L_8db32c:
	bclr_s r0,r0,0x0
L_8db32e:
	st_s r0,[r1,0x24]
L_8db330:
	j_s [blink]
L_8db332:
	nop_s
