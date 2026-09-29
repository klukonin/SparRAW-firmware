/* power_manager__decide_shallow_sleep @ 0x92ad98, 436 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   power_manager.cpp
 * Зовут его: bi_dti__wake_and_evaluate_sleep
 * Зовёт сам: mac__program_deadline_slack, perform_shallow_sleep, power_manager__maybe_wake_pcie, ps_awake_peer__send_full, uc_sysassert
 * Глобалы (через gp): 0x800544, 0x800574, 0x8005cc, 0x8005ce
 */
	.section .text.power_manager__decide_shallow_sleep,"ax",@progbits
	.global power_manager__decide_shallow_sleep
power_manager__decide_shallow_sleep:
	.global L_92ad98
L_92ad98:
	st.a r13,[sp,-0x10]
L_92ad9c:
	st blink,[sp, 0x4]
L_92ada0:
	st_s r14,[sp,0x8]
L_92ada2:
	st_s r15,[sp,0xc]
L_92ada4:
	mov_s r14,0x800fcc
L_92adaa:
	ldb r7,[r14, 0x68]
L_92adae:
	mov_s r13,r0
L_92adb0:
	norm r7,r7
L_92adb4:
	rsub r5,r7,0x1e
L_92adb8:
	asl r5,r5,0x2
L_92adbc:
	add2 r5,r5,r5
L_92adc0:
	ldb r15,[r5,0x857849]
L_92adc8:
	bl.d L_926934
L_92adcc:
	mov r1,0x0
L_92add0:
	ld r7,[r13, 0x20]
L_92add4:
	cmp r7,0x2
L_92add8:
	cmp.eq r15,0x0
L_92addc:
	bne L_92ae0c
L_92ade0:
	ld.as r8,[r13,0x50]
L_92ade4:
	brne r8,0x0,L_92adf0
L_92ade8:
	ld r9,[r13, 0x18]
L_92adec:
	breq r9,0x0,L_92ae0c
	.global L_92adf0
L_92adf0:
	ldw.as r6,[gp,0x53]
L_92adf4:
	ld blink,[sp, 0x4]
L_92adf8:
	add r6,r6,0x1
L_92adfc:
	stw.as r6,[gp,0x53]
L_92ae00:
	ld_s r14,[sp,0x8]
L_92ae02:
	ld_s r15,[sp,0xc]
L_92ae04:
	j.d [blink]
L_92ae08:
	ld.ab r13,[sp,0x10]
	.global L_92ae0c
L_92ae0c:
	ldb r10,[r14, 0x68]
L_92ae10:
	breq r10,0x0,L_92ae2c
L_92ae14:
	ld.as r11,[gp,-0x23]
L_92ae18:
	brne r11,0x0,L_92ae2c
L_92ae1c:
	ld_s r0,[gp,0x1c]
L_92ae1e:
	cmp_s r0,0x0
L_92ae20:
	mov.eq r0,r13
L_92ae24:
	bl.eq.d L_9265bc
L_92ae28:
	mov.eq r1,0x0
	.global L_92ae2c
L_92ae2c:
	ld.as r6,[r13,0x50]
L_92ae30:
	breq r6,0x0,L_92ae54
L_92ae34:
	ld.as r1,[r13,0x4d]
L_92ae38:
	brne_s r1,0,L_92ae54
L_92ae3a:
	ld.as r2,[r13,0x4e]
L_92ae3e:
	brne_s r2,0,L_92ae54
L_92ae40:
	ld.as r3,[gp,0x13]
L_92ae44:
	brne_s r3,0,L_92ae54
L_92ae46:
	ld r4,[r13, 0x20]
L_92ae4a:
	cmp r4,0x0
L_92ae4e:
	cmp.ne r15,0x0
L_92ae52:
	beq_s L_92ae7c
	.global L_92ae54
L_92ae54:
	ldw.as r7,[gp,0x52]
L_92ae58:
	add r7,r7,0x1
L_92ae5c:
	stw.as r7,[gp,0x52]
L_92ae60:
	ld_s r1,[r13,0x20]
L_92ae62:
	breq_s r1,0,L_92aea0
L_92ae64:
	ld r0,[0x801434]
L_92ae6c:
	mov r1,0x7
L_92ae70:
	bl.d L_930494
L_92ae74:
	mov r2,0x50
L_92ae78:
	b L_92aea0
	.global L_92ae7c
L_92ae7c:
	ldw.as r6,[gp,0x53]
L_92ae80:
	ldb r2,[r14, 0x68]
L_92ae84:
	add r6,r6,0x1
L_92ae88:
	breq.d r2,0x0,L_92aea0
L_92ae8c:
	stw.as r6,[gp,0x53]
L_92ae90:
	mov_s r0,r13
L_92ae92:
	mov_s r1,0x1
L_92ae94:
	mov_s r2,0x0
L_92ae96:
	mov_s r3,r1
L_92ae98:
	bl.d L_92af4c
L_92ae9c:
	mov r4,r1
	.global L_92aea0
L_92aea0:
	ld.as r4,[gp,-0x22]
L_92aea4:
	brne r4,0x0,L_92aee8
L_92aea8:
	add r6,r13,0x200
L_92aeb0:
	ldb r8,[r6, -0xcb]
L_92aeb4:
	ldb r5,[r14, 0x68]
L_92aeb8:
	ldb r4,[r6, -0xcc]
L_92aebc:
	or r8,r8,r4
L_92aec0:
	breq.d r5,0x0,L_92aee8
L_92aec4:
	ldb r9,[r6, -0xc8]
L_92aec8:
	ld_s r0,[r13,0x20]
L_92aeca:
	breq_s r0,0,L_92aee8
L_92aecc:
	ld r3,[r13, 0x18]
L_92aed0:
	breq.d r3,0x0,L_92af10
L_92aed4:
	ld.as r7,[r13,0x50]
L_92aed8:
	breq r7,0x0,L_92aee8
L_92aedc:
	cmp r8,0x0
L_92aee0:
	cmp.eq r9,0x0
L_92aee4:
	bne L_92aef8
	.global L_92aee8
L_92aee8:
	ld blink,[sp, 0x4]
L_92aeec:
	ld_s r14,[sp,0x8]
L_92aeee:
	ld_s r15,[sp,0xc]
L_92aef0:
	j.d [blink]
L_92aef4:
	ld.ab r13,[sp,0x10]
	.global L_92aef8
L_92aef8:
	mov_s r0,blink
L_92aefa:
	mov_s r2,0x1002cd0
L_92af00:
	mov r1,0x12d4
L_92af08:
	b.d L_92af38
L_92af0c:
	mov r3,0xbf
	.global L_92af10
L_92af10:
	breq r7,0x0,L_92aee8
L_92af14:
	cmp r8,0x0
L_92af18:
	cmp.eq r9,0x0
L_92af1c:
	cmp.eq r15,0x0
L_92af20:
	bne_s L_92aee8
L_92af22:
	ld.as r3,[gp,0x13]
L_92af26:
	brne_s r3,0,L_92aee8
L_92af28:
	mov_s r0,blink
L_92af2a:
	mov_s r2,0x1002cd0
L_92af30:
	mov_s r1,0x12d5
L_92af36:
	mov_s r3,0xc4
	.global L_92af38
L_92af38:
	bl L_925548
L_92af3c:
	ld blink,[sp, 0x4]
L_92af40:
	ld_s r14,[sp,0x8]
L_92af42:
	ld_s r15,[sp,0xc]
L_92af44:
	j.d [blink]
L_92af48:
	ld.ab r13,[sp,0x10]
