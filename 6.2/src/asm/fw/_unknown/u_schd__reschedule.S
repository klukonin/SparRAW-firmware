/* u_schd__reschedule @ 0x8e91fc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__arm_timer, u_schd__invoke_callback, u_schd__pop_expired
 * Глобалы (через gp): 0x80025c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__reschedule
u_schd__reschedule:
	.global L_8e91fc
L_8e91fc:
	push_s blink
L_8e91fe:
	bl L_8c01e4
L_8e9202:
	mov_s r14,r0
L_8e9204:
	mov_s r0,0x803c54
L_8e920a:
	bl.d L_8c64d4
L_8e920e:
	ld.as r0,[r0,r14]
L_8e9212:
	breq_s r0,0,L_8e9264
L_8e9214:
	lr r13,[0xa]
L_8e9218:
	bclr r0,r13,0x1
L_8e921c:
	flag r0
L_8e9220:
	b_s L_8e922a
	.global L_8e9222
L_8e9222:
	bl.d L_8c62c8
L_8e9226:
	mov_s r0,r14
L_8e9228:
	breq_s r0,0,L_8e9248
	.global L_8e922a
L_8e922a:
	mov_s r0,0x803c54
L_8e9230:
	ld.as r0,[r0,r14]
L_8e9234:
	ld_s r0,[r0]
L_8e9236:
	sub.f r0,r0,0x0
L_8e923a:
	mov.ne r0,0x1
L_8e923e:
	extb.f 0x0,r0
L_8e9242:
	bne_s L_8e9222
L_8e9244:
	mov_s r1,0x1
L_8e9246:
	b_s L_8e924a
	.global L_8e9248
L_8e9248:
	mov_s r1,0x0
	.global L_8e924a
L_8e924a:
	ldb_s r0,[gp,0xd8]
L_8e924c:
	cmp_s r14,r0
L_8e924e:
	cmp.ne r1,0x0
L_8e9252:
	bl.eq L_8e249c
L_8e9256:
	lr r0,[0xa]
L_8e925a:
	bic r13,r13,-0x3
L_8e925e:
	or_s r13,r13,r0
L_8e9260:
	flag r13
	.global L_8e9264
L_8e9264:
	b L_8c0254
