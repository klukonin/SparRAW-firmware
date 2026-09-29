/* bcon_sweep_step_a @ 0x932ee0, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, mac__program_tx_beacon
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.bcon_sweep_step_a,"ax",@progbits
	.global bcon_sweep_step_a
bcon_sweep_step_a:
	.global L_932ee0
L_932ee0:
	push_s blink
L_932ee2:
	bl L_920214
L_932ee6:
	mov_s r14,r0
L_932ee8:
	mov_s r0,0x1500ffff
L_932eee:
	mov_s r32,r0
L_932ef0:
	st.ab r0,[r25,0x4]
L_932ef4:
	bclr r25,r25,0xa
L_932ef8:
	mov_s r0,0x14000007
L_932efe:
	mov_s r32,r0
L_932f00:
	st.ab r0,[r25,0x4]
L_932f04:
	bclr r25,r25,0xa
L_932f08:
	bl L_92a2d4
	.global L_932f0c
L_932f0c:
	mov_s r0,r43
L_932f0e:
	bbit0 r0,0x1f,L_932f0c
L_932f12:
	mov_s r0,r51
L_932f14:
	bmsk r1,r0,0x3
L_932f18:
	st.as r1,[gp,0x3a]
L_932f1c:
	lsr_s r0,r0,0x4
L_932f1e:
	st.as r0,[gp,0x3b]
L_932f22:
	mov_s r0,0x886d00
L_932f28:
	ld_s r13,[r0,0xc]
L_932f2a:
	lsr_s r13,r13,0x18
	.global L_932f2c
L_932f2c:
	mov_s r0,r45
L_932f2e:
	bbit0 r0,0x1f,L_932f2c
L_932f32:
	ld_s r0,[gp,-0x44]
L_932f34:
	and r0,r0,0xfff0ffff
L_932f3c:
	bset r1,r0,0x13
L_932f40:
	or r0,r0,0x1d080000
L_932f48:
	st.as r1,[gp,-0x11]
L_932f4c:
	mov_s r32,r0
L_932f4e:
	st.ab r0,[r25,0x4]
L_932f52:
	bclr r25,r25,0xa
L_932f56:
	nop_s
L_932f58:
	nop_s
L_932f5a:
	nop_s
	.global L_932f5c
L_932f5c:
	mov_s r0,r47
L_932f5e:
	bbit0 r0,0x1f,L_932f5c
L_932f62:
	mov_s r1,r47
L_932f64:
	mov_s r0,0x801a9c
L_932f6a:
	ld_s r3,[r0,0x5c]
L_932f6c:
	extw_s r2,r1
L_932f6e:
	mul64 r3,0x1c
L_932f72:
	add_s r0,r0,0x1a
L_932f74:
	add_s r2,r2,r13
L_932f76:
	ldw r0,[r0,mlo]
L_932f7a:
	stw_s r1,[r14,0x2]
L_932f7c:
	mulu64 r2,r0
L_932f80:
	sub r0,mlo,r13
L_932f84:
	stw_s r0,[r14]
L_932f86:
	b.d L_920284
L_932f8a:
	stw_s r13,[r14,0x4]
