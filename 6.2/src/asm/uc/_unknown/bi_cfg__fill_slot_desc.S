/* bi_cfg__fill_slot_desc @ 0x92af98, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__pack_words_78_7c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_cfg__fill_slot_desc
bi_cfg__fill_slot_desc:
	.global L_92af98
L_92af98:
	ldb_s r2,[r1,0x4]
L_92af9a:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_92af9c:
	stb_s r2,[r0]
L_92af9e:
	mov_s r2,0x1
L_92afa0:
	stb_s r2,[r0,0x2]
L_92afa2:
	mov_s r2,0x0
L_92afa4:
	stb_s r2,[r0,0x3]
L_92afa6:
	ldb_s r1,[r1,0x8]
L_92afa8:
	breq_s r1,0,L_92afb0
L_92afaa:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_92afac:
	extb_s r1,r1
L_92afae:
	b_s L_92afb2
	.global L_92afb0
L_92afb0:
	mov_s r1,0xf
	.global L_92afb2
L_92afb2:
	stb_s r1,[r0,0x5]
L_92afb4:
	j_s.d [blink]
L_92afb6:
	stb_s r2,[r0,0x1]
