/* vring_schd__stop_vring @ 0x8e80cc, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VR_SCHDLR received STOP command for V-ring #%d.
 * Зовут его: sm_pring__notify_vring_state, vring__stop_hw, vring_schd__move_to_ready, vring_schd__prohibit_cids
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, fw_sysassert_fatal, list__find_entry_d, lmac_if_echo_evt_handler, sm_pring__state_step, tx_list__remove, u_schd__add, vring__ack_and_unmask_irq, vring_list__find, vring_schd__find_by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__stop_vring
vring_schd__stop_vring:
	.global L_8e80cc
L_8e80cc:
	b.d L_8ea69c
L_8e80d0:
	mov_s r0,r1
L_8e80d2:
	nop_s
L_8e80d4:
	push_s blink
L_8e80d6:
	bl.d L_8c01d8
L_8e80da:
	mov_s r0,0x27
L_8e80dc:
	sub_s sp,sp,0x8
L_8e80de:
	mov_s r17,r1
L_8e80e0:
	mov_s r1,0x100bbe4
L_8e80e6:
	bl.d L_8dcc10
L_8e80ea:
	mov_s r2,r17
L_8e80ec:
	mov_s r13,0x804dbc
L_8e80f2:
	mov_s r15,sp
L_8e80f4:
	add_s r3,sp,0x4
L_8e80f6:
	mov_s r0,r13
L_8e80f8:
	mov_s r1,r17
L_8e80fa:
	bl.d L_8ebebc
L_8e80fe:
	mov_s r2,r15
L_8e8100:
	brne r0,0x1,L_8e8120
L_8e8104:
	ld_s r0,[sp,0x0]
L_8e8106:
	mov_s r1,0x0
L_8e8108:
	st_s r1,[r0,0x20]
L_8e810a:
	ld_s r1,[sp,0x0]
L_8e810c:
	ld_s r0,[r1,0x24]
L_8e810e:
	brne r0,0x3,L_8e8196
L_8e8112:
	mov_s r0,0x4
L_8e8114:
	st_s r0,[r1,0x24]
L_8e8116:
	mov_s r0,r13
L_8e8118:
	bl.d L_8e80cc
L_8e811c:
	ld_s r1,[sp,0x4]
L_8e811e:
	b_s L_8e8196
	.global L_8e8120
L_8e8120:
	mov_s r14,0x2
L_8e8122:
	b_s L_8e8140
	.global L_8e8124
L_8e8124:
	asl_s r1,r14,0x2
L_8e8126:
	add1_s r1,r1,r1
L_8e8128:
	add r0,r13,0x10
L_8e812c:
	add r16,r0,r1
L_8e8130:
	mov_s r0,r13
L_8e8132:
	mov_s r1,r16
L_8e8134:
	mov_s r2,r17
L_8e8136:
	bl.d L_8ebe80
L_8e813a:
	mov_s r3,r15
L_8e813c:
	breq r0,0x1,L_8e814a
	.global L_8e8140
L_8e8140:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8e8142:
	cmp r14,-0x1
L_8e8146:
	bne_s L_8e8124
L_8e8148:
	b_s L_8e8152
	.global L_8e814a
L_8e814a:
	mov_s r0,r16
L_8e814c:
	bl.d L_8e2884
L_8e8150:
	ld_s r1,[sp,0x0]
	.global L_8e8152
L_8e8152:
	ld_s r1,[sp,0x0]
L_8e8154:
	breq_s r1,0,L_8e8164
L_8e8156:
	bl.d L_8c25f4
L_8e815a:
	add_s r0,r13,0x4
L_8e815c:
	bl.d L_8d85d4
L_8e8160:
	ld_s r0,[sp,0x0]
L_8e8162:
	b_s L_8e8180
	.global L_8e8164
L_8e8164:
	mov_s r0,r13
L_8e8166:
	add_s r1,r13,0x4
L_8e8168:
	mov_s r2,r17
L_8e816a:
	bl.d L_8ebe80
L_8e816e:
	mov_s r3,r15
L_8e8170:
	brne_s r0,0,L_8e8180
L_8e8172:
	mov_s r0,blink
L_8e8174:
	mov_s r1,0x12b9
L_8e817a:
	bl L_8c9b28
L_8e817e:
	b_s L_8e8196
	.global L_8e8180
L_8e8180:
	ld_s r0,[sp,0x0]
L_8e8182:
	mov_s r2,0x0
L_8e8184:
	st_s r2,[r0,0x20]
L_8e8186:
	ld_s r1,[sp,0x0]
L_8e8188:
	mov_s r0,L_8e23a4-0x8c0000
L_8e818e:
	ldb_s r1,[r1,0x9]
L_8e8190:
	bl.d L_8c3248
L_8e8194:
	mov_s r3,0x1
	.global L_8e8196
L_8e8196:
	b.d L_8c023c
L_8e819a:
	add_s sp,sp,0x8
L_8e819c:
	mov_s r0,r1
L_8e819e:
	b.d L_8db79c
L_8e81a2:
	mov_s r1,0x0
