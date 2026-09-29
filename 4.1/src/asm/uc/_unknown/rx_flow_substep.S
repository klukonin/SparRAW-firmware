/* rx_flow_substep @ 0x9374f0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step
 */
	.section .text.rx_flow_substep,"ax",@progbits
	.global rx_flow_substep
rx_flow_substep:
	.global L_9374f0
L_9374f0:
	st.a r13,[sp,-0x10]
L_9374f4:
	ld_s r2,[r0,0x4]
L_9374f6:
	st_s r15,[sp,0xc]
L_9374f8:
	add1_s r2,r2,r2
L_9374fa:
	ldb r1,[r2,0x801130]
L_937502:
	st_s r14,[sp,0x8]
L_937504:
	st blink,[sp, 0x4]
L_937508:
	breq.d r1,0x0,L_937584
L_93750c:
	mov_s r14,r0
L_93750e:
	ld.as r3,[gp,-0x11]
L_937512:
	and r3,r3,0xfffff0ff
L_93751a:
	or r0,r3,0xb00
L_937522:
	or r3,r3,0x1d000b00
L_93752a:
	st.as r0,[gp,-0x11]
L_93752e:
	mov_s r32,r3
L_937530:
	st.ab r3,[r25,0x4]
L_937534:
	bclr r25,r25,0xa
L_937538:
	nop_s
L_93753a:
	nop_s
L_93753c:
	nop_s
L_93753e:
	mov_s r15,r41
L_937540:
	ld.as r5,[gp,-0x11]
L_937544:
	and r5,r5,0xfffff0ff
L_93754c:
	or r4,r5,0xc00
L_937554:
	or r5,r5,0x1d000c00
L_93755c:
	st.as r4,[gp,-0x11]
L_937560:
	mov r32,r5
L_937564:
	st.ab r5,[r25,0x4]
L_937568:
	bclr r25,r25,0xa
L_93756c:
	nop_s
L_93756e:
	nop_s
L_937570:
	mov 0x0,0x0
L_937574:
	or r13,r41,r15
L_937578:
	ld r6,[r14, 0x4]
L_93757c:
	bbit0.d r13,r6,L_937588
L_937580:
	mov r0,0x1
	.global L_937584
L_937584:
	mov r0,0x0
	.global L_937588
L_937588:
	ld blink,[sp, 0x4]
L_93758c:
	ld_s r14,[sp,0x8]
L_93758e:
	ld_s r15,[sp,0xc]
L_937590:
	j.d [blink]
L_937594:
	ld.ab r13,[sp,0x10]
