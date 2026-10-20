/* bti__reset_sweep_state @ 0x92ad3c, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ctx__set_active
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__reset_sweep_state
bti__reset_sweep_state:
	.global L_92ad3c
L_92ad3c:
	st.a r13,[sp,-0x8]
L_92ad40:
	st_s r14,[sp,0x4]
L_92ad42:
	mov_s r14,blink
L_92ad44:
	mov_s r13,r0
L_92ad46:
	mov_s r1,0x0
L_92ad48:
	mov lp_count,0x40
L_92ad4c:
	mov r0,0x80169c
L_92ad54:
	lp L_92ad60
L_92ad58:
	stb.ab r1,[r0,0x1]
L_92ad5c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92ad5e:
	extb_s r1,r1
	.global L_92ad60
L_92ad60:
	mov r0,0x802f14
L_92ad68:
	bl.d L_920a84
L_92ad6c:
	mov r1,0x1c
L_92ad70:
	mov_s r2,0x54
L_92ad72:
	asl_s r2,r2,0x18
L_92ad74:
	mov r32,r2
L_92ad78:
	st.ab r2,[r25,0x4]
L_92ad7c:
	bclr r25,r25,0xa
L_92ad80:
	mov_s r3,0x54
L_92ad82:
	asl_s r3,r3,0x18
L_92ad84:
	mov r32,r3
L_92ad88:
	st.ab r3,[r25,0x4]
L_92ad8c:
	bclr r25,r25,0xa
L_92ad90:
	mov r4,0x49000100
L_92ad98:
	mov r32,r4
L_92ad9c:
	st.ab r4,[r25,0x4]
L_92ada0:
	bclr r25,r25,0xa
L_92ada4:
	mov r5,0x51000284
L_92adac:
	mov r32,r5
L_92adb0:
	st.ab r5,[r25,0x4]
L_92adb4:
	bclr r25,r25,0xa
L_92adb8:
	mov r6,0x54000508
L_92adc0:
	mov r32,r6
L_92adc4:
	st.ab r6,[r25,0x4]
L_92adc8:
	bclr r25,r25,0xa
L_92adcc:
	mov r0,0x802a14
L_92add4:
	bl.d L_920a84
L_92add8:
	mov r1,0x58
L_92addc:
	mov_s r3,0x0
L_92adde:
	stb_s r3,[r13,0x5]
L_92ade0:
	mov_s blink,r14
L_92ade2:
	ld_s r14,[sp,0x4]
L_92ade4:
	j.d [blink]
L_92ade8:
	ld.ab r13,[sp,0x8]
