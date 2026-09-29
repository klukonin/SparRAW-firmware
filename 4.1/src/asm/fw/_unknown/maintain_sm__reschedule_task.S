/* maintain_sm__reschedule_task @ 0x8df9fc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, maintain_sm__check_bad_link, maintain_sm__on_resume_maintain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.maintain_sm__reschedule_task,"ax",@progbits
	.global maintain_sm__reschedule_task
maintain_sm__reschedule_task:
	.global L_8df9fc
L_8df9fc:
	push_s blink
L_8df9fe:
	bl L_8c02c4
L_8dfa02:
	mov_s r13,r0
L_8dfa04:
	ld_s r0,[gp,-0x6c]
L_8dfa06:
	brne_s r0,0,L_8dfa3a
L_8dfa08:
	ld_s r0,[r13,0x44]
L_8dfa0a:
	mov_s r14,0x0
L_8dfa0c:
	breq_s r0,0,L_8dfa14
L_8dfa0e:
	bl L_8c7794
L_8dfa12:
	st_s r14,[r13,0x44]
	.global L_8dfa14
L_8dfa14:
	mov_s r1,0x1
L_8dfa16:
	add3 r0,r13,0x10
L_8dfa1a:
	st_s r1,[r0,0x34]
L_8dfa1c:
	st_s r14,[r0,0x38]
L_8dfa1e:
	st_s r14,[r0,0x3c]
L_8dfa20:
	mov_s r0,0x50e8
L_8dfa26:
	ld.as r4,[gp,0x4e]
L_8dfa2a:
	mov_s r1,r13
L_8dfa2c:
	mov_s r2,0x0
L_8dfa2e:
	mov_s r3,r2
L_8dfa30:
	mov_s r5,r2
L_8dfa32:
	bl.d L_8dc92c
L_8dfa36:
	mov_s r6,r2
L_8dfa38:
	st_s r0,[r13,0x44]
	.global L_8dfa3a
L_8dfa3a:
	b L_8c0334
L_8dfa3e:
	nop_s
