/* mac_counter__program_0008 @ 0x933f90, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/ucode/inc/sxd_utils.h
 * Зовут его: mac__prepare_txrx_window, rx_funcs__rx_flow, tx_flows__program_mac_tx, tx_initiator_rx_step, tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, mac__program_tx_with_qid, uc_sysassert
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.mac_counter__program_0008,"ax",@progbits
	.global mac_counter__program_0008
mac_counter__program_0008:
	.global L_933f90
L_933f90:
	push_s blink
L_933f92:
	bl L_92020c
L_933f96:
	mov_s r14,r0
L_933f98:
	push_s r1
L_933f9a:
	ld_s r0,[r0,0xc]
L_933f9c:
	btst_s r0,0x1
L_933f9e:
	beq_s L_93408e
L_933fa0:
	mov_s r0,0x886500
L_933fa6:
	ld_s r0,[r0,0x6c]
L_933fa8:
	ld_s r15,[r14]
L_933faa:
	bmsk.f 0x0,r0,0x3
L_933fae:
	ld_s r13,[r14,0x4]
L_933fb0:
	ld r16,[r14, 0x1c]
L_933fb4:
	beq_s L_933fc8
L_933fb6:
	mov_s r0,blink
L_933fb8:
	mov_s r2,0x1001c78
L_933fbe:
	mov_s r1,0x3
L_933fc0:
	bl.d L_925548
L_933fc4:
	mov r3,0x154
	.global L_933fc8
L_933fc8:
	mov_s r0,0x1c000006
L_933fce:
	mov_s r32,r0
L_933fd0:
	st.ab r0,[r25,0x4]
L_933fd4:
	bclr r25,r25,0xa
L_933fd8:
	or r0,r16,0x46000008
L_933fe0:
	asl_s r1,r13,0x4
L_933fe2:
	or_s r1,r1,r0
L_933fe4:
	ld_s r0,[sp,0x0]
L_933fe6:
	asl_s r0,r0,0xc
L_933fe8:
	or_s r0,r0,r1
L_933fea:
	mov_s r32,r0
L_933fec:
	st.ab r0,[r25,0x4]
L_933ff0:
	bclr r25,r25,0xa
L_933ff4:
	mov_s r1,0x801458
L_933ffa:
	ld_s r0,[r1,0x14]
L_933ffc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933ffe:
	st_s r0,[r1,0x14]
	.global L_934000
L_934000:
	mov_s r0,r53
L_934002:
	bbit0 r0,0x2,L_934000
L_934006:
	ld_s r0,[gp,-0x44]
L_934008:
	and r0,r0,0xfff0ffff
L_934010:
	bset r1,r0,0x10
L_934014:
	or r0,r0,0x1d010000
L_93401c:
	st.as r1,[gp,-0x11]
L_934020:
	mov_s r32,r0
L_934022:
	st.ab r0,[r25,0x4]
L_934026:
	bclr r25,r25,0xa
L_93402a:
	nop_s
L_93402c:
	nop_s
L_93402e:
	nop_s
	.global L_934030
L_934030:
	mov_s r0,r47
L_934032:
	bbit1 r0,0x0,L_934030
L_934036:
	asl_s r15,r15,0x8
L_934038:
	bset_s r15,r15,0x1a
L_93403a:
	bset_s r15,r15,0x1e
L_93403c:
	or_s r13,r13,r15
L_93403e:
	bset_s r13,r13,0x13
L_934040:
	bset_s r13,r13,0x15
L_934042:
	mov_s r32,r13
L_934044:
	st.ab r13,[r25,0x4]
L_934048:
	bclr r25,r25,0xa
L_93404c:
	mov_s r0,0x45000001
L_934052:
	mov_s r32,r0
L_934054:
	st.ab r0,[r25,0x4]
L_934058:
	bclr r25,r25,0xa
L_93405c:
	mov_s r0,0x460001f1
L_934062:
	mov_s r32,r0
L_934064:
	st.ab r0,[r25,0x4]
L_934068:
	bclr r25,r25,0xa
L_93406c:
	bl.d L_92a36c
L_934070:
	ld_s r0,[r14,0x4]
	.global L_934072
L_934072:
	mov_s r0,r43
L_934074:
	bbit0 r0,0x1f,L_934072
L_934078:
	mov_s r0,r51
L_93407a:
	bmsk r1,r0,0x3
L_93407e:
	st.as r1,[gp,0x3a]
L_934082:
	lsr_s r0,r0,0x4
L_934084:
	st.as r0,[gp,0x3b]
	.global L_934088
L_934088:
	mov_s r0,r45
L_93408a:
	bbit0 r0,0x1f,L_934088
	.global L_93408e
L_93408e:
	ld_s r0,[r14,0xc]
L_934090:
	bic r0,r0,0x7
L_934094:
	st_s r0,[r14,0xc]
L_934096:
	b.d L_920274
L_93409a:
	add_s sp,sp,0x4
