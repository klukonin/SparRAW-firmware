/* sta__queue_class @ 0x927a00, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__pick_slot_for_peer
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__queue_class
sta__queue_class:
	.global L_927a00
L_927a00:
	push_s r13
L_927a02:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_927a04:
	add2_s r0,r0,r0
L_927a06:
	add_s r0,r0,0x801104
L_927a0c:
	ld_s r13,[r0,0x14]
L_927a0e:
	mov_s r3,0x0
L_927a10:
	bset r3,r3,r1
L_927a14:
	tst_s r3,r13
L_927a16:
	mov_s r2,0x1
L_927a18:
	sub_s.ne r0,r0,r0
L_927a1a:
	bne_s L_927a30
L_927a1c:
	ld_s r1,[r0,0x1c]
L_927a1e:
	tst_s r1,r3
L_927a20:
	mov.ne r0,r2
L_927a24:
	bne_s L_927a30
L_927a26:
	ld_s r0,[r0,0x18]
L_927a28:
	tst_s r0,r3
L_927a2a:
	mov_s r0,0x2
L_927a2c:
	mov.eq r0,0x3
	.global L_927a30
L_927a30:
	j_s.d [blink]
L_927a32:
	pop_s r13
