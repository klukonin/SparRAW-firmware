/* tx_bcon__update_bcon @ 0x8c2190, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Update TX Beacon mid %d, send length %d, PCP_assoc_ready %d
 *   tx_bcon.cpp
 *   Add TX Beacon mid %d, send length %d, PCP_assoc_ready %d
 * Зовут его: fw_scheduled_dti__update_ie, mid__update_aw_ie, pcp_restart, pcp_start
 * Зовёт сам: TX_API__alloc_tx_payload, TX_API__send_dband_bcon, __ld_r15_to_r13_ret, __st_r15_to_r13, bcon_tx_build_step, fw_log__emit3, fw_sysassert_fatal, lmac_if__send_bcon_mgt, memcpy_fw, tx_mgmt_srvs__build_dmg_beacon
 */
	.section .text.tx_bcon__update_bcon,"ax",@progbits
	.global tx_bcon__update_bcon
tx_bcon__update_bcon:
	.global L_8c2190
L_8c2190:
	push_s blink
L_8c2192:
	bl L_8c02c0
L_8c2196:
	mov_s r14,r0
L_8c2198:
	add3 r15,r0,0x9
L_8c219c:
	mov_s r0,0x0
L_8c219e:
	bl.d L_8c2c80
L_8c21a2:
	st.a r0,[sp,-0xc]
L_8c21a6:
	mov.f r13,r0
L_8c21aa:
	beq_s L_8c2212
	.global L_8c21ac
L_8c21ac:
	mov_s r0,r15
L_8c21ae:
	bl.d L_8c42d4
L_8c21b2:
	mov_s r1,0x0
L_8c21b4:
	mov_s r1,sp
L_8c21b6:
	mov_s r0,r13
L_8c21b8:
	mov_s r2,r14
L_8c21ba:
	bl.d L_8e4c34
L_8c21be:
	mov_s r3,0x0
L_8c21c0:
	ldw r1,[sp]
L_8c21c4:
	mov_s r2,0x2ee38
L_8c21ca:
	mov_s r0,r13
L_8c21cc:
	bl.d L_8e0748
L_8c21d0:
	mov_s r3,0x0
L_8c21d2:
	mov_s r13,r15
L_8c21d4:
	add r13,r13,0x107
L_8c21d8:
	ldb_s r0,[r13]
L_8c21da:
	ld r4,[sp]
L_8c21de:
	bclr_s r0,r0,0x1
L_8c21e0:
	stb_s r0,[r13]
L_8c21e2:
	ld_s r0,[r15,0x4]
L_8c21e4:
	ldb_s r3,[r14,0x10]
L_8c21e6:
	ldb_s r14,[r13,0x5]
L_8c21e8:
	lsr_s r14,r14,0x4
L_8c21ea:
	brne r0,0x2,L_8c2228
L_8c21ee:
	mov_s r2,0x1012954
L_8c21f4:
	mov_s r0,0xc
L_8c21f6:
	mov_s r1,0x2
L_8c21f8:
	bl.d L_8ee034
L_8c21fc:
	bmsk r5,r14,0x1
L_8c2200:
	add_s r0,sp,0x4
L_8c2202:
	mov_s r1,r13
L_8c2204:
	bl.d L_8c0460
L_8c2208:
	mov_s r2,0x8
L_8c220a:
	ld_s r2,[sp,0x4]
L_8c220c:
	ld_s r3,[sp,0x8]
L_8c220e:
	mov_s r0,0x2
L_8c2210:
	b_s L_8c224a
	.global L_8c2212
L_8c2212:
	mov_s r0,blink
L_8c2214:
	mov_s r2,0x1012990
L_8c221a:
	mov_s r1,0x124f
L_8c2220:
	bl.d L_8c82c0
L_8c2224:
	mov_s r3,0x1e
L_8c2226:
	b_s L_8c21ac
	.global L_8c2228
L_8c2228:
	mov_s r2,0x101299c
L_8c222e:
	mov_s r0,0xc
L_8c2230:
	mov_s r1,0x2
L_8c2232:
	bl.d L_8ee034
L_8c2236:
	bmsk r5,r14,0x1
L_8c223a:
	add_s r0,sp,0x4
L_8c223c:
	mov_s r1,r13
L_8c223e:
	bl.d L_8c0460
L_8c2242:
	mov_s r2,0x8
L_8c2244:
	ld_s r2,[sp,0x4]
L_8c2246:
	mov_s r0,0x0
L_8c2248:
	ld_s r3,[sp,0x8]
	.global L_8c224a
L_8c224a:
	mov_s r1,0x1
L_8c224c:
	bl.d L_8d80dc
L_8c2250:
	mov r4,0x0
L_8c2254:
	mov_s r0,0x0
L_8c2256:
	b.d L_8c032c
L_8c225a:
	add_s sp,sp,0xc
