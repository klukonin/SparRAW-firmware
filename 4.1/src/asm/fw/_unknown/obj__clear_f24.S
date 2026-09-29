/* obj__clear_f24 @ 0x8c92fc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__free_locked
 */
	.section .text.obj__clear_f24,"ax",@progbits
	.global obj__clear_f24
obj__clear_f24:
	.global L_8c92fc
L_8c92fc:
	mov_s r1,0x0
L_8c92fe:
	j_s.d [blink]
L_8c9300:
	st_s r1,[r0,0x24]
L_8c9302:
	nop_s
