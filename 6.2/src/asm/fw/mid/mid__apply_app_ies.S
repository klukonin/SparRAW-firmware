/* mid__apply_app_ies @ 0x8e61c0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__set_app_ie, schedule_scheme_builder__build_allocations
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, app_ie__find_by_eid, app_ies__set_buffer, hexdump_words, mid__replace_rsn_ie, regulatory_domain__set_country_code, set_app_ie
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__apply_app_ies
mid__apply_app_ies:
	.global L_8e61c0
L_8e61c0:
	push_s blink
L_8e61c2:
	bl L_8c01d8
L_8e61c6:
	sub_s sp,sp,0xc
L_8e61c8:
	mov_s r13,r0
L_8e61ca:
	mov_s r17,r1
L_8e61cc:
	mov_s r16,r2
L_8e61ce:
	mov_s r15,r3
L_8e61d0:
	mov_s r14,sp
L_8e61d2:
	mov_s r0,r14
L_8e61d4:
	mov_s r1,r3
L_8e61d6:
	bl.d L_8e693c
L_8e61da:
	mov_s r3,0x0
L_8e61dc:
	mov_s r0,r15
L_8e61de:
	bl.d L_8c9790
L_8e61e2:
	mov_s r1,r16
L_8e61e4:
	mov_s r0,r14
L_8e61e6:
	bl.d L_8cc2b8
L_8e61ea:
	mov_s r1,0x30
L_8e61ec:
	mov.f r1,r0
L_8e61f0:
	beq_s L_8e61fa
L_8e61f2:
	bl.d L_8e6f34
L_8e61f6:
	add3 r0,r13,0x9
	.global L_8e61fa
L_8e61fa:
	mov_s r0,r14
L_8e61fc:
	bl.d L_8cc2b8
L_8e6200:
	mov_s r1,0x7
L_8e6202:
	breq_s r0,0,L_8e6210
L_8e6204:
	ldb_s r1,[r0,0x2]
L_8e6206:
	ldb_s r0,[r0,0x3]
L_8e6208:
	asl_s r1,r1,0x8
L_8e620a:
	bl.d L_8e63e0
L_8e620e:
	or_s r0,r0,r1
	.global L_8e6210
L_8e6210:
	add3 r0,r13,0x9
L_8e6214:
	mov_s r1,r17
L_8e6216:
	mov_s r2,r16
L_8e6218:
	bl.d L_8e6224
L_8e621c:
	mov_s r3,r15
L_8e621e:
	b.d L_8c023c
L_8e6222:
	add_s sp,sp,0xc
