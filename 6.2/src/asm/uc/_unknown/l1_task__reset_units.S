/* l1_task__reset_units @ 0x92ec50, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 * Зовёт сам: gp_timer__stop
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__reset_units
l1_task__reset_units:
	.global L_92ec50
L_92ec50:
	push_s r13
L_92ec52:
	mov_s r13,blink
L_92ec54:
	bl.d L_925998
L_92ec58:
	mov r0,0x0
L_92ec5c:
	bl.d L_925998
L_92ec60:
	mov r0,0x1
L_92ec64:
	bl.d L_925998
L_92ec68:
	mov r0,0x2
L_92ec6c:
	mov_s r0,0x54
L_92ec6e:
	asl_s r0,r0,0x18
L_92ec70:
	mov r32,r0
L_92ec74:
	st.ab r0,[r25,0x4]
L_92ec78:
	bclr r25,r25,0xa
L_92ec7c:
	mov_s r1,0x54
L_92ec7e:
	asl_s r1,r1,0x18
L_92ec80:
	mov r32,r1
L_92ec84:
	st.ab r1,[r25,0x4]
L_92ec88:
	bclr r25,r25,0xa
L_92ec8c:
	mov_s r2,0x49000100
L_92ec92:
	mov_s r32,r2
L_92ec94:
	st.ab r2,[r25,0x4]
L_92ec98:
	bclr r25,r25,0xa
L_92ec9c:
	mov_s r3,0x51000284
L_92eca2:
	mov_s r32,r3
L_92eca4:
	st.ab r3,[r25,0x4]
L_92eca8:
	bclr r25,r25,0xa
L_92ecac:
	mov r4,0x54000508
L_92ecb4:
	mov r32,r4
L_92ecb8:
	st.ab r4,[r25,0x4]
L_92ecbc:
	bclr r25,r25,0xa
L_92ecc0:
	mov_s blink,r13
L_92ecc2:
	j_s.d [blink]
L_92ecc4:
	pop_s r13
L_92ecc6:
	nop_s
