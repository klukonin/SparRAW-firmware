/* app_ies__clear @ 0x8c6784, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init, set_app_ie
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ies__clear
app_ies__clear:
	.global L_8c6784
L_8c6784:
	ld_s r2,[r0]
L_8c6786:
	mov_s r1,0x0
L_8c6788:
	st_s r1,[r0]
L_8c678a:
	stw_s r1,[r0,0x4]
L_8c678c:
	j_s.d [blink]
L_8c678e:
	mov_s r0,r2
