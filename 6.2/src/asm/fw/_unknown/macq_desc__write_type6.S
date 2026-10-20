/* macq_desc__write_type6 @ 0x8c51c0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__zero_and_program
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s0_w2, bits__set32_s4_w3, macq_desc__release_window, macq_desc__wait_window_free
 * Глобалы (через gp): 0x800236
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__write_type6
macq_desc__write_type6:
	.global L_8c51c0
L_8c51c0:
	push_s blink
L_8c51c2:
	push_s r13
L_8c51c4:
	sub_s sp,sp,0x8
L_8c51c6:
	mov_s r2,r0
L_8c51c8:
	mov_s r13,r1
L_8c51ca:
	mov_s r3,0x0
L_8c51cc:
	add_s r0,sp,0x4
L_8c51ce:
	mov_s r1,r3
L_8c51d0:
	bl L_8ed358
L_8c51d4:
	mov_s r1,0x6
L_8c51d6:
	bl L_8ed514
L_8c51da:
	bl L_8c50e4
L_8c51de:
	ldw r0,[sp, 0x4]
L_8c51e2:
	mov_s r1,0x886600
L_8c51e8:
	asl_s r0,r0,0x10
L_8c51ea:
	bset_s r0,r0,0x1f
L_8c51ec:
	st_s r0,[r1,0xc]
L_8c51ee:
	st_s r13,[r1,0x10]
L_8c51f0:
	mov lp_count,0x4
L_8c51f4:
	lp L_8c5208
L_8c51f8:
	mov_s r13,0x886614
L_8c51fe:
	ld.ab r0,[r2,0x4]
L_8c5202:
	add2_s r13,r13,r3
L_8c5204:
	st_s r0,[r13]
L_8c5206:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c5208
L_8c5208:
	ldb_s r0,[gp,0xb2]
L_8c520a:
	brne_s r0,0,L_8c5216
L_8c520c:
	st 0xc0000000,[r1, 0x8]
L_8c5214:
	b_s L_8c521e
	.global L_8c5216
L_8c5216:
	st 0x40000000,[r1, 0x8]
	.global L_8c521e
L_8c521e:
	sync
	.global L_8c5222
L_8c5222:
	mov_s r0,0x886600
L_8c5228:
	ld_s r0,[r0,0x8]
L_8c522a:
	bbit1 r0,0x1d,L_8c5222
L_8c522e:
	bl L_8c5238
L_8c5232:
	b.d L_8c025c
L_8c5236:
	add_s sp,sp,0x8
