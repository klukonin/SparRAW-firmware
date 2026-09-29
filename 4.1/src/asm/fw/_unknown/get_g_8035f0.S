/* get_g_8035f0 @ 0x8ca458, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_nonassoc_mgr__vt28
 */
	.section .text.get_g_8035f0,"ax",@progbits
	.global get_g_8035f0
get_g_8035f0:
	.global L_8ca458
L_8ca458:
	mov_s r0,0x8035e8
L_8ca45e:
	j_s.d [blink]
L_8ca460:
	ldb_s r0,[r0,0x8]
L_8ca462:
	nop_s
