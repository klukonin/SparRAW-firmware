/* macq_hw__disable_queue @ 0x9292a8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mask__bit_from_index_plus8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__disable_queue
macq_hw__disable_queue:
	.global L_9292a8
L_9292a8:
	st.a r13,[sp,-0x8]
L_9292ac:
	st_s r14,[sp,0x4]
L_9292ae:
	mov_s r14,blink
L_9292b0:
	mov_s r13,r0
L_9292b2:
	asl_s r1,r0,0x3
L_9292b4:
	sub_s r1,r1,r0
L_9292b6:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_9292b8:
	add_s r1,r1,0x44099c0
L_9292be:
	lsr r4,r1,0x3
L_9292c2:
	bic r7,r4,0x3
L_9292c6:
	ld r3,[r7]
L_9292ca:
	bmsk_s r1,r1,0x4
L_9292cc:
	bclr r3,r3,r1
L_9292d0:
	st r3,[r7]
L_9292d4:
	sync
L_9292d8:
	asl_s r0,r13,0x3
L_9292da:
	sub_s r0,r0,r13
L_9292dc:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_9292de:
	add_s r0,r0,0x44096c4
L_9292e4:
	lsr r5,r0,0x3
L_9292e8:
	bic r6,r5,0x3
L_9292ec:
	ld r2,[r6]
L_9292f0:
	bmsk r0,r0,0x4
L_9292f4:
	bclr r2,r2,r0
L_9292f8:
	st r2,[r6]
L_9292fc:
	sync
L_929300:
	mov_s blink,r14
L_929302:
	ld_s r14,[sp,0x4]
L_929304:
	j.d [blink]
L_929308:
	ld.ab r13,[sp,0x8]
