/* qh__build_descriptor_b @ 0x92d400, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__read_slot_id, peer_masks__or_into_8571c4
 * Зовёт сам: qh__read_desc_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__build_descriptor_b
qh__build_descriptor_b:
	.global L_92d400
L_92d400:
	push_s r13
L_92d402:
	sub_s sp,sp,0x30
L_92d404:
	mov_s r13,blink
L_92d406:
	mov_s r1,r0
L_92d408:
	mov_s r0,sp
L_92d40a:
	mov_s r2,0x2
L_92d40c:
	mov r3,0x3
L_92d410:
	bl.d L_92449c
L_92d414:
	mov r4,0x1
L_92d418:
	ld_s r0,[sp,0x4]
L_92d41a:
	mov_s blink,r13
L_92d41c:
	bmsk_s r0,r0,0xb
L_92d41e:
	add_s sp,sp,0x30
L_92d420:
	j.d [blink]
L_92d424:
	pop_s r13
L_92d426:
	nop_s
