/* app_ies__clear @ 0x8c5a00, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init, set_app_ie
 */
	.section .text.app_ies__clear,"ax",@progbits
	.global app_ies__clear
app_ies__clear:
	.global L_8c5a00
L_8c5a00:
	ld_s r2,[r0]
L_8c5a02:
	mov_s r1,0x0
L_8c5a04:
	st_s r1,[r0]
L_8c5a06:
	stw_s r1,[r0,0x4]
L_8c5a08:
	j_s.d [blink]
L_8c5a0a:
	mov_s r0,r2
