/* bti_worker_bi2_step @ 0x923a84, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step, bti_bi2__track_best_metric
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti_worker_bi2_step
bti_worker_bi2_step:
	.global L_923a84
L_923a84:
	push_s blink
L_923a86:
	bl L_920234
L_923a8a:
	mov_s r14,r0
L_923a8c:
	mov_s r13,r1
L_923a8e:
	mov_s r0,0x0
L_923a90:
	bset_s r0,r0,0x10
L_923a92:
	bl.d L_9366e8
L_923a96:
	mov_s r1,0x0
L_923a98:
	ldb_s r0,[gp,-0xf2]
L_923a9a:
	brne_s r0,0,L_923ab8
L_923a9c:
	ldb_s r0,[gp,-0xf9]
L_923a9e:
	bmsk_s r0,r0,0x0
L_923aa0:
	bset_s r0,r0,0x19
L_923aa2:
	bset_s r0,r0,0x1c
L_923aa4:
	bset_s r0,r0,0x1d
L_923aa6:
	mov_s r32,r0
L_923aa8:
	st.ab r0,[r25,0x4]
L_923aac:
	bclr r25,r25,0xa
L_923ab0:
	ldb_s r0,[gp,-0xf9]
L_923ab2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923ab4:
	stb r0,[gp, -0xf9]
	.global L_923ab8
L_923ab8:
	ld_s r0,[gp,0x50]
L_923aba:
	mov_s r1,0x8022c8
L_923ac0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923ac2:
	st.as r0,[gp,0x14]
L_923ac6:
	ld_s r0,[r1,0x3c]
L_923ac8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923aca:
	st_s r0,[r1,0x3c]
L_923acc:
	mov_s r0,0x2011000
L_923ad2:
	mov_s r32,r0
L_923ad4:
	st.ab r0,[r25,0x4]
L_923ad8:
	bclr r25,r25,0xa
L_923adc:
	mov_s r2,0x804010
L_923ae2:
	brne_s r14,0,L_923aec
L_923ae4:
	breq_s r13,0,L_923aec
L_923ae6:
	bmsk r0,r38,0x0
L_923aea:
	b_s L_923b28
	.global L_923aec
L_923aec:
	mov_s r3,0x802f14
L_923af2:
	ldb_s r13,[r3,0x14]
L_923af4:
	ldb_s r1,[r2,0x4]
L_923af6:
	mov_s r0,0x0
L_923af8:
	brne r13,r1,L_923b26
L_923afc:
	ldb_s r13,[r3,0x15]
L_923afe:
	ldb_s r1,[r2,0x5]
L_923b00:
	brne r13,r1,L_923b26
L_923b04:
	ldb_s r13,[r3,0x16]
L_923b06:
	ldb_s r1,[r2,0x6]
L_923b08:
	brne r13,r1,L_923b26
L_923b0c:
	ldb_s r13,[r3,0x17]
L_923b0e:
	ldb_s r1,[r2,0x7]
L_923b10:
	brne r13,r1,L_923b26
L_923b14:
	ldb_s r13,[r3,0x18]
L_923b16:
	ldb_s r1,[r2,0x8]
L_923b18:
	brne r13,r1,L_923b26
L_923b1c:
	ldb_s r3,[r3,0x19]
L_923b1e:
	ldb_s r1,[r2,0x9]
L_923b20:
	cmp_s r3,r1
L_923b22:
	mov.eq r0,0x1
	.global L_923b26
L_923b26:
	extb_s r0,r0
	.global L_923b28
L_923b28:
	breq_s r0,0,L_923b4a
L_923b2a:
	mov_s r1,0x801030
L_923b30:
	ldb r2,[r1, 0x50]
L_923b34:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_923b36:
	add2_s r2,r2,r2
L_923b38:
	add_s r2,r2,0x801050
L_923b3e:
	ldb_s r1,[r2,0x5]
L_923b40:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_923b42:
	extb_s r1,r1
L_923b44:
	stb_s r1,[r2,0x5]
L_923b46:
	mov_s r1,0x1
L_923b48:
	stb_s r1,[r2,0x6]
	.global L_923b4a
L_923b4a:
	b L_9202a4
L_923b4e:
	nop_s
