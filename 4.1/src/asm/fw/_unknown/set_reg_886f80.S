/* set_reg_886f80 @ 0x8e498c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.set_reg_886f80,"ax",@progbits
	.global set_reg_886f80
set_reg_886f80:
	.global L_8e498c
L_8e498c:
	sub_s sp,sp,0x8
L_8e498e:
	mov_s r2,0x886f80
L_8e4994:
	st_s r0,[r2,0x4c]
L_8e4996:
	st_s r1,[r2,0x50]
L_8e4998:
	j_s.d [blink]
L_8e499a:
	add_s sp,sp,0x8
