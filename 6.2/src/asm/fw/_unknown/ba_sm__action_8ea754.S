/* ba_sm__action_8ea754 @ 0x8ea754, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8ea754
ba_sm__action_8ea754:
	.global L_8ea754
L_8ea754:
	ldb_s r1,[r0]
L_8ea756:
	sub.f r1,r1,0x1
L_8ea75a:
	mov_s r2,0x4
L_8ea75c:
	beq_s L_8ea772
L_8ea75e:
	brne r1,0x1,L_8ea766
	.global L_8ea762
L_8ea762:
	mov_s r1,r2
L_8ea764:
	b_s L_8ea774
	.global L_8ea766
L_8ea766:
	cmp_s r1,0x2
L_8ea768:
	cmp.ne r1,0x3
L_8ea76c:
	bne_s L_8ea762
L_8ea76e:
	mov_s r1,0x2
L_8ea770:
	b_s L_8ea774
	.global L_8ea772
L_8ea772:
	mov_s r1,0x3
	.global L_8ea774
L_8ea774:
	ld_s r0,[r0,0x40]
L_8ea776:
	ld_s r2,[r0,0x68]
L_8ea778:
	ld_s r2,[r2,0x14]
L_8ea77a:
	j_s.d [r2]
L_8ea77c:
	extw_s r1,r1
L_8ea77e:
	nop_s
