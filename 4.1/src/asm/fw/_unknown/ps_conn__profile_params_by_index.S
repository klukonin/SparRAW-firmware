/* ps_conn__profile_params_by_index @ 0x8ca90c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete
 */
	.section .text.ps_conn__profile_params_by_index,"ax",@progbits
	.global ps_conn__profile_params_by_index
ps_conn__profile_params_by_index:
	.global L_8ca90c
L_8ca90c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8ca90e:
	add3_s r0,r0,r0
L_8ca910:
	add_s r0,r0,0x8035c8
L_8ca916:
	ldb_s r2,[r0,0xc]
L_8ca918:
	stb_s r2,[r1]
L_8ca91a:
	ldb_s r2,[r0,0xb]
L_8ca91c:
	mov_s r0,0x0
L_8ca91e:
	bset r0,r0,r2
L_8ca922:
	j_s.d [blink]
L_8ca924:
	stb_s r0,[r1,0x1]
L_8ca926:
	nop_s
