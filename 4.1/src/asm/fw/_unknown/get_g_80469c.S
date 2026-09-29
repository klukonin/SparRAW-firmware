/* get_g_80469c @ 0x8d7030, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__clean_all_lists
 */
	.section .text.get_g_80469c,"ax",@progbits
	.global get_g_80469c
get_g_80469c:
	.global L_8d7030
L_8d7030:
	ldb_s r1,[r0,0x8]
L_8d7032:
	mov_s r0,0x80469c
L_8d7038:
	add3_s r0,r0,r1
L_8d703a:
	ld_s r0,[r0]
L_8d703c:
	cmp_s r0,0x0
L_8d703e:
	mov_s r0,0x1
L_8d7040:
	j_s.d [blink]
L_8d7042:
	sub_s.ne r0,r0,r0
