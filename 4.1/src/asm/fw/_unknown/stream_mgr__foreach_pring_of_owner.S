/* stream_mgr__foreach_pring_of_owner @ 0x8e5484, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_key_to_prings, l2mgr__notify_key_ready
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ut_hw_cmd_0x008
 */
	.section .text.stream_mgr__foreach_pring_of_owner,"ax",@progbits
	.global stream_mgr__foreach_pring_of_owner
stream_mgr__foreach_pring_of_owner:
	.global L_8e5484
L_8e5484:
	push_s blink
L_8e5486:
	bl L_8c02c0
L_8e548a:
	mov_s r13,r0
L_8e548c:
	mov_s r15,r1
L_8e548e:
	mov_s r14,0x0
L_8e5490:
	b_s L_8e54c0
	.global L_8e5492
L_8e5492:
	mov_s r0,0x8485dc
L_8e5498:
	sub3 r0,r0,0x100
L_8e549c:
	add2_s r0,r0,r14
L_8e549e:
	ld r0,[r0,0x818]
L_8e54a6:
	breq_s r0,0,L_8e54be
L_8e54a8:
	ld_s r1,[r0]
L_8e54aa:
	brne r13,r1,L_8e54be
L_8e54ae:
	ldb_s r1,[r0,0x7]
L_8e54b0:
	breq r1,0x9,L_8e54be
L_8e54b4:
	mov_s r1,r15
L_8e54b6:
	bl.d L_8e59d8
L_8e54ba:
	ldb r2,[r13, 0x34]
	.global L_8e54be
L_8e54be:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e54c0
L_8e54c0:
	brlo r14,0xa,L_8e5492
L_8e54c4:
	b L_8c032c
