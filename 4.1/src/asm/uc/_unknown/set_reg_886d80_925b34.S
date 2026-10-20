/* set_reg_886d80_925b34 @ 0x925b34, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: bf_pending__set_bit
 */
	.section .text.set_reg_886d80_925b34,"ax",@progbits
	.global set_reg_886d80_925b34
set_reg_886d80_925b34:
	.global L_925b34
L_925b34:
	mov_s r1,0x2
L_925b36:
	mov_s r0,0x886d80
L_925b3c:
	st_s r1,[r0,0x60]
L_925b3e:
	sync
L_925b42:
	b.d L_921f58
L_925b46:
	mov_s r0,0x2
