/* u_schd__tick @ 0x8d756c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_u_schd__tick
 * Зовёт сам: __ld_r13_ret, u_schd__arm_timer, u_schd__run_expired
 */
	.section .text.u_schd__tick,"ax",@progbits
	.global u_schd__tick
u_schd__tick:
	.global L_8d756c
L_8d756c:
	push_s blink
L_8d756e:
	push_s r13
L_8d7570:
	mov_s r13,0x0
L_8d7572:
	b_s L_8d7576
	.global L_8d7574
L_8d7574:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8d7576
L_8d7576:
	brge r13,0x2,L_8d759e
	.global L_8d757a
L_8d757a:
	mov_s r0,0x8034a8
L_8d7580:
	ld.as r0,[r0,r13]
L_8d7584:
	ld_s r0,[r0]
L_8d7586:
	sub.f r0,r0,0x0
L_8d758a:
	mov.ne r0,0x1
L_8d758e:
	extb.f 0x0,r0
L_8d7592:
	beq_s L_8d7574
L_8d7594:
	bl.d L_8c55c4
L_8d7598:
	mov_s r0,r13
L_8d759a:
	brne_s r0,0,L_8d757a
L_8d759c:
	b_s L_8d7574
	.global L_8d759e
L_8d759e:
	bl L_8de094
L_8d75a2:
	.byte 0x9d,0x05
