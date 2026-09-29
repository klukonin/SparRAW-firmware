/* l1__snapshot_bi_counter @ 0x9239dc, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 * Зовёт сам: bi__tsf_delta64, mac__read_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1__snapshot_bi_counter
l1__snapshot_bi_counter:
	.global L_9239dc
L_9239dc:
	st.a r13,[sp,-0x8]
L_9239e0:
	st_s r14,[sp,0x4]
L_9239e2:
	mov_s r14,blink
L_9239e4:
	mov r13,0x802ec0
L_9239ec:
	bl.d L_9356cc
L_9239f0:
	add r0,r13,0x3c
L_9239f4:
	ld r0,[r13, 0x18]
L_9239f8:
	bl.d L_924818
L_9239fc:
	ld r1,[r13, 0x1c]
L_923a00:
	mov_s r2,0x801030
L_923a06:
	ldb r3,[r2, 0x50]
L_923a0a:
	ld.as r4,[gp,-0x11]
L_923a0e:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_923a10:
	add2_s r3,r3,r3
L_923a12:
	add_s r2,r2,0x10
L_923a14:
	add_s r2,r2,r3
L_923a16:
	st_s r0,[r2]
L_923a18:
	and r4,r4,0xffff0fff
L_923a20:
	bset r0,r4,0xe
L_923a24:
	st.as r0,[gp,-0x11]
L_923a28:
	or r4,r4,0x1d004000
L_923a30:
	mov r32,r4
L_923a34:
	st.ab r4,[r25,0x4]
L_923a38:
	bclr r25,r25,0xa
L_923a3c:
	nop_s
L_923a3e:
	nop_s
L_923a40:
	nop_s
L_923a42:
	bmsk r4,r40,0x19
L_923a46:
	mov_s r3,0x802f10
L_923a4c:
	st r4,[r3]
L_923a50:
	mov_s blink,r14
L_923a52:
	ld_s r14,[sp,0x4]
L_923a54:
	j.d [blink]
L_923a58:
	ld.ab r13,[sp,0x8]
