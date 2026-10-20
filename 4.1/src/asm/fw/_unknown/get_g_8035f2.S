/* get_g_8035f2 @ 0x8c9868, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__vt28
 */
	.section .text.get_g_8035f2,"ax",@progbits
	.global get_g_8035f2
get_g_8035f2:
	.global L_8c9868
L_8c9868:
	mov_s r0,0x8035e8
L_8c986e:
	j_s.d [blink]
L_8c9870:
	ldb_s r0,[r0,0xa]
L_8c9872:
	nop_s
