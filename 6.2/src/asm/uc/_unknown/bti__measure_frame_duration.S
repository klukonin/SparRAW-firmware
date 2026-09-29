/* bti__measure_frame_duration @ 0x937cf0, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__program_tx_beacon
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bti__measure_frame_duration
bti__measure_frame_duration:
	.global L_937cf0
L_937cf0:
	push_s blink
L_937cf2:
	bl L_920234
L_937cf6:
	mov_s r14,r0
L_937cf8:
	mov_s r0,0x1500ffff
L_937cfe:
	mov_s r32,r0
L_937d00:
	st.ab r0,[r25,0x4]
L_937d04:
	bclr r25,r25,0xa
L_937d08:
	mov_s r0,0x14000007
L_937d0e:
	mov_s r32,r0
L_937d10:
	st.ab r0,[r25,0x4]
L_937d14:
	bclr r25,r25,0xa
L_937d18:
	bl L_92d8a4
	.global L_937d1c
L_937d1c:
	mov_s r0,r43
L_937d1e:
	bbit0 r0,0x1f,L_937d1c
L_937d22:
	mov_s r0,r51
L_937d24:
	bmsk r1,r0,0x3
L_937d28:
	st.as r1,[gp,0x38]
L_937d2c:
	lsr_s r0,r0,0x4
L_937d2e:
	st.as r0,[gp,0x39]
L_937d32:
	mov_s r0,0x886d00
L_937d38:
	ld_s r13,[r0,0xc]
L_937d3a:
	lsr_s r13,r13,0x18
	.global L_937d3c
L_937d3c:
	mov_s r0,r45
L_937d3e:
	bbit0 r0,0x1f,L_937d3c
L_937d42:
	ld_s r0,[gp,-0x44]
L_937d44:
	and r0,r0,0xfff0ffff
L_937d4c:
	bset r1,r0,0x13
L_937d50:
	or r0,r0,0x1d080000
L_937d58:
	st.as r1,[gp,-0x11]
L_937d5c:
	mov_s r32,r0
L_937d5e:
	st.ab r0,[r25,0x4]
L_937d62:
	bclr r25,r25,0xa
L_937d66:
	nop_s
L_937d68:
	nop_s
L_937d6a:
	nop_s
	.global L_937d6c
L_937d6c:
	mov_s r0,r47
L_937d6e:
	bbit0 r0,0x1f,L_937d6c
L_937d72:
	mov_s r1,r47
L_937d74:
	extw_s r0,r1
L_937d76:
	mov_s r2,0x802a54
L_937d7c:
	ldb_s r2,[r2,0x14]
L_937d7e:
	add_s r0,r0,r13
L_937d80:
	mulu64 r0,r2
L_937d84:
	mov_s r2,0x857720
L_937d8a:
	sub r0,mlo,r13
L_937d8e:
	extw_s r0,r0
L_937d90:
	stw_s r0,[r14]
L_937d92:
	ldb_s r2,[r2,0x1c]
L_937d94:
	brlt r2,0x2,L_937d9c
L_937d98:
	add_s r0,r0,0xa
L_937d9a:
	stw_s r0,[r14]
	.global L_937d9c
L_937d9c:
	stw_s r1,[r14,0x2]
L_937d9e:
	b.d L_9202a4
L_937da2:
	stw_s r13,[r14,0x4]
