/* fsched__pick_ready_queue @ 0x92be90, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__pick_queue_r41, l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 * Глобалы (через gp): 0x8006cc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__pick_ready_queue
fsched__pick_ready_queue:
	.global L_92be90
L_92be90:
	push_s blink
L_92be92:
	bl L_920234
L_92be96:
	mov_s r14,r0
L_92be98:
	ld_s r0,[gp,-0x44]
L_92be9a:
	and r0,r0,0xfffff0ff
L_92bea2:
	bset r1,r0,0x8
L_92bea6:
	bset_s r1,r1,0x9
L_92bea8:
	bset_s r1,r1,0xb
L_92beaa:
	or r0,r0,0x1d000b00
L_92beb2:
	st.as r1,[gp,-0x11]
L_92beb6:
	mov_s r32,r0
L_92beb8:
	st.ab r0,[r25,0x4]
L_92bebc:
	bclr r25,r25,0xa
L_92bec0:
	nop_s
L_92bec2:
	nop_s
L_92bec4:
	nop_s
L_92bec6:
	mov_s r13,r41
L_92bec8:
	ld_s r0,[gp,-0x44]
L_92beca:
	and r0,r0,0xfffff0ff
L_92bed2:
	bset r1,r0,0xa
L_92bed6:
	bset_s r1,r1,0xb
L_92bed8:
	or r0,r0,0x1d000c00
L_92bee0:
	st.as r1,[gp,-0x11]
L_92bee4:
	mov_s r32,r0
L_92bee6:
	st.ab r0,[r25,0x4]
L_92beea:
	bclr r25,r25,0xa
L_92beee:
	nop_s
L_92bef0:
	nop_s
L_92bef2:
	nop_s
L_92bef4:
	or r13,r13,r41
L_92bef8:
	mov_s r0,0x8014a4
L_92befe:
	ld_s r0,[r0,0x1c]
L_92bf00:
	breq_s r0,0,L_92bf10
L_92bf02:
	ld.as r1,[gp,-0x30]
L_92bf06:
	mov_s r0,0x1
L_92bf08:
	bbit0 r13,r1,L_92bf10
L_92bf0c:
	st_s r1,[r14]
L_92bf0e:
	b_s L_92bf26
	.global L_92bf10
L_92bf10:
	ld_s r0,[gp,0x1a4]
L_92bf12:
	cmp_s r0,0x0
L_92bf14:
	mov.ne r0,0x1f
L_92bf18:
	bne_s L_92bf22
L_92bf1a:
	mov_s r0,0x0
L_92bf1c:
	bbit0 r13,0x1a,L_92bf26
L_92bf20:
	mov_s r0,0x1a
	.global L_92bf22
L_92bf22:
	st_s r0,[r14]
L_92bf24:
	mov_s r0,0x1
	.global L_92bf26
L_92bf26:
	b L_9202a4
L_92bf2a:
	nop_s
