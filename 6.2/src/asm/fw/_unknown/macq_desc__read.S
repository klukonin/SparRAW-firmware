/* macq_desc__read @ 0x8c50f8, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, buf30__prepare_and_call_8c50f8, l2mgr__data_port_open_and_keys, macq_desc__read_t1_w0_n2, macq_desc__read_t1_w2_n1, macq_desc__read_t1_w3_n3, qh__write_by_flags_fw, tx_macq__is_empty, vring__program_macq_and_ba
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s0_w2, bits__set32_s2_w2, bits__set32_s4_w3, bits__set32_s4_w5, macq_desc__release_window, macq_desc__wait_window_free
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read
macq_desc__read:
	.global L_8c50f8
L_8c50f8:
	push_s blink
L_8c50fa:
	bl.d L_8c01dc
L_8c50fe:
	mov_s r5,r0
L_8c5100:
	sub_s sp,sp,0x8
L_8c5102:
	mov_s r14,r1
L_8c5104:
	mov_s r15,r3
L_8c5106:
	mov_s r13,0x0
L_8c5108:
	stw r13,[sp, 0x4]
L_8c510c:
	stw r13,[sp, 0x6]
L_8c5110:
	bmsk r1,r2,0x2
L_8c5114:
	add_s r0,sp,0x4
L_8c5116:
	bl.d L_8ed514
L_8c511a:
	st_s r13,[sp,0x0]
L_8c511c:
	mov_s r1,r13
L_8c511e:
	bl.d L_8ed358
L_8c5122:
	mov_s r3,r4
L_8c5124:
	bmsk r1,r15,0x1
L_8c5128:
	mov_s r0,sp
L_8c512a:
	bl L_8ed4cc
L_8c512e:
	bmsk r1,r14,0x4
L_8c5132:
	bl L_8ed52c
L_8c5136:
	bl L_8c50e4
L_8c513a:
	ldw r0,[sp, 0x4]
L_8c513e:
	mov_s r2,0x886600
L_8c5144:
	asl_s r0,r0,0x10
L_8c5146:
	st_s r0,[r2,0xc]
L_8c5148:
	brlo r3,0x1,L_8c51b6
L_8c514c:
	mov_s r14,r5
	.global L_8c514e
L_8c514e:
	bmsk r1,r13,0x1
L_8c5152:
	mov_s r0,sp
L_8c5154:
	bl.d L_8ed358
L_8c5158:
	mov_s r16,r3
L_8c515a:
	ld_s r0,[sp,0x0]
L_8c515c:
	st_s r0,[r2,0x10]
L_8c515e:
	ldb_s r0,[gp,0xb2]
L_8c5160:
	brne_s r0,0,L_8c516c
L_8c5162:
	st 0xc0000000,[r2, 0x8]
L_8c516a:
	b_s L_8c5174
	.global L_8c516c
L_8c516c:
	st 0x40000000,[r2, 0x8]
	.global L_8c5174
L_8c5174:
	sync
	.global L_8c5178
L_8c5178:
	mov_s r2,0x886600
L_8c517e:
	ld_s r0,[r2,0x8]
L_8c5180:
	bbit1 r0,0x1d,L_8c5178
L_8c5184:
	cmp_s r15,0x2
L_8c5186:
	mov_s r0,0x1
L_8c5188:
	sub.eq r0,r0,r0
L_8c518c:
	mov_s r1,0x2
L_8c518e:
	add1_s r1,r1,r0
L_8c5190:
	mov_s r0,0x0
L_8c5192:
	cmp_s r1,0x0
L_8c5194:
	mov.hi lp_count,r1
L_8c5198:
	lphi L_8c51ac
L_8c519c:
	mov_s r1,0x886614
L_8c51a2:
	ld.as r1,[r1,r0]
L_8c51a6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c51a8:
	st.ab r1,[r14,0x4]
	.global L_8c51ac
L_8c51ac:
	sub r3,r16,0x1
L_8c51b0:
	/* brhs.d r3,0x1,0x008c514e */
	.byte 0x9f,0x0b,0x75,0x80
L_8c51b4:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c51b6
L_8c51b6:
	bl L_8c5238
L_8c51ba:
	b.d L_8c0244
L_8c51be:
	add_s sp,sp,0x8
