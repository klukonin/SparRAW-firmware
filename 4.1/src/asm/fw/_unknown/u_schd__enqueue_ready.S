/* u_schd__enqueue_ready @ 0x8dc8ec, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__add, u_schd__run_expired
 * Зовёт сам: __ld_r13_ret, llist__insert
 * Глобалы (через gp): 0x800190
 */
	.section .text.u_schd__enqueue_ready,"ax",@progbits
	.global u_schd__enqueue_ready
u_schd__enqueue_ready:
	.global L_8dc8ec
L_8dc8ec:
	push_s blink
L_8dc8ee:
	push_s r13
L_8dc8f0:
	mov_s r4,r0
L_8dc8f2:
	lr r13,[0xa]
L_8dc8f6:
	bclr r0,r13,0x1
L_8dc8fa:
	flag r0
L_8dc8fe:
	ld_s r0,[gp,0x20]
L_8dc900:
	bic r13,r13,-0x3
L_8dc904:
	bset r0,r0,r1
L_8dc908:
	st.as r0,[gp,0x8]
L_8dc90c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8dc90e:
	add1_s r1,r1,r1
L_8dc910:
	add r0,r1,0x8034b0
L_8dc918:
	bl.d L_8c1fc4
L_8dc91c:
	mov_s r1,r4
L_8dc91e:
	lr r0,[0xa]
L_8dc922:
	or_s r13,r13,r0
L_8dc924:
	flag r13
L_8dc928:
	b L_8c033c
