/* app_ie__remove_tlv @ 0x8e255c, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Remove request Tlv type %d from block 0x%X.
 *   Tlv type %d has not been found.
 *   Tlv type %d found at 0x%X and removed, block size now is %d.
 * Зовут его: remove_app_ie
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, app_ie__walk_list, fw_log_emit1, fw_log_emit2, fw_log_emit3, ie_iter__init, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global app_ie__remove_tlv
app_ie__remove_tlv:
	.global L_8e255c
L_8e255c:
	push_s blink
L_8e255e:
	bl L_8c01dc
L_8e2562:
	sub_s sp,sp,0xc
L_8e2564:
	mov_s r15,r0
L_8e2566:
	mov_s r14,r1
L_8e2568:
	mov_s r1,0x1010edc
L_8e256e:
	mov_s r0,0x2d
L_8e2570:
	mov_s r2,r14
L_8e2572:
	bl.d L_8dcc80
L_8e2576:
	ld_s r3,[r15]
L_8e2578:
	mov_s r0,sp
L_8e257a:
	mov_s r4,r0
L_8e257c:
	bl.d L_8e5de8
L_8e2580:
	mov_s r1,r15
L_8e2582:
	bl.d L_8df404
L_8e2586:
	mov_s r0,r4
L_8e2588:
	mov.f r13,r0
L_8e258c:
	bne_s L_8e259e
L_8e258e:
	b_s L_8e25f8
	.global L_8e2590
L_8e2590:
	ldb_s r0,[r13]
L_8e2592:
	brge r0,r14,L_8e25a2
L_8e2596:
	bl.d L_8df404
L_8e259a:
	mov_s r0,r4
L_8e259c:
	mov_s r13,r0
	.global L_8e259e
L_8e259e:
	brne_s r13,0,L_8e2590
L_8e25a0:
	b_s L_8e25f8
	.global L_8e25a2
L_8e25a2:
	brge r14,r0,L_8e25b6
L_8e25a6:
	mov_s r1,0x1010f08
L_8e25ac:
	mov_s r0,0x2d
L_8e25ae:
	bl.d L_8dcc10
L_8e25b2:
	mov_s r2,r14
L_8e25b4:
	b_s L_8e25f8
	.global L_8e25b6
L_8e25b6:
	ldb_s r0,[r13,0x1]
L_8e25b8:
	ldw_s r2,[r15,0x4]
L_8e25ba:
	add r16,r0,0x2
L_8e25be:
	ld_s r0,[r15]
L_8e25c0:
	extw r16,r16
L_8e25c4:
	sub r1,r13,r0
L_8e25c8:
	sub_s r2,r2,r1
L_8e25ca:
	sub r2,r2,r16
L_8e25ce:
	extw_s r2,r2
L_8e25d0:
	add r1,r13,r16
L_8e25d4:
	bl.d L_8c0380
L_8e25d8:
	mov_s r0,r13
L_8e25da:
	ldw_s r0,[r15,0x4]
L_8e25dc:
	mov_s r1,0x1010f28
L_8e25e2:
	sub r4,r0,r16
L_8e25e6:
	extw r4,r4
L_8e25ea:
	stw r4,[r15, 0x4]
L_8e25ee:
	mov_s r0,0x2d
L_8e25f0:
	mov_s r2,r14
L_8e25f2:
	bl.d L_8dcd00
L_8e25f6:
	mov_s r3,r13
	.global L_8e25f8
L_8e25f8:
	b.d L_8c0244
L_8e25fc:
	add_s sp,sp,0xc
L_8e25fe:
	nop_s
