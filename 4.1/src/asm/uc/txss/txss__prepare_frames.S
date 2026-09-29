/* txss__prepare_frames @ 0x936074, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txss.c
 * Зовут его: txss__flow_body
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_substate__set, mac__select_sector_and_wait_b, mac_mode__switch_core_and_rf, rx_flow__run, sxd_hal__mac_select_indexed, sxd_hal__mac_write_indexed, txss_copy_step, uc_sysassert, uc_wait_event1_or_event4
 */
	.section .text.txss__prepare_frames,"ax",@progbits
	.global txss__prepare_frames
txss__prepare_frames:
	.global L_936074
L_936074:
	push_s blink
L_936076:
	bl L_920210
L_93607a:
	mov_s r14,r0
L_93607c:
	mov_s r15,r1
L_93607e:
	mov_s r13,0x0
L_936080:
	mov_s r0,0x20d2200
L_936086:
	mov_s r32,r0
L_936088:
	st.ab r0,[r25,0x4]
L_93608c:
	bclr r25,r25,0xa
L_936090:
	bl.d L_931664
L_936094:
	mov_s r0,0x5
L_936096:
	mov_s r0,0x0
L_936098:
	bl.d L_9306ac
L_93609c:
	mov_s r1,r15
L_93609e:
	mov_s r1,0x29995
L_9360a4:
	bl.d L_9306ac
L_9360a8:
	mov_s r0,0x1
L_9360aa:
	b_s L_9360b8
	.global L_9360ac
L_9360ac:
	bl.d L_930f44
L_9360b0:
	mov_s r13,0x1
L_9360b2:
	bl.d L_9250a8
L_9360b6:
	mov_s r0,0x0
	.global L_9360b8
L_9360b8:
	mov_s r0,0x0
L_9360ba:
	bset_s r0,r0,0x13
L_9360bc:
	mov_s r1,0xc1
L_9360be:
	bl.d L_9318f4
L_9360c2:
	mov_s r2,0x0
L_9360c4:
	mov_s r0,r54
L_9360c6:
	bbit1 r0,0x0,L_93611e
L_9360ca:
	mov_s r0,r42
L_9360cc:
	bbit0 r0,0x13,L_936106
L_9360d0:
	bl L_92ce9c
L_9360d4:
	mov_s r0,0x801038
L_9360da:
	ld_s r0,[r0]
L_9360dc:
	bbit1 r0,0x2,L_9360ea
L_9360e0:
	bbit0 r0,0x4,L_93610c
L_9360e4:
	mov_s r0,r14
L_9360e6:
	mov_s r1,0x8
L_9360e8:
	b_s L_936152
	.global L_9360ea
L_9360ea:
	brne_s r13,0,L_9360f2
	.global L_9360ec
L_9360ec:
	mov_s r0,r14
L_9360ee:
	mov_s r1,0x7
L_9360f0:
	b_s L_936152
	.global L_9360f2
L_9360f2:
	mov_s r0,blink
L_9360f4:
	mov_s r2,0x1002304
L_9360fa:
	mov_s r1,0x89
L_9360fc:
	bl.d L_925548
L_936100:
	mov r3,0x1f9
L_936104:
	b_s L_9360ec
	.global L_936106
L_936106:
	mov_s r0,r54
L_936108:
	bbit1 r0,0x6,L_936134
	.global L_93610c
L_93610c:
	mov_s r1,r54
L_93610e:
	mov_s r0,0x801038
L_936114:
	bbit0 r1,0x7,L_93611e
L_936118:
	ld_s r0,[r0]
L_93611a:
	bbit0 r0,0x1,L_93615a
	.global L_93611e
L_93611e:
	mov_s r0,r54
L_936120:
	mov_s r1,0x801038
L_936126:
	bbit1 r0,0x0,L_936166
L_93612a:
	ld_s r0,[r1]
L_93612c:
	bbit1 r0,0x1,L_936166
L_936130:
	mov_s r0,0x0
L_936132:
	b_s L_936168
	.global L_936134
L_936134:
	brne_s r13,0,L_93613c
	.global L_936136
L_936136:
	mov_s r0,r14
L_936138:
	mov_s r1,0x2
L_93613a:
	b_s L_936152
	.global L_93613c
L_93613c:
	mov_s r0,blink
L_93613e:
	mov_s r2,0x1002304
L_936144:
	mov r1,0x102
L_936148:
	bl.d L_925548
L_93614c:
	mov r3,0x207
L_936150:
	b_s L_936136
	.global L_936152
L_936152:
	bl L_930dc4
L_936156:
	mov_s r0,0x0
L_936158:
	b_s L_9361c6
	.global L_93615a
L_93615a:
	bl.d L_9250a8
L_93615e:
	mov_s r0,0x1
L_936160:
	mov_s r0,r14
L_936162:
	mov_s r1,0x3
L_936164:
	b_s L_936152
	.global L_936166
L_936166:
	mov_s r0,0x1
	.global L_936168
L_936168:
	extb.f 0x0,r0
L_93616c:
	ld_s r0,[r1]
L_93616e:
	bne_s L_93617c
L_936170:
	bbit0 r0,0x0,L_9361ca
L_936174:
	bclr_s r0,r0,0x0
L_936176:
	st_s r0,[r1]
L_936178:
	mov_s r0,0x1
L_93617a:
	b_s L_9361cc
	.global L_93617c
L_93617c:
	bbit1 r0,0x1,L_936194
L_936180:
	mov_s r1,0x801198
L_936186:
	asl_s r0,r14,0x3
L_936188:
	add3_s r0,r0,r0
L_93618a:
	bl.d L_92a9f4
L_93618e:
	ld_s r0,[r1,r0]
L_936190:
	mov_s r0,0x0
L_936192:
	b_s L_936196
	.global L_936194
L_936194:
	mov_s r0,0x1
	.global L_936196
L_936196:
	st.as r0,[gp,-0x1e]
L_93619a:
	mov_s r0,0x3e
L_93619c:
	asl_s r0,r0,0x18
L_93619e:
	mov_s r32,r0
L_9361a0:
	st.ab r0,[r25,0x4]
L_9361a4:
	bclr r25,r25,0xa
L_9361a8:
	mov_s r0,0x37000020
L_9361ae:
	mov_s r32,r0
L_9361b0:
	st.ab r0,[r25,0x4]
L_9361b4:
	bclr r25,r25,0xa
L_9361b8:
	mov_s r1,0x801458
L_9361be:
	ld_s r0,[r1,0xc]
L_9361c0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9361c2:
	st_s r0,[r1,0xc]
L_9361c4:
	mov_s r0,0x1
	.global L_9361c6
L_9361c6:
	b L_92027c
	.global L_9361ca
L_9361ca:
	mov_s r0,0x0
	.global L_9361cc
L_9361cc:
	cmp_s r0,0x1
L_9361ce:
	bne_s L_9360b8
L_9361d0:
	b_s L_9360ac
L_9361d2:
	nop_s
