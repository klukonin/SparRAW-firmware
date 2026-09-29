/* ucode_cmd_0x34_handler @ 0x93d9d0, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: ps__hold_awake_for_sta, uc_evt__send_25
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x34_handler
ucode_cmd_0x34_handler:
	.global L_93d9d0
L_93d9d0:
	st.a r13,[sp,-0x10]
L_93d9d4:
	st_s r14,[sp,0x8]
L_93d9d6:
	mov_s r14,0x803180
L_93d9dc:
	ldb r3,[r14, -0x9c]
L_93d9e0:
	st blink,[sp, 0x4]
L_93d9e4:
	brne.d r3,0x1,L_93da80
L_93d9e8:
	st_s r15,[sp,0xc]
L_93d9ea:
	ldb_s r13,[r1]
L_93d9ec:
	stb r13,[r14, -0x93]
L_93d9f0:
	ldb r4,[r1, 0x1]
L_93d9f4:
	stb r4,[r14, -0x92]
L_93d9f8:
	ld r5,[r1, 0x4]
L_93d9fc:
	st r5,[0x8030f0]
L_93da04:
	brne.d r13,0x1,L_93da50
L_93da08:
	ldb r1,[r14, -0x94]
L_93da0c:
	brne r1,0x0,L_93da2c
L_93da10:
	ld r6,[r0, 0x20]
L_93da14:
	brne r6,0x1,L_93da2c
L_93da18:
	bl.d L_93d914
L_93da1c:
	mov r1,0x1
L_93da20:
	ldb r13,[r14, -0x93]
L_93da24:
	b.d L_93da74
L_93da28:
	ldb r15,[r14, -0x94]
	.global L_93da2c
L_93da2c:
	ldb r2,[r0,0x179]
L_93da34:
	cmp r2,0x1
L_93da38:
	bne.d L_93da74
L_93da3c:
	mov.ne r15,r1
L_93da40:
	mov r13,0x0
L_93da44:
	stb r13,[r14, -0x93]
L_93da48:
	b.d L_93da70
L_93da4c:
	mov r15,0x1
	.global L_93da50
L_93da50:
	brne.d r1,0x1,L_93da70
L_93da54:
	mov_s r15,0x0
L_93da56:
	ld_s r1,[r0,0x20]
L_93da58:
	brne r1,0x1,L_93da70
L_93da5c:
	bl.d L_93d914
L_93da60:
	mov r1,0x0
L_93da64:
	stb r15,[r14, -0x94]
L_93da68:
	b.d L_93da74
L_93da6c:
	ldb r13,[r14, -0x93]
	.global L_93da70
L_93da70:
	stb r15,[r14, -0x94]
	.global L_93da74
L_93da74:
	or_s r13,r13,r15
L_93da76:
	extb_s r0,r13
L_93da78:
	b.d L_93da84
L_93da7c:
	mov r1,0x1
	.global L_93da80
L_93da80:
	mov_s r0,0x0
L_93da82:
	mov_s r1,r0
	.global L_93da84
L_93da84:
	bl L_9279a0
L_93da88:
	ld blink,[sp, 0x4]
L_93da8c:
	ld_s r14,[sp,0x8]
L_93da8e:
	ld_s r15,[sp,0xc]
L_93da90:
	j.d [blink]
L_93da94:
	ld.ab r13,[sp,0x10]
