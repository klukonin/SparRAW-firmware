/* fw_scheduled_dti__update_ie @ 0x8e5708, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_scheduled_dti.cpp
 * Зовут его: bcon__refresh_dti_ie
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_divmod_signed, fw_sysassert_fatal, ies_block__find_ie, mac__mul_886fc4_by_886d64, memcpy_fw, tx_bcon__update_bcon
 */
	.section .text.fw_scheduled_dti__update_ie,"ax",@progbits
	.global fw_scheduled_dti__update_ie
fw_scheduled_dti__update_ie:
	.global L_8e5708
L_8e5708:
	push_s blink
L_8e570a:
	bl L_8c02b8
L_8e570e:
	sub_s sp,sp,0x4
L_8e5710:
	mov_s r15,r0
L_8e5712:
	add r17,r0,0x8
L_8e5716:
	mov_s r0,r1
L_8e5718:
	bl.d L_8ca090
L_8e571c:
	mov_s r1,0x90
L_8e571e:
	mov_s r13,r0
L_8e5720:
	bl.d L_8e47b4
L_8e5724:
	mov_s r0,0x1
L_8e5726:
	mov_s r16,r0
L_8e5728:
	mov_s r0,0x886f80
L_8e572e:
	ld_s r0,[r0,0x44]
L_8e5730:
	breq_s r13,0,L_8e576c
	.global L_8e5732
L_8e5732:
	mov_s r14,0x0
L_8e5734:
	b_s L_8e5754
	.global L_8e5736
L_8e5736:
	add2 r1,r14,r14
L_8e573a:
	add1_s r1,r1,r1
L_8e573c:
	add r0,r13,0x8
L_8e5740:
	add_s r0,r0,r1
L_8e5742:
	ld.as r1,[r17,r14]
L_8e5746:
	add_s r1,r1,r16
L_8e5748:
	st_s r1,[sp,0x0]
L_8e574a:
	mov_s r1,sp
L_8e574c:
	bl.d L_8c0460
L_8e5750:
	mov_s r2,0x4
L_8e5752:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e5754
L_8e5754:
	ldb_s r0,[r13,0x1]
L_8e5756:
	bl.d L_8c03bc
L_8e575a:
	mov_s r1,0xf
L_8e575c:
	brlt r14,r0,L_8e5736
L_8e5760:
	bl.d L_8c2190
L_8e5764:
	ld_s r0,[r15]
L_8e5766:
	b.d L_8c031c
L_8e576a:
	add_s sp,sp,0x4
	.global L_8e576c
L_8e576c:
	mov_s r0,blink
L_8e576e:
	mov_s r2,0x10119e8
L_8e5774:
	mov_s r1,0x1476
L_8e577a:
	bl.d L_8c82c0
L_8e577e:
	mov_s r3,0xb3
L_8e5780:
	b_s L_8e5732
L_8e5782:
	nop_s
