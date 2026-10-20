/* ba_sm__on_start_ba_setup__ba_agreed_state @ 0x8e5424, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ba_sm__on_start_ba_setup__ba_agreed_state,"ax",@progbits
	.global ba_sm__on_start_ba_setup__ba_agreed_state
ba_sm__on_start_ba_setup__ba_agreed_state:
L_8e5424:
	ldb_s r1,[r0]
L_8e5426:
	sub.f r1,r1,0x1
L_8e542a:
	mov_s r2,0x4
L_8e542c:
	beq_s L_8e5442
L_8e542e:
	brne r1,0x1,L_8e5436
	.global L_8e5432
L_8e5432:
	mov_s r1,r2
L_8e5434:
	b_s L_8e5444
	.global L_8e5436
L_8e5436:
	cmp_s r1,0x2
L_8e5438:
	cmp.ne r1,0x3
L_8e543c:
	bne_s L_8e5432
L_8e543e:
	mov_s r1,0x2
L_8e5440:
	b_s L_8e5444
	.global L_8e5442
L_8e5442:
	mov_s r1,0x3
	.global L_8e5444
L_8e5444:
	ld r0,[r0, 0xac]
L_8e5448:
	ld r2,[r0, 0xd4]
L_8e544c:
	ld_s r2,[r2,0x14]
L_8e544e:
	j_s.d [r2]
