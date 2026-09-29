/* mac__set_cid_mcs_uc @ 0x929568, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__apply_mcs
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_cid_mcs_uc
mac__set_cid_mcs_uc:
	.global L_929568
L_929568:
	st.a r13,[sp,-0x14]
L_92956c:
	st blink,[sp, 0x4]
L_929570:
	st_s r14,[sp,0x8]
L_929572:
	st_s r15,[sp,0xc]
L_929574:
	st r16,[sp, 0x10]
L_929578:
	mov_s r13,0x80178c
L_92957e:
	add1_s r13,r13,r0
L_929580:
	ldw r5,[r13]
L_929584:
	mov r16,0xffff0000
L_92958c:
	tst r5,r16
L_929590:
	mov r15,r0
L_929594:
	bne.d L_9295e4
L_929598:
	mov r14,r1
	.global L_92959c
L_92959c:
	mov r4,0x887000
L_9295a4:
	ld.as r2,[r4,-0xe4]
L_9295a8:
	ldw_s r1,[r13]
L_9295aa:
	and r2,r2,r16
L_9295ae:
	or_s r1,r1,r2
L_9295b0:
	st.as r1,[r4,-0xe4]
L_9295b4:
	ldb r3,[r15,0x8017a8]
L_9295bc:
	asl_s r0,r14,0x5
L_9295be:
	st.as r3,[r4,-0xe3]
L_9295c2:
	add_s r0,r0,0x4435800
L_9295c8:
	lsr_s r0,r0,0x3
L_9295ca:
	bic r0,r0,0x3
L_9295ce:
	st_s r15,[r0]
L_9295d0:
	ld blink,[sp, 0x4]
L_9295d4:
	ld_s r14,[sp,0x8]
L_9295d6:
	ld_s r15,[sp,0xc]
L_9295d8:
	ld r16,[sp, 0x10]
L_9295dc:
	j.d [blink]
L_9295e0:
	ld.ab r13,[sp,0x14]
	.global L_9295e4
L_9295e4:
	mov r0,blink
L_9295e8:
	bl.d L_926618
L_9295ec:
	mov r1,0xac
L_9295f0:
	b_s L_92959c
L_9295f2:
	nop_s
