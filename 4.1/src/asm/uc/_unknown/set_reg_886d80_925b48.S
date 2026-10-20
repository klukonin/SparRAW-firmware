/* set_reg_886d80_925b48 @ 0x925b48, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: bf_pending__set_bit
 */
	.section .text.set_reg_886d80_925b48,"ax",@progbits
	.global set_reg_886d80_925b48
set_reg_886d80_925b48:
	.global L_925b48
L_925b48:
	mov_s r1,0x4
L_925b4a:
	mov_s r0,0x886d80
L_925b50:
	st_s r1,[r0,0x60]
L_925b52:
	sync
L_925b56:
	b.d L_921f58
L_925b5a:
	mov_s r0,0x3
