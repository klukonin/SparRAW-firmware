/* calib_mngr__engine_start @ 0x8c87e0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Engine of %s is already active
 * Зовут его: calib_mgr_ut
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, calib_engine__post_event, fw_log__emit1_nonl, get_reg_880a3c_8d7540
 */
	.section .text.calib_mngr__engine_start,"ax",@progbits
	.global calib_mngr__engine_start
calib_mngr__engine_start:
	.global L_8c87e0
L_8c87e0:
	sub_s sp,sp,0x4
L_8c87e2:
	push_s blink
L_8c87e4:
	bl L_8c02ac
L_8c87e8:
	mov_s r15,r1
L_8c87ea:
	mov_s r13,r0
L_8c87ec:
	mov_s r20,r2
L_8c87ee:
	mov_s r19,r3
L_8c87f0:
	mov r18,r4
L_8c87f4:
	mov r17,r5
L_8c87f8:
	mov r16,r6
L_8c87fc:
	bl.d L_8d7540
L_8c8800:
	mov_s r14,r7
L_8c8802:
	breq_s r0,0,L_8c8850
L_8c8804:
	asl_s r1,r13,0x5
L_8c8806:
	add1_s r1,r1,r1
L_8c8808:
	add r0,r1,0x842860
L_8c8810:
	ldb_s r1,[r0]
L_8c8812:
	cmp_s r1,0x0
L_8c8814:
	mov_s r1,0x1
L_8c8816:
	sub_s.ne r1,r1,r1
L_8c8818:
	extb.f 0x0,r1
L_8c881c:
	beq_s L_8c8838
L_8c881e:
	mov_s r1,r15
L_8c8820:
	mov_s r2,r20
L_8c8822:
	mov_s r3,r19
L_8c8824:
	mov r4,r18
L_8c8828:
	mov r5,r17
L_8c882c:
	mov r6,r16
L_8c8830:
	bl.d L_8e27a4
L_8c8834:
	mov_s r7,r14
L_8c8836:
	b_s L_8c8850
	.global L_8c8838
L_8c8838:
	mov_s r2,0x10086c4
L_8c883e:
	mov_s r0,0x800d9c
L_8c8844:
	ld.as r3,[r0,r13]
L_8c8848:
	mov_s r0,0x6
L_8c884a:
	bl.d L_8ee080
L_8c884e:
	mov_s r1,0x2
	.global L_8c8850
L_8c8850:
	mov_s r12,0x8
L_8c8852:
	b L_8c0306
L_8c8856:
	nop_s
