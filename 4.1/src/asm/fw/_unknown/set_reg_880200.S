/* set_reg_880200 @ 0x8d77fc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.set_reg_880200,"ax",@progbits
	.global set_reg_880200
set_reg_880200:
	.global L_8d77fc
L_8d77fc:
	sub_s sp,sp,0x8
L_8d77fe:
	mov_s r2,0x880200
L_8d7804:
	st_s r0,[r2,0x70]
L_8d7806:
	st_s r1,[r2,0x74]
L_8d7808:
	j_s.d [blink]
L_8d780a:
	add_s sp,sp,0x8
