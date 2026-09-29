/* bi_cfg__tick_counters @ 0x937cac, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_cfg__tick_counters
bi_cfg__tick_counters:
	.global L_937cac
L_937cac:
	push_s r13
L_937cae:
	mov_s r2,0x80229c
L_937cb4:
	ldb_s r0,[r2]
L_937cb6:
	mov_s r3,0x8022a8
L_937cbc:
	brne_s r0,0,L_937cd4
L_937cbe:
	ldb_s r0,[r3,0x4]
L_937cc0:
	ldb_s r1,[r2,0x1]
L_937cc2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_937cc4:
	ldb_s r13,[r3,0x5]
L_937cc6:
	extb_s r1,r1
L_937cc8:
	stb_s r0,[r2]
L_937cca:
	stb_s r1,[r2,0x1]
L_937ccc:
	brne r1,r13,L_937cd4
L_937cd0:
	mov_s r1,0x0
L_937cd2:
	stb_s r1,[r2,0x1]
	.global L_937cd4
L_937cd4:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_937cd6:
	stb_s r0,[r2]
L_937cd8:
	ldb_s r0,[r3,0x8]
L_937cda:
	breq_s r0,0,L_937cec
L_937cdc:
	ldb_s r1,[r2,0x5]
L_937cde:
	cmp_s r1,0x0
L_937ce0:
	mov.ne r0,r1
L_937ce4:
	bne_s L_937ce8
L_937ce6:
	stb_s r0,[r2,0x5]
	.global L_937ce8
L_937ce8:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_937cea:
	stb_s r0,[r2,0x5]
	.global L_937cec
L_937cec:
	j_s.d [blink]
L_937cee:
	pop_s r13
