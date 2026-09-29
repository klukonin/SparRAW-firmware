/* rx_nav_bi_step @ 0x92fb20, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_flow_step
 * Зовёт сам: bi_ap_mon__window_code, nav_db__update, uc_sta_ctx__reset, uc_sta_trace__push_record
 * Глобалы (через gp): 0x800540, 0x8005b4
 */
	.section .text.rx_nav_bi_step,"ax",@progbits
	.global rx_nav_bi_step
rx_nav_bi_step:
	.global L_92fb20
L_92fb20:
	st.a r13,[sp,-0x14]
L_92fb24:
	st blink,[sp, 0x4]
L_92fb28:
	ld r1,[0x804004]
L_92fb30:
	st_s r15,[sp,0xc]
L_92fb32:
	st_s r14,[sp,0x8]
L_92fb34:
	bbit0.d r1,0x17,L_92fbf8
L_92fb38:
	st r16,[sp, 0x10]
L_92fb3c:
	mov r14,0x804010
L_92fb44:
	ldw r5,[r14]
L_92fb48:
	mov r16,0x80401a
L_92fb50:
	lsr r5,r5,0x2
L_92fb54:
	bmsk r5,r5,0x1
L_92fb58:
	brne.d r5,0x3,L_92fbd4
L_92fb5c:
	ldw r15,[r14, 0x2]
L_92fb60:
	bl.d L_931f54
L_92fb64:
	mov r0,0x3
L_92fb68:
	st.as r0,[gp,0x23]
L_92fb6c:
	ldw r11,[r14, 0xa]
L_92fb70:
	ldw r10,[r14, 0xc]
L_92fb74:
	ldw r9,[r14, 0xe]
L_92fb78:
	ldw r8,[r14, 0x10]
L_92fb7c:
	stw r11,[r0, 0xc]
L_92fb80:
	stw r10,[r0, 0xe]
L_92fb84:
	stw r9,[r0, 0x10]
L_92fb88:
	stw r8,[r0, 0x12]
L_92fb8c:
	bl.d L_931ef8
L_92fb90:
	mov r0,0x3
L_92fb94:
	ldb r3,[gp, -0xe8]
L_92fb98:
	mov r16,0x804014
L_92fba0:
	breq_s r3,0,L_92fbf8
L_92fba2:
	mov_s r13,0x857000
L_92fba8:
	ld r6,[r13, 0x14]
L_92fbac:
	add r15,r15,0x640
L_92fbb0:
	add r6,r6,0x1
L_92fbb4:
	st r6,[r13, 0x14]
L_92fbb8:
	bl.d L_926490
L_92fbbc:
	extw r15,r15
L_92fbc0:
	extb r0,r0
L_92fbc4:
	brne r0,0x2,L_92fbd4
L_92fbc8:
	ld r4,[r13, 0x18]
L_92fbcc:
	add r4,r4,0x1
L_92fbd0:
	st r4,[r13, 0x18]
	.global L_92fbd4
L_92fbd4:
	ld.as r2,[gp,0x6]
L_92fbd8:
	bbit1 r2,0x0,L_92fbe8
L_92fbdc:
	mov_s r2,0x800a0c
L_92fbe2:
	ldb_s r0,[r2]
L_92fbe4:
	stb r0,[r2, 0x5]
	.global L_92fbe8
L_92fbe8:
	mov_s r0,0x1
L_92fbea:
	ldw_s r1,[r14]
L_92fbec:
	mov r2,r15
L_92fbf0:
	bl.d L_92a6f4
L_92fbf4:
	mov r3,r16
	.global L_92fbf8
L_92fbf8:
	ld blink,[sp, 0x4]
L_92fbfc:
	ld_s r14,[sp,0x8]
L_92fbfe:
	ld_s r15,[sp,0xc]
L_92fc00:
	ld r16,[sp, 0x10]
L_92fc04:
	j.d [blink]
L_92fc08:
	ld.ab r13,[sp,0x14]
