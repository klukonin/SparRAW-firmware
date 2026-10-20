/* queue_sel__get_qset4 @ 0x92e9e8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global queue_sel__get_qset4
queue_sel__get_qset4:
	.global L_92e9e8
L_92e9e8:
	st.a r13,[sp,-0x8]
L_92e9ec:
	st_s r14,[sp,0x4]
L_92e9ee:
	mov_s r14,blink
L_92e9f0:
	mov_s r13,r0
L_92e9f2:
	mov_s r2,0xf000001
L_92e9f8:
	mov r32,r2
L_92e9fc:
	st.ab r2,[r25,0x4]
L_92ea00:
	bclr r25,r25,0xa
L_92ea04:
	ld.as r1,[gp,-0x11]
L_92ea08:
	and r1,r1,0xfffff0ff
L_92ea10:
	bset r0,r1,0x8
L_92ea14:
	or r1,r1,0x1d000100
L_92ea1c:
	st.as r0,[gp,-0x11]
L_92ea20:
	mov r32,r1
L_92ea24:
	st.ab r1,[r25,0x4]
L_92ea28:
	bclr r25,r25,0xa
L_92ea2c:
	nop_s
L_92ea2e:
	nop_s
L_92ea30:
	nop_s
L_92ea32:
	lsr r3,r41,0x18
L_92ea36:
	bmsk_s r3,r3,0x4
L_92ea38:
	st_s r3,[r13]
L_92ea3a:
	lsr r0,r41,0x1f
L_92ea3e:
	mov_s blink,r14
L_92ea40:
	ld_s r14,[sp,0x4]
L_92ea42:
	j_s.d [blink]
L_92ea44:
	ld.ab r13,[sp,0x8]
