/* rx_flow_substep_uc @ 0x93daf0, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow_substep_uc
rx_flow_substep_uc:
	.global L_93daf0
L_93daf0:
	st.a r13,[sp,-0x10]
L_93daf4:
	ld_s r2,[r0,0x4]
L_93daf6:
	st_s r15,[sp,0xc]
L_93daf8:
	add1_s r2,r2,r2
L_93dafa:
	ldb r1,[r2,0x802228]
L_93db02:
	st_s r14,[sp,0x8]
L_93db04:
	st blink,[sp, 0x4]
L_93db08:
	breq.d r1,0x0,L_93db84
L_93db0c:
	mov_s r14,r0
L_93db0e:
	ld.as r3,[gp,-0x11]
L_93db12:
	and r3,r3,0xfffff0ff
L_93db1a:
	or r0,r3,0xb00
L_93db22:
	or r3,r3,0x1d000b00
L_93db2a:
	st.as r0,[gp,-0x11]
L_93db2e:
	mov_s r32,r3
L_93db30:
	st.ab r3,[r25,0x4]
L_93db34:
	bclr r25,r25,0xa
L_93db38:
	nop_s
L_93db3a:
	nop_s
L_93db3c:
	nop_s
L_93db3e:
	mov_s r15,r41
L_93db40:
	ld.as r5,[gp,-0x11]
L_93db44:
	and r5,r5,0xfffff0ff
L_93db4c:
	or r4,r5,0xc00
L_93db54:
	or r5,r5,0x1d000c00
L_93db5c:
	st.as r4,[gp,-0x11]
L_93db60:
	mov r32,r5
L_93db64:
	st.ab r5,[r25,0x4]
L_93db68:
	bclr r25,r25,0xa
L_93db6c:
	nop_s
L_93db6e:
	nop_s
L_93db70:
	mov 0x0,0x0
L_93db74:
	or r13,r41,r15
L_93db78:
	ld r6,[r14, 0x4]
L_93db7c:
	bbit0.d r13,r6,L_93db88
L_93db80:
	mov r0,0x1
	.global L_93db84
L_93db84:
	mov r0,0x0
	.global L_93db88
L_93db88:
	ld blink,[sp, 0x4]
L_93db8c:
	ld_s r14,[sp,0x8]
L_93db8e:
	ld_s r15,[sp,0xc]
L_93db90:
	j.d [blink]
L_93db94:
	ld.ab r13,[sp,0x10]
