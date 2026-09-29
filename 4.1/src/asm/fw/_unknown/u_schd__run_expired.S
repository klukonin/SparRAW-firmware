/* u_schd__run_expired @ 0x8c55c4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__reschedule, u_schd__tick
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_read_timer, llist__pop_front, time_cmp, u_schd__deadline_less, u_schd__enqueue_ready
 */
	.section .text.u_schd__run_expired,"ax",@progbits
	.global u_schd__run_expired
u_schd__run_expired:
	.global L_8c55c4
L_8c55c4:
	push_s blink
L_8c55c6:
	bl L_8c02c0
L_8c55ca:
	sub_s sp,sp,0x4
L_8c55cc:
	bl.d L_8e4694
L_8c55d0:
	mov_s r14,r0
L_8c55d2:
	mov_s r15,r0
L_8c55d4:
	mov_s r13,0x8034a8
L_8c55da:
	add2_s r13,r13,r14
L_8c55dc:
	mov_s r1,sp
L_8c55de:
	bl.d L_8ca070
L_8c55e2:
	ld_s r0,[r13]
L_8c55e4:
	mov_s r0,r15
L_8c55e6:
	bl.d L_8e431c
L_8c55ea:
	ld_s r1,[sp,0x0]
L_8c55ec:
	cmp r0,-0x1
L_8c55f0:
	mov_s r0,0x0
L_8c55f2:
	beq_s L_8c560e
L_8c55f4:
	bl.d L_8de2d4
L_8c55f8:
	ld_s r0,[r13]
L_8c55fa:
	ld_s r1,[r0,0x18]
L_8c55fc:
	mov_s r13,r0
L_8c55fe:
	breq_s r1,0,L_8c5604
L_8c5600:
	jl_s.d [r1]
L_8c5602:
	ld_s r0,[r13,0x1c]
	.global L_8c5604
L_8c5604:
	mov_s r0,r13
L_8c5606:
	bl.d L_8dc8ec
L_8c560a:
	ldw_s r1,[r13,0x20]
L_8c560c:
	mov_s r0,0x1
	.global L_8c560e
L_8c560e:
	b.d L_8c032c
L_8c5612:
	add_s sp,sp,0x4
