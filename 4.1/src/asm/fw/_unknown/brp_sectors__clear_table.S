/* brp_sectors__clear_table @ 0x8caccc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if_class__config_brp_sectors
 */
	.section .text.brp_sectors__clear_table,"ax",@progbits
	.global brp_sectors__clear_table
brp_sectors__clear_table:
	.global L_8caccc
L_8caccc:
	mov_s r0,0x0
L_8cacce:
	mov lp_count,0x20
L_8cacd2:
	mov_s r3,r0
L_8cacd4:
	lp L_8cacf2
L_8cacd8:
	mov_s r2,0x0
L_8cacda:
	mov_s r1,0x857000
L_8cace0:
	ld_s r1,[r1,0x4c]
L_8cace2:
	bset r2,r2,r3
L_8cace6:
	and_s r1,r1,r2
L_8cace8:
	add_s r2,r0,0x1
L_8cacea:
	cmp_s r1,0x0
L_8cacec:
	mov.ne r0,r2
L_8cacf0:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8cacf2
L_8cacf2:
	j_s [blink]
