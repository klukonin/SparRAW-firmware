/* itx__slot_ready @ 0x927f40, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global itx__slot_ready
itx__slot_ready:
	.global L_927f40
L_927f40:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_927f42:
	add2_s r0,r0,r0
L_927f44:
	add_s r0,r0,0x802354
L_927f4a:
	ldb_s r1,[r0,0x13]
L_927f4c:
	ldb_s r2,[r0,0xc]
L_927f4e:
	breq r1,0x7,L_927f5a
L_927f52:
	cmp_s r1,0x1
L_927f54:
	cmp.eq r2,0x0
L_927f58:
	bne_s L_927f5e
	.global L_927f5a
L_927f5a:
	mov_s r0,0x1
L_927f5c:
	b_s L_927f60
	.global L_927f5e
L_927f5e:
	ldb_s r0,[r0,0xf]
	.global L_927f60
L_927f60:
	j_s [blink]
L_927f62:
	nop_s
