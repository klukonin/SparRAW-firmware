/* brp__slot_has_peer_bit @ 0x925e70, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__pick_slot_for_peer
 */
	.section .text.brp__slot_has_peer_bit,"ax",@progbits
	.global brp__slot_has_peer_bit
brp__slot_has_peer_bit:
	.global L_925e70
L_925e70:
	push_s r13
L_925e72:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_925e74:
	add3_s r0,r0,r0
L_925e76:
	add_s r0,r0,0x801190
L_925e7c:
	ld_s r13,[r0,0x10]
L_925e7e:
	mov_s r3,0x0
L_925e80:
	bset r3,r3,r1
L_925e84:
	tst_s r3,r13
L_925e86:
	mov_s r2,0x1
L_925e88:
	sub_s.ne r0,r0,r0
L_925e8a:
	bne_s L_925ea0
L_925e8c:
	ld_s r1,[r0,0x18]
L_925e8e:
	tst_s r1,r3
L_925e90:
	mov.ne r0,r2
L_925e94:
	bne_s L_925ea0
L_925e96:
	ld_s r0,[r0,0x14]
L_925e98:
	tst_s r0,r3
L_925e9a:
	mov_s r0,0x2
L_925e9c:
	mov.eq r0,0x3
	.global L_925ea0
L_925ea0:
	j_s.d [blink]
L_925ea2:
	pop_s r13
