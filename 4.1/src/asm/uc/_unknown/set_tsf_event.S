/* set_tsf_event @ 0x930c28, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_tsf_event()
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.set_tsf_event,"ax",@progbits
	.global set_tsf_event
set_tsf_event:
	.global L_930c28
L_930c28:
	st.a r13,[sp,-0x8]
L_930c2c:
	mov_s r13,r0
L_930c2e:
	mov r6,0x80209c
L_930c36:
	ldb r0,[r6, 0x4]
L_930c3a:
	mov r4,0x1000d8c
L_930c42:
	st_s r14,[sp,0x4]
L_930c44:
	bbit0.d r0,0x2,L_930c74
L_930c48:
	mov_s r14,blink
L_930c4a:
	bmsk r4,r4,0x13
L_930c4e:
	ld r3,[r6]
L_930c52:
	or r4,r4,0xa2000000
L_930c5a:
	extb r7,r3
L_930c5e:
	mov r5,0x8020b0
L_930c66:
	add2 r7,r5,r7
L_930c6a:
	st r4,[r7]
L_930c6e:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_930c70:
	st r3,[r6]
	.global L_930c74
L_930c74:
	mov r4,0x2000040
L_930c7c:
	mov r32,r4
L_930c80:
	st.ab r4,[r25,0x4]
L_930c84:
	bclr r25,r25,0xa
L_930c88:
	ld r5,[r13]
L_930c8c:
	mov_s r2,0x887000
L_930c92:
	st.as r5,[r2,-0xb4]
L_930c96:
	ld_s r1,[r13,0x4]
L_930c98:
	mov_s blink,r14
L_930c9a:
	st.as r1,[r2,-0xb3]
L_930c9e:
	st.as 0xc0050,[r2,-0xb2]
L_930ca6:
	ld_s r14,[sp,0x4]
L_930ca8:
	j.d [blink]
L_930cac:
	ld.ab r13,[sp,0x8]
