/* rf_chain__set_mode_field @ 0x8e5270, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 * Зовёт сам: bf_w_s22_w2
 */
	.section .text.rf_chain__set_mode_field,"ax",@progbits
	.global rf_chain__set_mode_field
rf_chain__set_mode_field:
	.global L_8e5270
L_8e5270:
	push_s blink
L_8e5272:
	cmp_s r1,0x1
L_8e5274:
	cmp.ne r1,0x2
L_8e5278:
	mov_s r1,0x0
L_8e527a:
	bne_s L_8e527e
L_8e527c:
	mov_s r1,0x2
	.global L_8e527e
L_8e527e:
	bl L_8e8420
L_8e5282:
	pop_s blink
L_8e5284:
	j_s [blink]
L_8e5286:
	nop_s
