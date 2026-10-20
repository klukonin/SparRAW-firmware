/* bf_sm__dispatch_by_state @ 0x921fa8, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__run_sta
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_sm__on_brp_init, bf_sm__on_brp_resp, bf_sm__on_txss_init, bf_sm__on_txss_resp, bf_sm__set_sta_state, sta__apply_rx_sector_and_mcs
 * Глобалы (через gp): 0x8005b8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__dispatch_by_state
bf_sm__dispatch_by_state:
	.global L_921fa8
L_921fa8:
	push_s blink
L_921faa:
	bl L_920230
L_921fae:
	asl_s r15,r0,0x2
L_921fb0:
	add2_s r15,r15,r15
L_921fb2:
	add_s r15,r15,0x801ffc
L_921fb8:
	ld_s r1,[r15,0x4]
L_921fba:
	mov_s r14,r0
L_921fbc:
	ld_s r0,[r15]
L_921fbe:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_921fc0:
	or_s r0,r0,r1
L_921fc2:
	bmsk_s r0,r0,0xb
L_921fc4:
	or r0,r0,0xfcf000
L_921fcc:
	mov_s r32,r0
L_921fce:
	st.ab r0,[r25,0x4]
L_921fd2:
	bclr r25,r25,0xa
L_921fd6:
	ld_s r0,[r15]
L_921fd8:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_921fda:
	brhs r0,0x8,L_922092
L_921fde:
	ldb.x r0,[0x8019c4,r0]
L_921fe6:
	add r1,pcl,0xa
L_921fea:
	add1_s r1,r1,r0
L_921fec:
	j_s [r1]
L_921fee:
	bl.d L_93b8d0
L_921ff2:
	mov_s r0,r14
L_921ff4:
	mov_s r13,r0
L_921ff6:
	brne r0,0x1,L_922094
L_921ffa:
	asl_s r0,r14,0x4
L_921ffc:
	add2_s r0,r0,r0
L_921ffe:
	mov_s r1,0x80114c
L_922004:
	ldb_s r0,[r1,r0]
L_922006:
	brne_s r0,0,L_922050
L_922008:
	mov_s r1,0x0
L_92200a:
	ldw_s r0,[gp,0x90]
L_92200c:
	bset r1,r1,r14
L_922010:
	tst_s r0,r1
L_922012:
	bne_s L_922078
L_922014:
	mov_s r0,0x8021d8
L_92201a:
	ldb_s r0,[r0,0x5]
L_92201c:
	brne r0,0x1,L_922078
L_922020:
	mov_s r0,0x80218c
L_922026:
	ldb_s r0,[r0,0x8]
L_922028:
	tst_s r0,r1
L_92202a:
	beq_s L_922078
L_92202c:
	mov_s r0,r14
L_92202e:
	bl.d L_92b220
L_922032:
	mov_s r1,0x9
L_922034:
	b_s L_922094
L_922036:
	bl.d L_93be28
L_92203a:
	mov_s r0,r14
L_92203c:
	mov_s r13,r0
L_92203e:
	brne r0,0x1,L_922094
L_922042:
	asl_s r0,r14,0x4
L_922044:
	add2_s r0,r0,r0
L_922046:
	mov_s r1,0x80114c
L_92204c:
	ldb_s r0,[r1,r0]
L_92204e:
	breq_s r0,0,L_922058
	.global L_922050
L_922050:
	bl.d L_926960
L_922054:
	mov_s r0,r14
L_922056:
	b_s L_922078
	.global L_922058
L_922058:
	asl_s r0,r14,0x2
L_92205a:
	add2_s r0,r0,r0
L_92205c:
	mov_s r1,0x802005
L_922062:
	ldb_s r0,[r1,r0]
L_922064:
	brlt r0,0x1,L_922078
L_922068:
	ldw_s r0,[gp,0x90]
L_92206a:
	bbit1 r0,r14,L_922078
L_92206e:
	mov_s r0,r14
L_922070:
	bl.d L_92b220
L_922074:
	mov_s r1,0xa
L_922076:
	b_s L_922094
	.global L_922078
L_922078:
	mov_s r13,0x3
L_92207a:
	b_s L_922094
L_92207c:
	bl.d L_9224dc
L_922080:
	mov_s r0,r14
	.global L_922082
L_922082:
	mov_s r13,r0
L_922084:
	brne r0,0x1,L_922094
L_922088:
	b_s L_922078
L_92208a:
	bl.d L_922e9c
L_92208e:
	mov_s r0,r14
L_922090:
	b_s L_922082
	.global L_922092
L_922092:
	mov_s r13,0x2
	.global L_922094
L_922094:
	ld_s r0,[r15,0x4]
L_922096:
	ld_s r1,[r15]
L_922098:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_92209a:
	or_s r0,r0,r1
L_92209c:
	bmsk_s r0,r0,0xb
L_92209e:
	or r0,r0,0xfcc000
L_9220a6:
	mov_s r32,r0
L_9220a8:
	st.ab r0,[r25,0x4]
L_9220ac:
	bclr r25,r25,0xa
L_9220b0:
	mov_s r0,0x52
L_9220b2:
	asl_s r0,r0,0x18
L_9220b4:
	mov_s r32,r0
L_9220b6:
	st.ab r0,[r25,0x4]
L_9220ba:
	bclr r25,r25,0xa
L_9220be:
	mov_s r0,0x53
L_9220c0:
	asl_s r0,r0,0x18
L_9220c2:
	mov_s r32,r0
L_9220c4:
	st.ab r0,[r25,0x4]
L_9220c8:
	bclr r25,r25,0xa
L_9220cc:
	b.d L_92029c
L_9220d0:
	mov_s r0,r13
L_9220d2:
	nop_s
