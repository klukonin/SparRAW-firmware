/* aw__foreach_awake_peer @ 0x9251d4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers
 * Глобалы (через gp): 0x800574
 */
	.section .text.aw__foreach_awake_peer,"ax",@progbits
	.global aw__foreach_awake_peer
aw__foreach_awake_peer:
	.global L_9251d4
L_9251d4:
	push_s r13
L_9251d6:
	mov_s r1,r0
L_9251d8:
	b_s L_925200
	.global L_9251da
L_9251da:
	norm r0,r1
L_9251de:
	rsub r2,r0,0x1e
L_9251e2:
	extb_s r2,r2
L_9251e4:
	mov_s r3,0x0
L_9251e6:
	ld_s r0,[gp,0x4c]
L_9251e8:
	bset r3,r3,r2
L_9251ec:
	and_s r0,r0,r3
L_9251ee:
	mov_s r13,0x857180
L_9251f4:
	ld_s r3,[r13,0x5c]
L_9251f6:
	bclr r1,r1,r2
L_9251fa:
	or_s r3,r3,r0
L_9251fc:
	st_s r3,[r13,0x5c]
L_9251fe:
	extb_s r1,r1
	.global L_925200
L_925200:
	brne_s r1,0,L_9251da
L_925202:
	j_s.d [blink]
L_925204:
	pop_s r13
L_925206:
	nop_s
