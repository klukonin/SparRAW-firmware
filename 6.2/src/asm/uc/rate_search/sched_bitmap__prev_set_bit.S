/* sched_bitmap__prev_set_bit @ 0x92ffec, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rs_start
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sched_bitmap__prev_set_bit
sched_bitmap__prev_set_bit:
	.global L_92ffec
L_92ffec:
	push_s r13
L_92ffee:
	b_s L_930010
	.global L_92fff0
L_92fff0:
	mul64 r0,0x26
L_92fff4:
	mov_s r13,0x8027f2
L_92fffa:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_92fffc:
	add r10,r13,mlo
L_930000:
	ldw r2,[r10, 0x2]
L_930004:
	ldw r3,[r13,mlo]
L_930008:
	asl_s r2,r2,0x10
L_93000a:
	or_s r3,r3,r2
L_93000c:
	bbit1 r3,r1,L_930012
	.global L_930010
L_930010:
	brne_s r1,0,L_92fff0
	.global L_930012
L_930012:
	mov_s r0,r1
L_930014:
	j_s.d [blink]
L_930016:
	pop_s r13
