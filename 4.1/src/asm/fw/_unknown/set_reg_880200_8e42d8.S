/* set_reg_880200_8e42d8 @ 0x8e42d8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power__store_and_program_880200
 * Зовёт сам: irq_ack_880b00
 */
	.section .text.set_reg_880200_8e42d8,"ax",@progbits
	.global set_reg_880200_8e42d8
set_reg_880200_8e42d8:
	.global L_8e42d8
L_8e42d8:
	mov_s r1,0x880200
L_8e42de:
	st_s r0,[r1,0x48]
L_8e42e0:
	mov_s r0,0x65
L_8e42e2:
	st_s r0,[r1,0x58]
L_8e42e4:
	sync
L_8e42e8:
	b.d L_8e42f0
L_8e42ec:
	mov_s r0,0x1
L_8e42ee:
	nop_s
