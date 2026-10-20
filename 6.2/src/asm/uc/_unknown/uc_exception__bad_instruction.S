/* uc_exception__bad_instruction @ 0x920484, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4, rx_resp__finish_restore_rx
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_exception__bad_instruction
uc_exception__bad_instruction:
	.global L_920484
L_920484:
	mov_s r12,r0
L_920486:
	mov_s r0,0x0
L_920488:
	mulu64 r2,r1
L_92048c:
	mov_s r1,mlo
L_92048e:
	mulu64 r2,r12
L_920492:
	add.f r0,r0,mlo
L_920496:
	adc r1,r1,mhi
L_92049a:
	mulu64 r3,r12
L_92049e:
	j_s.d [blink]
L_9204a0:
	add_s r1,r1,mlo
L_9204a2:
	nop_s
L_9204a4:
	mov.f 0x0,r0
L_9204a8:
	mov r0,-0x2
L_9204ac:
	mov.mi r0,0x1
L_9204b0:
	j_s.d [blink]
L_9204b2:
	ror r0,r0
L_9204b6:
	j_s.d [blink]
L_9204b8:
	mov r0,-0x1
