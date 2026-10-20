/* bi_window_transition_prep @ 0x9370b8, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon_if__trigger_bhi, bi_ap_mon_if__trigger_bhi_to_dti
 * Зовёт сам: memcpy_uc, memset0_words_uc, uc_read_tsf_lo, uc_send_evt__mac_monitor
 */
	.section .text.bi_window_transition_prep,"ax",@progbits
	.global bi_window_transition_prep
bi_window_transition_prep:
	.global L_9370b8
L_9370b8:
	st.a r13,[sp,-0x1c]
L_9370bc:
	st blink,[sp, 0x4]
L_9370c0:
	st_s r14,[sp,0x8]
L_9370c2:
	st_s r15,[sp,0xc]
L_9370c4:
	ld.as r3,[gp,-0xb]
L_9370c8:
	st r17,[sp, 0x14]
L_9370cc:
	cmp r3,0x1
L_9370d0:
	st r16,[sp, 0x10]
L_9370d4:
	bne.d L_93721c
L_9370d8:
	st r18,[sp, 0x18]
L_9370dc:
	bl.d L_9315e8
L_9370e0:
	mov r13,0x0
L_9370e4:
	mov_s r18,r0
L_9370e6:
	mov r6,0x80063c
L_9370ee:
	mov_s r15,0x80088c
L_9370f4:
	ldb r14,[r15, 0x91]
L_9370f8:
	mov lp_count,0x8
L_9370fc:
	mov r0,r13
L_937100:
	lp L_937144
L_937104:
	add r1,r6,r0
L_937108:
	ldb r5,[r1, 0x8]
L_93710c:
	breq r5,0x0,L_937118
L_937110:
	b.d L_93713c
L_937114:
	stb r13,[r1, 0x10]
	.global L_937118
L_937118:
	ldb r4,[r1]
L_93711c:
	breq r4,0x0,L_93713c
L_937120:
	ldb_s r2,[r1,0x10]
L_937122:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_937124:
	extb r2,r2
L_937128:
	brlt.d r2,0xb,L_93713c
L_93712c:
	stb_s r2,[r1,0x10]
L_93712e:
	bset r3,r14,r0
L_937132:
	extb_s r14,r3
L_937134:
	stb r3,[r15, 0x91]
L_937138:
	stb r13,[r1, 0x10]
	.global L_93713c
L_93713c:
	stb_s r13,[r1,0x8]
L_93713e:
	stb_s r13,[r1]
L_937140:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_937142:
	extb_s r0,r0
	.global L_937144
L_937144:
	ldb r1,[r15, 0x50]
L_937148:
	mov r16,0x1
L_93714c:
	cmp_s r1,0x0
L_93714e:
	sub.ne r16,r16,r16
L_937152:
	asl r16,r16,0x3
L_937156:
	add2 r16,r16,r16
L_93715a:
	ld.a r11,[r16,r15]
L_93715e:
	mov_s r0,0x854de0
L_937164:
	ld r10,[r16, 0x4]
L_937168:
	add2 r1,r15,0x15
L_93716c:
	ld r9,[r16, 0x8]
L_937170:
	mov r17,0x7c
L_937174:
	ld r8,[r16, 0xc]
L_937178:
	st r11,[r15, 0x58]
L_93717c:
	st r10,[r15, 0x5c]
L_937180:
	st r9,[r15, 0x60]
L_937184:
	st r8,[r15, 0x64]
L_937188:
	ld r11,[r16, 0x10]
L_93718c:
	ld r10,[r16, 0x14]
L_937190:
	ld r9,[r16, 0x18]
L_937194:
	ld r8,[r16, 0x1c]
L_937198:
	st r11,[r15, 0x68]
L_93719c:
	st r10,[r15, 0x6c]
L_9371a0:
	st r9,[r15, 0x70]
L_9371a4:
	st r8,[r15, 0x74]
L_9371a8:
	ld r11,[r16, 0x20]
L_9371ac:
	ld r10,[r16, 0x24]
L_9371b0:
	st r11,[r15, 0x78]
L_9371b4:
	st r10,[r15, 0x7c]
L_9371b8:
	bl.d L_920310
L_9371bc:
	mov r2,r17
L_9371c0:
	mov r0,r16
L_9371c4:
	bl.d L_92166c
L_9371c8:
	mov r1,0x28
L_9371cc:
	add2 r0,r15,0x15
L_9371d0:
	bl.d L_92166c
L_9371d4:
	mov r1,r17
L_9371d8:
	st r17,[r15, 0x54]
L_9371dc:
	stb r13,[r16, 0x26]
L_9371e0:
	stb r13,[r16, 0x14]
L_9371e4:
	mov r4,-0x100
L_9371e8:
	st r4,[r16, 0x18]
L_9371ec:
	stb r13,[r16, 0x1c]
L_9371f0:
	st r4,[r16, 0x20]
L_9371f4:
	ld r2,[0x854e2c]
L_9371fc:
	stb r14,[r15, 0x91]
L_937200:
	st.as r2,[gp,-0x25]
L_937204:
	bl.d L_925b84
L_937208:
	mov r0,0x1
L_93720c:
	bl.d L_9315e8
L_937210:
	st.as r13,[gp,-0xb]
L_937214:
	sub r0,r0,r18
L_937218:
	st r0,[r15, 0xc0]
	.global L_93721c
L_93721c:
	ld blink,[sp, 0x4]
L_937220:
	ld_s r14,[sp,0x8]
L_937222:
	ld_s r15,[sp,0xc]
L_937224:
	ld r16,[sp, 0x10]
L_937228:
	ld r17,[sp, 0x14]
L_93722c:
	ld r18,[sp, 0x18]
L_937230:
	j.d [blink]
L_937234:
	ld.ab r13,[sp,0x1c]
