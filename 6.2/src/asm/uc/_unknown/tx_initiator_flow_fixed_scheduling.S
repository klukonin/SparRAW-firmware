/* tx_initiator_flow_fixed_scheduling @ 0x938f10, 496 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_initiator_flow_fixed_scheduling() Starting TX flow
 *   tx_initiator_flow_fixed_scheduling() Check for busy2 (CCA) or energy (RSSI) and abort if found
 *   tx_initiator_flow_fixed_scheduling() tx_bcast_flow
 *   tx_initiator_flow_fixed_scheduling() Starting internal TX
 * Зовут его: fixed_sched__run_tx_slot
 * Зовёт сам: __ld_r13_to_r13_ret, fsched__pick_queue_r41, internal_tx_isr, mac__select_all_sectors_and_wait, sta__get_sweep_byte, tx__cca_check_and_send, tx_bcast_flow, tx_ctx__alloc_next, tx_sta__run_txop, uc_log__emit_snapshot
 * Глобалы (через gp): 0x8005f8, 0x80064c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_initiator_flow_fixed_scheduling
tx_initiator_flow_fixed_scheduling:
	.global L_938f10
L_938f10:
	push_s blink
L_938f12:
	push_s r13
L_938f14:
	sub_s sp,sp,0x8
L_938f16:
	bl.d L_9384d4
L_938f1a:
	mov_s r0,0x1
L_938f1c:
	mov_s r13,r0
L_938f1e:
	bl.d L_9397f0
L_938f22:
	mov_s r0,sp
L_938f24:
	mov_s r1,r0
L_938f26:
	mov_s r0,0x8014a4
L_938f2c:
	ld_s r0,[r0,0x1c]
L_938f2e:
	cmp_s r0,0x0
L_938f30:
	cmp.eq r1,0x0
L_938f34:
	bne_s L_938f9c
L_938f36:
	ld_s r0,[gp,0x124]
L_938f38:
	brne r0,0x4,L_938f9c
L_938f3c:
	ld_s r0,[gp,-0x44]
L_938f3e:
	and r0,r0,0xffff0fff
L_938f46:
	bset r1,r0,0xc
L_938f4a:
	bset_s r1,r1,0xd
L_938f4c:
	or r0,r0,0x1d003000
L_938f54:
	st.as r1,[gp,-0x11]
L_938f58:
	mov_s r32,r0
L_938f5a:
	st.ab r0,[r25,0x4]
L_938f5e:
	bclr r25,r25,0xa
L_938f62:
	nop_s
L_938f64:
	nop_s
L_938f66:
	nop_s
L_938f68:
	extw r0,r40
L_938f6c:
	cmp_s r0,0xb
L_938f6e:
	mov.hi r0,r13
L_938f72:
	mov.hi r1,0x1
L_938f76:
	mov.hi r2,0x0
L_938f7a:
	bl.hi.d L_924d00
L_938f7e:
	mov.hi r3,0x1
L_938f82:
	mov_s r1,0x1
L_938f84:
	mov_s r0,0x80242c
L_938f8a:
	stw_s r1,[r0,0x8]
L_938f8c:
	ldb_s r0,[gp,-0xee]
L_938f8e:
	mov_s r2,0x2
L_938f90:
	mov_s r1,0x8007d4
L_938f96:
	add2_s r1,r1,r0
L_938f98:
	stb_s r2,[r1,0x2]
L_938f9a:
	b_s L_9390f8
	.global L_938f9c
L_938f9c:
	breq_s r1,0,L_938ff0
L_938f9e:
	mov_s r1,0x1001808
L_938fa4:
	bl.d L_92d13c
L_938fa8:
	mov_s r0,0x21
L_938faa:
	bl L_936870
L_938fae:
	mov_s r0,r42
L_938fb0:
	bbit0 r0,0xe,L_93901c
L_938fb4:
	mov_s r1,0x8022c8
L_938fba:
	ld_s r0,[r1,0x4]
L_938fbc:
	mov_s r2,0xc
L_938fbe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938fc0:
	st_s r0,[r1,0x4]
L_938fc2:
	mov_s r1,0x8010b0
L_938fc8:
	ld_s r0,[r1,0x44]
L_938fca:
	st.as 0x800,[gp,0x34]
L_938fd2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938fd4:
	st_s r0,[r1,0x44]
L_938fd6:
	ldb_s r0,[gp,-0xee]
L_938fd8:
	mov_s r1,0x8007d4
L_938fde:
	add2_s r1,r1,r0
L_938fe0:
	stb_s r2,[r1,0x2]
L_938fe2:
	mov_s r1,0x1001738
L_938fe8:
	bl.d L_92d13c
L_938fec:
	mov_s r0,0x21
L_938fee:
	b_s L_9390f8
	.global L_938ff0
L_938ff0:
	mov_s r1,0x8022c8
L_938ff6:
	ld_s r0,[r1,0x8]
L_938ff8:
	mov_s r2,0x3
L_938ffa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938ffc:
	st_s r0,[r1,0x8]
L_938ffe:
	ldb_s r0,[gp,-0xee]
L_939000:
	mov_s r1,0x8007d4
L_939006:
	add2_s r1,r1,r0
L_939008:
	stb_s r2,[r1,0x2]
L_93900a:
	mov_s r0,0xeeee01
L_939010:
	mov_s r32,r0
L_939012:
	st.ab r0,[r25,0x4]
L_939016:
	bclr r25,r25,0xa
L_93901a:
	b_s L_9390f8
	.global L_93901c
L_93901c:
	ld_s r1,[sp,0x0]
L_93901e:
	ld_s r0,[r13,0xc]
L_939020:
	st_s r1,[r13,0x4]
L_939022:
	bset_s r0,r0,0x0
L_939024:
	st_s r0,[r13,0xc]
L_939026:
	mov_s r0,0x802948
L_93902c:
	ld_s r0,[r0]
L_93902e:
	bbit0 r0,r1,L_93903a
L_939032:
	ld_s r0,[gp,0xd0]
L_939034:
	bset_s r0,r0,0x1e
L_939036:
	st.as r0,[gp,0x34]
	.global L_93903a
L_93903a:
	ld_s r1,[r13,0x4]
L_93903c:
	breq r1,0x1f,L_93906c
L_939040:
	ld_s r0,[gp,-0xc0]
L_939042:
	brne r1,r0,L_9390cc
L_939046:
	cmp r0,0xff
L_93904a:
	beq_s L_9390cc
L_93904c:
	ldb_s r0,[gp,-0xee]
L_93904e:
	mov_s r2,0xe
L_939050:
	mov_s r1,0x8007d4
L_939056:
	add2_s r1,r1,r0
L_939058:
	stb_s r2,[r1,0x2]
L_93905a:
	mov_s r1,0x1001840
L_939060:
	bl.d L_92d13c
L_939064:
	mov_s r0,0x21
L_939066:
	bl L_937844
L_93906a:
	b_s L_9390f8
	.global L_93906c
L_93906c:
	mov_s r0,0x80
L_93906e:
	bset_s r0,r0,0x19
L_939070:
	mov_s r32,r0
L_939072:
	st.ab r0,[r25,0x4]
L_939076:
	bclr r25,r25,0xa
L_93907a:
	ldb_s r0,[gp,-0xee]
L_93907c:
	mov_s r2,0xd
L_93907e:
	mov_s r1,0x8007d4
L_939084:
	add2_s r1,r1,r0
L_939086:
	stb_s r2,[r1,0x2]
L_939088:
	mov_s r1,0x1001874
L_93908e:
	bl.d L_92d13c
L_939092:
	mov_s r0,0x21
L_939094:
	mov_s r0,0xeeee03
L_93909a:
	mov_s r32,r0
L_93909c:
	st.ab r0,[r25,0x4]
L_9390a0:
	bclr r25,r25,0xa
L_9390a4:
	bl.d L_92bbfc
L_9390a8:
	mov_s r0,r13
L_9390aa:
	ld_s r0,[gp,-0x48]
L_9390ac:
	or r0,r0,0x27003f00
L_9390b4:
	mov_s r32,r0
L_9390b6:
	st.ab r0,[r25,0x4]
L_9390ba:
	bclr r25,r25,0xa
L_9390be:
	mov_s r1,0x8010b0
L_9390c4:
	ld_s r0,[r1,0x48]
L_9390c6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9390c8:
	st_s r0,[r1,0x48]
L_9390ca:
	b_s L_9390f8
	.global L_9390cc
L_9390cc:
	add_s r1,sp,0x4
L_9390ce:
	bl.d L_93dad0
L_9390d2:
	ldb_s r0,[sp,0x0]
L_9390d4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9390d6:
	add2_s r0,r0,r0
L_9390d8:
	add_s r0,r0,0x801104
L_9390de:
	ldb r1,[r0, 0x4b]
L_9390e2:
	breq_s r1,0,L_9390f2
L_9390e4:
	ld_s r1,[r0,0x18]
L_9390e6:
	ld_s r0,[sp,0x0]
L_9390e8:
	bbit0 r1,r0,L_9390f2
L_9390ec:
	ld_s r0,[r13,0xc]
L_9390ee:
	bset_s r0,r0,0xb
L_9390f0:
	st_s r0,[r13,0xc]
	.global L_9390f2
L_9390f2:
	bl.d L_93a088
L_9390f6:
	mov_s r0,r13
	.global L_9390f8
L_9390f8:
	b.d L_9202ac
L_9390fc:
	add_s sp,sp,0x8
L_9390fe:
	nop_s
