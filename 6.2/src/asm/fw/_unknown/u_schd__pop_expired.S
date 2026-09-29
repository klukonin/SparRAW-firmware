/* u_schd__pop_expired @ 0x8c62c8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__expire_timers, u_schd__reschedule
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, llist__pop_front, time_cmp, u_schd__deadline_less, u_schd__enqueue_ready, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__pop_expired
u_schd__pop_expired:
	.global L_8c62c8
L_8c62c8:
	push_s blink
L_8c62ca:
	bl L_8c01e0
L_8c62ce:
	sub_s sp,sp,0x4
L_8c62d0:
	bl.d L_8e9524
L_8c62d4:
	mov_s r14,r0
L_8c62d6:
	mov_s r15,r0
L_8c62d8:
	mov_s r13,0x803c54
L_8c62de:
	add2_s r13,r13,r14
L_8c62e0:
	mov_s r1,sp
L_8c62e2:
	bl.d L_8cc28c
L_8c62e6:
	ld_s r0,[r13]
L_8c62e8:
	mov_s r0,r15
L_8c62ea:
	bl.d L_8e91bc
L_8c62ee:
	ld_s r1,[sp,0x0]
L_8c62f0:
	cmp r0,-0x1
L_8c62f4:
	mov_s r0,0x0
L_8c62f6:
	beq_s L_8c6306
L_8c62f8:
	bl.d L_8e2674
L_8c62fc:
	ld_s r0,[r13]
L_8c62fe:
	bl.d L_8e0bcc
L_8c6302:
	ldb_s r1,[r0,0x18]
L_8c6304:
	mov_s r0,0x1
	.global L_8c6306
L_8c6306:
	b.d L_8c024c
L_8c630a:
	add_s sp,sp,0x4
