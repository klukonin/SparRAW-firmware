/* mac__program_886e0c_20b @ 0x92f1a0, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd__apply_mac_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac__build_qset_mask, mac__replicate_bit_mask
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_886e0c_20b
mac__program_886e0c_20b:
	.global L_92f1a0
L_92f1a0:
	push_s blink
L_92f1a2:
	bl L_920230
L_92f1a6:
	sub_s sp,sp,0x8
L_92f1a8:
	bl.d L_92f738
L_92f1ac:
	mov_s r13,r0
L_92f1ae:
	st_s r0,[sp,0x0]
L_92f1b0:
	bl.d L_92f400
L_92f1b4:
	mov_s r0,r13
L_92f1b6:
	st_s r0,[sp,0x4]
L_92f1b8:
	ldb_s r14,[r13,0x1]
L_92f1ba:
	mov_s r15,0x886e00
L_92f1c0:
	ldb_s r3,[r13]
L_92f1c2:
	asl_s r14,r14,0x18
L_92f1c4:
	ldb_s r1,[r13,0x5]
L_92f1c6:
	asl_s r3,r3,0x10
L_92f1c8:
	ldb_s r2,[r13,0x4]
L_92f1ca:
	or_s r3,r3,r14
L_92f1cc:
	ldb_s r0,[r13,0x3]
L_92f1ce:
	asl_s r1,r1,0x8
L_92f1d0:
	ldb r4,[r13, 0x6]
L_92f1d4:
	or_s r2,r2,r3
L_92f1d6:
	ldb r5,[r13, 0x8]
L_92f1da:
	or_s r1,r1,r2
L_92f1dc:
	ldb r6,[r13, 0x2]
L_92f1e0:
	asl_s r0,r0,0x8
L_92f1e2:
	ldb r7,[r13, 0x7]
L_92f1e6:
	ldb r9,[r13, 0x9]
L_92f1ea:
	asl r2,r7,0x18
L_92f1ee:
	ldb r8,[r13, 0xb]
L_92f1f2:
	ldb r10,[r13, 0xa]
L_92f1f6:
	st_s r1,[r15,0x8]
L_92f1f8:
	asl r1,r4,0x10
L_92f1fc:
	or_s r1,r1,r2
L_92f1fe:
	or r1,r1,r6
L_92f202:
	or_s r0,r0,r1
L_92f204:
	st_s r0,[r15,0xc]
L_92f206:
	asl r0,r9,0x8
L_92f20a:
	or r0,r0,r5
L_92f20e:
	asl r1,r10,0x10
L_92f212:
	or_s r0,r0,r1
L_92f214:
	asl r1,r8,0x18
L_92f218:
	or_s r0,r0,r1
L_92f21a:
	st_s r0,[r15,0x10]
L_92f21c:
	ldb_s r2,[r13,0xd]
L_92f21e:
	ldb_s r0,[r13,0x12]
L_92f220:
	asl_s r2,r2,0x8
L_92f222:
	ldb_s r3,[r13,0xc]
L_92f224:
	asl_s r0,r0,0x10
L_92f226:
	ldb_s r14,[r13,0xf]
L_92f228:
	or_s r3,r3,r2
L_92f22a:
	ldb_s r1,[r13,0x11]
L_92f22c:
	or_s r3,r3,r0
L_92f22e:
	ldb r4,[r13, 0x13]
L_92f232:
	asl_s r14,r14,0x8
L_92f234:
	ldb r5,[r13, 0xe]
L_92f238:
	asl r0,r4,0x18
L_92f23c:
	ldb_s r13,[r13,0x10]
L_92f23e:
	or r14,r14,r5
L_92f242:
	asl_s r13,r13,0x10
L_92f244:
	or_s r0,r0,r3
L_92f246:
	asl_s r1,r1,0x18
L_92f248:
	or_s r14,r14,r13
L_92f24a:
	st_s r0,[r15,0x14]
L_92f24c:
	or_s r1,r1,r14
L_92f24e:
	st_s r1,[r15,0x18]
L_92f250:
	ld_s r0,[sp,0x0]
L_92f252:
	or r0,r0,0x35000000
L_92f25a:
	mov_s r32,r0
L_92f25c:
	st.ab r0,[r25,0x4]
L_92f260:
	bclr r25,r25,0xa
L_92f264:
	ld_s r0,[sp,0x4]
L_92f266:
	or r0,r0,0x39000000
L_92f26e:
	mov_s r32,r0
L_92f270:
	st.ab r0,[r25,0x4]
L_92f274:
	bclr r25,r25,0xa
L_92f278:
	mov_s r0,0x38000200
L_92f27e:
	mov_s r32,r0
L_92f280:
	st.ab r0,[r25,0x4]
L_92f284:
	bclr r25,r25,0xa
L_92f288:
	mov_s r0,0x3c000200
L_92f28e:
	mov_s r32,r0
L_92f290:
	st.ab r0,[r25,0x4]
L_92f294:
	bclr r25,r25,0xa
L_92f298:
	mov_s r0,0x886e00
L_92f29e:
	st 0xbe41190,[r0, 0x1c]
L_92f2a6:
	mov_s r0,0x4e00000d
L_92f2ac:
	mov_s r32,r0
L_92f2ae:
	st.ab r0,[r25,0x4]
L_92f2b2:
	bclr r25,r25,0xa
L_92f2b6:
	b.d L_92029c
L_92f2ba:
	add_s sp,sp,0x8
