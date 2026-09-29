/* sm_pring__eop_evt @ 0x8c8108, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Spurious event of PRING EOP at <%d> - do nothing.
 *   sm_pring_connectivity.cpp
 * Зовут его: pring__on_eop
 * Зовёт сам: __ld_r13_ret, dma_is_idle, fw_log__emit1, fw_read_timer, fw_sysassert_fatal, tx_macq__is_empty, u_schd__cancel, u_schd__schedule, vring__reg_write_locked_28, vring__reg_write_locked_3c, vring__teardown, vring_by_index
 * Глобалы (через gp): 0x800334
 */
	.section .text.sm_pring__eop_evt,"ax",@progbits
	.global sm_pring__eop_evt
sm_pring__eop_evt:
	.byte 0x0f
	.byte 0xfc
L_8c810a:
	nop_s
	.global L_8c810c
L_8c810c:
	push_s blink
L_8c810e:
	push_s r13
L_8c8110:
	bl.d L_8e4694
L_8c8114:
	mov_s r13,r0
L_8c8116:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c8118:
	st_s r0,[r13,0x34]
L_8c811a:
	ld_s r0,[r13,0x1c]
L_8c811c:
	breq_s r0,0,L_8c8126
L_8c811e:
	bl L_8c7794
L_8c8122:
	mov_s r0,0x0
L_8c8124:
	st_s r0,[r13,0x1c]
	.global L_8c8126
L_8c8126:
	ld_s r1,[r13,0x18]
L_8c8128:
	brhs r1,0x5,L_8c81b2
L_8c812c:
	ldb.x r1,[0x801f54,r1]
L_8c8134:
	add r0,pcl,0x8
L_8c8138:
	add1_s r0,r0,r1
L_8c813a:
	j_s [r0]
L_8c813c:
	ldw_s r0,[r13]
L_8c813e:
	mov_s r12,0x1
L_8c8140:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c8142:
	asl r0,r12,r0
L_8c8146:
	bl.d L_8cd6ac
L_8c814a:
	mov_s r1,0x1
L_8c814c:
	bl.d L_8cacc0
L_8c8150:
	ldw_s r0,[r13,0x2]
L_8c8152:
	bl.d L_8d7084
L_8c8156:
	mov_s r1,0x0
L_8c8158:
	ldw_s r0,[r13]
L_8c815a:
	bl.d L_8cdaf8
L_8c815e:
	mov_s r1,0x0
L_8c8160:
	brne_s r0,0,L_8c8192
L_8c8162:
	ld.as r4,[gp,0x71]
L_8c8166:
	mov_s r0,0x1cc50
L_8c816c:
	ldw_s r1,[r13]
L_8c816e:
	mov_s r2,0x0
L_8c8170:
	mov_s r3,0x1
L_8c8172:
	mov r5,0x0
L_8c8176:
	bl.d L_8dc92c
L_8c817a:
	mov r6,0x0
L_8c817e:
	st_s r0,[r13,0x20]
L_8c8180:
	ldw_s r0,[r13]
L_8c8182:
	mov_s r12,0x1
L_8c8184:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c8186:
	asl r0,r12,r0
L_8c818a:
	bl.d L_8cd6dc
L_8c818e:
	mov_s r1,0x1
L_8c8190:
	b_s L_8c81c8
	.global L_8c8192
L_8c8192:
	bl.d L_8c5b94
L_8c8196:
	mov_s r0,r13
L_8c8198:
	b_s L_8c81c8
L_8c819a:
	bl L_8e4694
L_8c819e:
	mov_s r2,0x100ee58
L_8c81a4:
	mov_s r3,r0
L_8c81a6:
	mov_s r0,0x7
L_8c81a8:
	mov_s r1,0x2
L_8c81aa:
	/* bl.d 0x008edfcc */
	.byte 0x26,0x0e,0xe0,0x12
L_8c81ae:
	/* _asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8c81b0:
	b_s L_8c81c8
	.global L_8c81b2
L_8c81b2:
	mov_s r0,blink
L_8c81b4:
	mov_s r2,0x100ec18
L_8c81ba:
	mov_s r1,0x12a6
L_8c81c0:
	bl.d L_8c82c0
L_8c81c4:
	mov r3,0x156
	.global L_8c81c8
L_8c81c8:
	b L_8c033c
