/* sls__build_ssw_ack @ 0x93b220, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sls__send_ssw_ack
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set_u8_s0_w5_uc, bits__uc_set32_s4_w4, sls__bits_uc_set32_s2_w2, sls__bits_uc_set32_s8_w4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sls__build_ssw_ack
sls__build_ssw_ack:
	.global L_93b220
L_93b220:
	push_s blink
L_93b222:
	bl.d L_920234
L_93b226:
	mov_s r3,r1
L_93b228:
	mov_s r14,0x0
L_93b22a:
	mov_s r1,0x1
L_93b22c:
	bl.d L_93e3d8
L_93b230:
	stw_s r14,[r0]
L_93b232:
	mov_s r1,0x6
L_93b234:
	bl.d L_93e3f0
L_93b238:
	mov_s r13,r0
L_93b23a:
	mov_s r1,0xa
L_93b23c:
	bl.d L_93e420
L_93b240:
	cmp_s r2,0x1
L_93b242:
	bne_s L_93b25a
L_93b244:
	mul64 r3,0x3c
L_93b248:
	add r0,mlo,0x857c1c
L_93b250:
	ldb_s r1,[r0]
L_93b252:
	ldb_s r0,[r0,0x1]
L_93b254:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_93b256:
	or_s r0,r0,r1
L_93b258:
	b_s L_93b268
	.global L_93b25a
L_93b25a:
	mov_s r1,0x80212c
L_93b260:
	ldb_s r0,[r1]
L_93b262:
	ldb_s r1,[r1,0x1]
L_93b264:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_93b266:
	or_s r0,r0,r1
	.global L_93b268
L_93b268:
	stb_s r0,[r13,0x10]
L_93b26a:
	mov_s r0,0x80212c
L_93b270:
	ld_s r1,[r0,0x8]
L_93b272:
	stb_s r14,[r13,0x12]
L_93b274:
	sub_s r1,r1,0x13
L_93b276:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_93b278:
	stb_s r1,[r13,0x11]
L_93b27a:
	mov_s r1,r14
L_93b27c:
	stb_s r1,[r13,0x13]
L_93b27e:
	lsr_s r1,r1,0x8
L_93b280:
	stb_s r1,[r13,0x14]
L_93b282:
	lsr_s r1,r1,0x8
L_93b284:
	stb_s r1,[r13,0x15]
L_93b286:
	lsr_s r1,r1,0x8
L_93b288:
	stb_s r1,[r13,0x16]
L_93b28a:
	ldb r0,[r0, 0x68]
L_93b28e:
	bbit0 r0,r3,L_93b29c
L_93b292:
	add r0,r13,0x13
L_93b296:
	mov_s r1,0x10
L_93b298:
	bl L_93e348
	.global L_93b29c
L_93b29c:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_93b29e:
	add2_s r3,r3,r3
L_93b2a0:
	stb_s r14,[r13,0x17]
L_93b2a2:
	add_s r3,r3,0x801104
L_93b2a8:
	ldw_s r0,[r3,0x30]
L_93b2aa:
	stw_s r0,[r13,0x4]
L_93b2ac:
	ldw_s r0,[r3,0x32]
L_93b2ae:
	stw_s r0,[r13,0x6]
L_93b2b0:
	ldw_s r0,[r3,0x34]
L_93b2b2:
	b.d L_9202a4
L_93b2b6:
	stw_s r0,[r13,0x8]
