/* bti_transmitter_bi2_flow @ 0x923c74, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/bf_gpc_service.h
 * Зовут его: bi__decide_beacon_kind
 * Зовёт сам: bf_gpc__program_mac_by_mode_b, bti__bi2_event_step, bti_bi2__gp0_end_flag, bti_bi2__gp2_end_flag, bti_tx__program_bi2_regs, bti_worker__collect_bf_metric, uc_sysassert
 */
	.section .text.bti_transmitter_bi2_flow,"ax",@progbits
	.global bti_transmitter_bi2_flow
bti_transmitter_bi2_flow:
	.global L_923c74
L_923c74:
	st.a r13,[sp,-0x10]
L_923c78:
	st blink,[sp, 0x4]
L_923c7c:
	ld_s r2,[r0]
L_923c7e:
	st_s r15,[sp,0xc]
L_923c80:
	st r14,[sp, 0x8]
L_923c84:
	breq.d r2,0x1,L_923c94
L_923c88:
	mov r14,r0
L_923c8c:
	bl L_931f8c
L_923c90:
	cmp_s r0,0x0
L_923c92:
	beq_s L_923da8
	.global L_923c94
L_923c94:
	mov_s r15,0x804010
L_923c9a:
	ldw_s r1,[r15,0x2]
L_923c9c:
	cmp_s r1,0x4
L_923c9e:
	mov.cs r1,0x4
L_923ca2:
	sub.cc r1,r1,0x4
L_923ca6:
	mulu64 r1,0xa5
L_923caa:
	mov r7,0x52000000
L_923cb2:
	mov_s r13,mlo
L_923cb4:
	mov r32,r7
L_923cb8:
	st.ab r7,[r25,0x4]
L_923cbc:
	bclr r25,r25,0xa
L_923cc0:
	mov r4,0x52000000
L_923cc8:
	mov r32,r4
L_923ccc:
	st.ab r4,[r25,0x4]
L_923cd0:
	bclr r25,r25,0xa
L_923cd4:
	mov r5,0x49000040
L_923cdc:
	mov r32,r5
L_923ce0:
	st.ab r5,[r25,0x4]
L_923ce4:
	bclr r25,r25,0xa
L_923ce8:
	or r13,r13,0x4f000000
L_923cf0:
	mov r32,r13
L_923cf4:
	st.ab r13,[r25,0x4]
L_923cf8:
	bclr r25,r25,0xa
L_923cfc:
	mov r6,0x5200090c
L_923d04:
	mov r32,r6
L_923d08:
	st.ab r6,[r25,0x4]
L_923d0c:
	bclr r25,r25,0xa
L_923d10:
	bl L_923dd4
L_923d14:
	rsub.f r0,r0,0x1
L_923d18:
	mov.cs r0,0x0
L_923d1c:
	extb.f 0x0,r0
L_923d20:
	mov_s r13,0x801e68
L_923d26:
	beq_s L_923d90
L_923d28:
	ldb_s r0,[r13,0x1]
L_923d2a:
	breq_s r0,0,L_923d60
L_923d2c:
	ldw r8,[r15, 0x2]
L_923d30:
	rsub r1,r8,0x4
L_923d34:
	mulu64 r1,0xa5
L_923d38:
	cmp r8,0x4
L_923d3c:
	mov.cs r15,mlo
L_923d40:
	mov.cc r15,0x4
L_923d44:
	bl.d L_92b58c
L_923d48:
	mov r0,r15
L_923d4c:
	ldb_s r2,[r13,0x1b]
L_923d4e:
	cmp_s r2,0x0
L_923d50:
	bl.ne.d L_92c968
L_923d54:
	mov.ne r0,r15
L_923d58:
	bl L_929020
L_923d5c:
	brne r0,0x0,L_923d78
	.global L_923d60
L_923d60:
	bl.d L_9375ec
L_923d64:
	mov r0,r14
L_923d68:
	ld blink,[sp, 0x4]
L_923d6c:
	ld_s r14,[sp,0x8]
L_923d6e:
	ld_s r15,[sp,0xc]
L_923d70:
	j.d [blink]
L_923d74:
	ld.ab r13,[sp,0x10]
	.global L_923d78
L_923d78:
	mov_s r0,blink
L_923d7a:
	mov_s r2,0x1002f54
L_923d80:
	mov r1,0x86
L_923d84:
	bl.d L_925548
L_923d88:
	mov r3,0x100
L_923d8c:
	b L_923d60
	.global L_923d90
L_923d90:
	ldw_s r3,[r13,0x18]
L_923d92:
	ld blink,[sp, 0x4]
L_923d96:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_923d98:
	stw_s r3,[r13,0x18]
L_923d9a:
	mov_s r3,0x4
L_923d9c:
	stb_s r3,[r14,0x4]
L_923d9e:
	ld_s r14,[sp,0x8]
L_923da0:
	ld_s r15,[sp,0xc]
L_923da2:
	j_s.d [blink]
L_923da4:
	ld.ab r13,[sp,0x10]
	.global L_923da8
L_923da8:
	ld blink,[sp, 0x4]
L_923dac:
	ld_s r14,[sp,0x8]
L_923dae:
	ld_s r15,[sp,0xc]
L_923db0:
	j.d [blink]
L_923db4:
	ld.ab r13,[sp,0x10]
