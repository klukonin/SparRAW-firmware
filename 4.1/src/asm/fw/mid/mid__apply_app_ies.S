/* mid__apply_app_ies @ 0x8e1458, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ese_cfg__apply, l2mgr__set_app_ie
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, app_ies__set_buffer, ies_block__find_ie, log_hexdump, mid__replace_rsn_ie, regulatory_domain__set_country_code, set_app_ie
 */
	.section .text.mid__apply_app_ies,"ax",@progbits
	.global mid__apply_app_ies
mid__apply_app_ies:
	.global L_8e1458
L_8e1458:
	push_s blink
L_8e145a:
	bl L_8c02b8
L_8e145e:
	sub_s sp,sp,0xc
L_8e1460:
	mov_s r13,r0
L_8e1462:
	mov_s r17,r1
L_8e1464:
	mov_s r16,r2
L_8e1466:
	mov_s r15,r3
L_8e1468:
	mov_s r14,sp
L_8e146a:
	mov_s r0,r14
L_8e146c:
	mov_s r1,r3
L_8e146e:
	bl.d L_8e1afc
L_8e1472:
	mov_s r3,0x0
L_8e1474:
	mov_s r0,r15
L_8e1476:
	bl.d L_8c7f90
L_8e147a:
	mov_s r1,r16
L_8e147c:
	mov_s r0,r14
L_8e147e:
	bl.d L_8ca090
L_8e1482:
	mov_s r1,0x30
L_8e1484:
	mov.f r1,r0
L_8e1488:
	beq_s L_8e1492
L_8e148a:
	bl.d L_8e1fe8
L_8e148e:
	add3 r0,r13,0x9
	.global L_8e1492
L_8e1492:
	mov_s r0,r14
L_8e1494:
	bl.d L_8ca090
L_8e1498:
	mov_s r1,0x7
L_8e149a:
	breq_s r0,0,L_8e14a8
L_8e149c:
	ldb_s r1,[r0,0x2]
L_8e149e:
	ldb_s r0,[r0,0x3]
L_8e14a0:
	asl_s r1,r1,0x8
L_8e14a2:
	bl.d L_8e1670
L_8e14a6:
	or_s r0,r0,r1
	.global L_8e14a8
L_8e14a8:
	add3 r0,r13,0x9
L_8e14ac:
	mov_s r1,r17
L_8e14ae:
	mov_s r2,r16
L_8e14b0:
	bl.d L_8e14bc
L_8e14b4:
	mov_s r3,r15
L_8e14b6:
	b.d L_8c031c
L_8e14ba:
	add_s sp,sp,0xc
