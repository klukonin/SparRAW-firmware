/* ese__find_alloc_by_id @ 0x8d733c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ese_cfg__apply, parse_ese
 */
	.section .text.ese__find_alloc_by_id,"ax",@progbits
	.global ese__find_alloc_by_id
ese__find_alloc_by_id:
	.global L_8d733c
L_8d733c:
	push_s r13
L_8d733e:
	mov_s r13,0xff
L_8d7340:
	mov_s r3,0x0
L_8d7342:
	breq r1,r13,L_8d735a
L_8d7346:
	ld_s r0,[r0]
L_8d7348:
	ldb_s r0,[r0,0x8]
L_8d734a:
	cmp_s r1,r0
L_8d734c:
	cmp.ne r2,r13
L_8d7350:
	cmp.ne r2,r0
L_8d7354:
	mov.ne r0,r3
L_8d7358:
	bne_s L_8d735c
	.global L_8d735a
L_8d735a:
	mov_s r0,0x1
	.global L_8d735c
L_8d735c:
	extb_s r0,r0
L_8d735e:
	j_s.d [blink]
L_8d7360:
	pop_s r13
L_8d7362:
	nop_s
