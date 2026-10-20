/* vring__on_macq_delete_ntf @ 0x8e3148, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VRING %d received TX MACQ delete notification
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, hwd_dma__kick_macq, mac_indirect__write_entry, mac_parser__clear_rule, mid__conn_state_ne_1, sw_vring__setup_macq, vring__get_pring_id, vring__wait_drain, vring__write_macq_desc, vring_by_index
 * Глобалы (через gp): 0x800294
 */
	.section .text.vring__on_macq_delete_ntf,"ax",@progbits
	.global vring__on_macq_delete_ntf
vring__on_macq_delete_ntf:
L_8e3148:
	push_s blink
L_8e314a:
	bl.d L_8c02b8
L_8e314e:
	mov_s r1,0x2
L_8e3150:
	sub_s sp,sp,0x8
L_8e3152:
	mov_s r14,r0
L_8e3154:
	mov_s r2,0x100f0f4
L_8e315a:
	bl.d L_8edfb0
L_8e315e:
	mov_s r0,0xb
L_8e3160:
	bl.d L_8c7904
L_8e3164:
	ldb_s r0,[r14,0x7]
L_8e3166:
	bl.d L_8cdfe4
L_8e316a:
	ldb_s r0,[r14,0x7]
L_8e316c:
	bl.d L_8cacc0
L_8e3170:
	ldb_s r0,[r14,0x7]
L_8e3172:
	mov_s r16,r0
L_8e3174:
	bl.d L_8c9d94
L_8e3178:
	mov_s r0,r14
L_8e317a:
	extb r17,r0
L_8e317e:
	ld_s r0,[r14,0xc]
L_8e3180:
	cmp_s r0,0x0
L_8e3182:
	mov_s r0,0x0
L_8e3184:
	bne_s L_8e318c
L_8e3186:
	bl.d L_8ed820
L_8e318a:
	ld_s r0,[r14]
	.global L_8e318c
L_8e318c:
	mov_s r6,r0
L_8e318e:
	ldw r5,[r14, 0xc8]
L_8e3192:
	mov_s r0,r16
L_8e3194:
	mov_s r1,0x5
L_8e3196:
	ldb_s r2,[r14,0x4]
L_8e3198:
	mov_s r13,0x0
L_8e319a:
	mov_s r3,r13
L_8e319c:
	bl.d L_8e5304
L_8e31a0:
	mov r4,r17
L_8e31a4:
	mov_s r0,r16
L_8e31a6:
	bl.d L_8de670
L_8e31aa:
	mov_s r1,0x40
L_8e31ac:
	ld_s r0,[gp,0x124]
L_8e31ae:
	brne r0,0x0,L_8e321a
L_8e31b2:
	stw r13,[r14, 0xc8]
L_8e31b6:
	bl.d L_8ca828
L_8e31ba:
	mov_s r0,0x2
L_8e31bc:
	mov_s r16,r0
	.global L_8e31be
L_8e31be:
	mov_s r0,0x886e80
L_8e31c4:
	ld_s r13,[r0,0x4c]
L_8e31c6:
	mov_s r0,0xa0
L_8e31c8:
	mov lp_count,r0
L_8e31cc:
	nop_s
L_8e31ce:
	lp L_8e31d6
L_8e31d2:
	nop_s
L_8e31d4:
	nop_s
	.global L_8e31d6
L_8e31d6:
	bbit1 r13,0x3,L_8e31be
L_8e31da:
	ld_s r0,[r14]
L_8e31dc:
	mov_s r13,sp
L_8e31de:
	ldb_s r0,[r0,0x8]
L_8e31e0:
	bl.d L_8dba18
L_8e31e4:
	ldb_s r1,[r14,0x4]
L_8e31e6:
	bl.d L_8c3c14
L_8e31ea:
	mov_s r0,r16
L_8e31ec:
	mov_s r0,r13
L_8e31ee:
	mov_s r1,0x2
L_8e31f0:
	mov_s r2,0x1
L_8e31f2:
	mov_s r3,r1
L_8e31f4:
	bl.d L_8c4768
L_8e31f8:
	mov_s r4,r2
L_8e31fa:
	ld_s r0,[sp,0x0]
L_8e31fc:
	mov_s r1,0x2
L_8e31fe:
	bset_s r0,r0,0x12
L_8e3200:
	st_s r0,[sp,0x0]
L_8e3202:
	mov_s r0,r13
L_8e3204:
	mov_s r2,0x1
L_8e3206:
	mov_s r3,r1
L_8e3208:
	mov r4,0x0
L_8e320c:
	mov r5,r4
L_8e3210:
	mov r6,r4
L_8e3214:
	bl.d L_8c46a4
L_8e3218:
	mov_s r7,r2
	.global L_8e321a
L_8e321a:
	b.d L_8c031c
L_8e321e:
	add_s sp,sp,0x8
