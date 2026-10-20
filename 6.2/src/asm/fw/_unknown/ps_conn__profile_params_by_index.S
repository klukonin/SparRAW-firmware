/* ps_conn__profile_params_by_index @ 0x8ccc7c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_801d64__action_8e175c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_conn__profile_params_by_index
ps_conn__profile_params_by_index:
	.global L_8ccc7c
L_8ccc7c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8ccc7e:
	add3_s r0,r0,r0
L_8ccc80:
	add_s r0,r0,0x803d5c
L_8ccc86:
	ldb_s r2,[r0,0xc]
L_8ccc88:
	stb_s r2,[r1]
L_8ccc8a:
	ldb_s r2,[r0,0xb]
L_8ccc8c:
	mov_s r0,0x0
L_8ccc8e:
	bset r0,r0,r2
L_8ccc92:
	j_s.d [blink]
L_8ccc94:
	stb_s r0,[r1,0x1]
L_8ccc96:
	nop_s
