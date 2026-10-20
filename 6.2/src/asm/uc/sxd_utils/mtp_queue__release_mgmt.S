/* mtp_queue__release_mgmt @ 0x93ea40, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Error: MTP Queue is empty
 * Зовут его: tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mtp_queue__byte_by_index, uc_log__emit_snapshot, uc_sysassert
 * Глобалы (через gp): 0x8005f4, 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mtp_queue__release_mgmt
mtp_queue__release_mgmt:
	.global L_93ea40
L_93ea40:
	push_s blink
L_93ea42:
	bl L_92022c
L_93ea46:
	mov_s r14,r0
L_93ea48:
	mov_s r16,r1
L_93ea4a:
	mov.f r0,r2
L_93ea4e:
	mov_s r13,0x0
L_93ea50:
	mov.ne r0,0x1
L_93ea54:
	asl_s r0,r0
L_93ea56:
	cmp_s r3,0x0
L_93ea58:
	ld_s r15,[r14,0x4]
L_93ea5a:
	ld_s r1,[r14]
L_93ea5c:
	beq_s L_93eb20
L_93ea5e:
	mov_s r2,0x802610
L_93ea64:
	asl_s r0,r1,0x2
L_93ea66:
	add1_s r0,r0,r0
L_93ea68:
	ld_s r0,[r2,r0]
L_93ea6a:
	asl_s r15,r15,0x10
L_93ea6c:
	sub.f r0,r0,0x0
L_93ea70:
	mov.ne r0,0x1
L_93ea74:
	extb.f 0x0,r0
L_93ea78:
	bset_s r15,r15,0x2
L_93ea7a:
	beq_s L_93ea88
L_93ea7c:
	bl.d L_92ff68
L_93ea80:
	mov_s r0,r1
L_93ea82:
	asl_s r0,r0,0x8
L_93ea84:
	or r13,r0,0x3
	.global L_93ea88
L_93ea88:
	mov_s r0,0x1b001111
L_93ea8e:
	mov_s r32,r0
L_93ea90:
	st.ab r0,[r25,0x4]
L_93ea94:
	bclr r25,r25,0xa
L_93ea98:
	bset_s r15,r15,0x19
L_93ea9a:
	bset_s r15,r15,0x1a
L_93ea9c:
	bset_s r15,r15,0x1c
L_93ea9e:
	mov_s r32,r15
L_93eaa0:
	st.ab r15,[r25,0x4]
L_93eaa4:
	bclr r25,r25,0xa
L_93eaa8:
	or r13,r13,0x17000000
L_93eab0:
	mov_s r32,r13
L_93eab2:
	st.ab r13,[r25,0x4]
L_93eab6:
	bclr r25,r25,0xa
L_93eaba:
	nop_s
L_93eabc:
	nop_s
L_93eabe:
	nop_s
	.global L_93eac0
L_93eac0:
	mov_s r0,r43
L_93eac2:
	bbit0 r0,0x1f,L_93eac0
L_93eac6:
	mov_s r0,r51
L_93eac8:
	bmsk r1,r0,0x3
L_93eacc:
	st.as r1,[gp,0x38]
L_93ead0:
	lsr_s r0,r0,0x4
L_93ead2:
	st.as r0,[gp,0x39]
L_93ead6:
	lsr r0,r43,0x10
L_93eada:
	bmsk r1,r0,0x4
L_93eade:
	st r1,[r16]
L_93eae2:
	mov_s r0,0xeeee0d
L_93eae8:
	mov_s r32,r0
L_93eaea:
	st.ab r0,[r25,0x4]
L_93eaee:
	bclr r25,r25,0xa
	.global L_93eaf2
L_93eaf2:
	mov_s r0,r45
L_93eaf4:
	bbit0 r0,0x1f,L_93eaf2
L_93eaf8:
	lsr r0,r45
L_93eafc:
	bxor r0,r0,0x0
L_93eb00:
	ld_s r15,[r14,0x18]
L_93eb02:
	extb r1,r45
L_93eb06:
	and_s r15,r15,r1
L_93eb08:
	cmp_s r15,0x0
L_93eb0a:
	mov_s r15,0x1
L_93eb0c:
	sub_s.ne r15,r15,r15
L_93eb0e:
	bbit1 r0,0x0,L_93eb6c
L_93eb12:
	mov_s r1,0x10006a4
L_93eb18:
	bl.d L_92d13c
L_93eb1c:
	mov_s r0,0x6
L_93eb1e:
	b_s L_93ebae
	.global L_93eb20
L_93eb20:
	ld_s r2,[r14,0x8]
L_93eb22:
	asl_s r15,r15,0x10
L_93eb24:
	brne r0,0x2,L_93eb32
L_93eb28:
	or r15,r15,0x103
	.global L_93eb2c
L_93eb2c:
	asl r13,r2,0x10
L_93eb30:
	b_s L_93eb3c
	.global L_93eb32
L_93eb32:
	cmp_s r0,0x1
L_93eb34:
	or.eq r15,r15,0x3
L_93eb38:
	beq_s L_93eb2c
L_93eb3a:
	bset_s r15,r15,0x0
	.global L_93eb3c
L_93eb3c:
	ld_s r0,[gp,0xcc]
L_93eb3e:
	bbit0 r0,0x1,L_93ea88
L_93eb42:
	asl_s r0,r1,0x2
L_93eb44:
	add1_s r0,r0,r0
L_93eb46:
	mov_s r2,0x802610
L_93eb4c:
	ld_s r0,[r2,r0]
L_93eb4e:
	sub.f r0,r0,0x0
L_93eb52:
	mov.ne r0,0x1
L_93eb56:
	extb.f 0x0,r0
L_93eb5a:
	beq_s L_93ea88
L_93eb5c:
	bl.d L_92ff68
L_93eb60:
	mov_s r0,r1
L_93eb62:
	asl_s r0,r0,0x8
L_93eb64:
	or r0,r0,0x3
L_93eb68:
	or_s r13,r13,r0
L_93eb6a:
	b_s L_93ea88
	.global L_93eb6c
L_93eb6c:
	lsr r13,r43,0x8
L_93eb70:
	bmsk_s r13,r13,0x3
L_93eb72:
	brhs.d r13,0x8,L_93ebb4
L_93eb76:
	st_s r13,[r14]
	.global L_93eb78
L_93eb78:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_93eb7a:
	add2_s r13,r13,r13
L_93eb7c:
	add_s r13,r13,0x801104
L_93eb82:
	ld_s r1,[r13,0x10]
L_93eb84:
	mov_s r0,0x802288
L_93eb8a:
	st r1,[r16, 0x4]
L_93eb8e:
	ld_s r1,[r13,0x8]
L_93eb90:
	st r1,[r16, 0x8]
L_93eb94:
	ld_s r1,[r13,0x4]
L_93eb96:
	st_s r1,[r0,0x8]
L_93eb98:
	mov_s r0,0x80141c
L_93eb9e:
	ld_s r0,[r0,0x8]
L_93eba0:
	bbit1 r0,0x0,L_93eba6
L_93eba4:
	st_s r1,[r14,0x2c]
	.global L_93eba6
L_93eba6:
	lsr r0,r43,0x4
L_93ebaa:
	bmsk_s r0,r0,0x3
L_93ebac:
	st_s r0,[r14,0x28]
	.global L_93ebae
L_93ebae:
	b.d L_920294
L_93ebb2:
	mov_s r0,r15
	.global L_93ebb4
L_93ebb4:
	mov_s r0,blink
L_93ebb6:
	bl.d L_926618
L_93ebba:
	mov_s r1,0x8
L_93ebbc:
	b_s L_93eb78
	.byte 0x00
	.byte 0x00
