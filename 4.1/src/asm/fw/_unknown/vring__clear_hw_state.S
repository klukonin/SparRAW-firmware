/* vring__clear_hw_state @ 0x8c92e0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__remove_vring
 * Зовёт сам: hwd_dma__ack_881c54
 */
	.section .text.vring__clear_hw_state,"ax",@progbits
	.global vring__clear_hw_state
vring__clear_hw_state:
	.global L_8c92e0
L_8c92e0:
	mov_s r1,0x0
L_8c92e2:
	st_s r1,[r0,0x24]
L_8c92e4:
	st_s r1,[r0,0x20]
L_8c92e6:
	st_s r1,[r0,0x14]
L_8c92e8:
	st_s r1,[r0,0x18]
L_8c92ea:
	st_s r1,[r0,0x1c]
L_8c92ec:
	ldb_s r1,[r0,0x9]
L_8c92ee:
	mov_s r0,0x0
L_8c92f0:
	bset r0,r0,r1
L_8c92f4:
	b.d L_8cdec4
L_8c92f8:
	mov_s r1,0x1
L_8c92fa:
	nop_s
