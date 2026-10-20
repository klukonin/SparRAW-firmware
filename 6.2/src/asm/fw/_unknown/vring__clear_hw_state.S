/* vring__clear_hw_state @ 0x8caf30, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__remove_vring
 * Зовёт сам: hwd_dma__uses_rgf_881c00_8d0c18
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__clear_hw_state
vring__clear_hw_state:
	.global L_8caf30
L_8caf30:
	mov_s r1,0x0
L_8caf32:
	st_s r1,[r0,0x24]
L_8caf34:
	st_s r1,[r0,0x20]
L_8caf36:
	st_s r1,[r0,0x14]
L_8caf38:
	st_s r1,[r0,0x18]
L_8caf3a:
	st_s r1,[r0,0x1c]
L_8caf3c:
	ldb_s r1,[r0,0x9]
L_8caf3e:
	mov_s r0,0x0
L_8caf40:
	bset r0,r0,r1
L_8caf44:
	b.d L_8d0c18
L_8caf48:
	mov_s r1,0x1
L_8caf4a:
	nop_s
