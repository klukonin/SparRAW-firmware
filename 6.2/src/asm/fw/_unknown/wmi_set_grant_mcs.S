/* wmi_set_grant_mcs @ 0x8e66ac, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_grant_mcs
wmi_set_grant_mcs:
	.global L_8e66ac
L_8e66ac:
	push_s blink
L_8e66ae:
	bl L_8c01dc
L_8e66b2:
	sub_s sp,sp,0x4
L_8e66b4:
	mov_s r16,r0
L_8e66b6:
	bl.d L_8c33d0
L_8e66ba:
	mov_s r13,r1
L_8e66bc:
	mov_s r14,r0
L_8e66be:
	cmp_s r13,0x0
L_8e66c0:
	cmp.ne r13,0x1
L_8e66c4:
	bne_s L_8e66dc
L_8e66c6:
	mov_s r15,0x0
L_8e66c8:
	bl.d L_8c3284
L_8e66cc:
	stb_s r15,[r14]
L_8e66ce:
	stb_s r13,[r0]
L_8e66d0:
	mov_s r1,0x49
L_8e66d2:
	mov_s r2,0x1
L_8e66d4:
	bl.d L_8e5204
L_8e66d8:
	mov_s r3,r15
L_8e66da:
	b_s L_8e66e0
	.global L_8e66dc
L_8e66dc:
	mov_s r0,0x1
L_8e66de:
	stb_s r0,[r14]
	.global L_8e66e0
L_8e66e0:
	mov_s r2,0x0
L_8e66e2:
	st_s r2,[sp,0x0]
L_8e66e4:
	mov_s r0,r16
L_8e66e6:
	mov_s r1,r14
L_8e66e8:
	mov_s r3,0x1a0e
L_8e66ee:
	mov r4,0x4
L_8e66f2:
	mov_s r5,r2
L_8e66f4:
	mov_s r6,r2
L_8e66f6:
	bl.d L_8e4fc4
L_8e66fa:
	mov_s r7,r2
L_8e66fc:
	b.d L_8c0244
L_8e6700:
	add_s sp,sp,0x4
L_8e6702:
	nop_s
