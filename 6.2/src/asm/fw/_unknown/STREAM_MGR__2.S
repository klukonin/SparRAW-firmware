/* STREAM_MGR__2 @ 0x8e81ac, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: STREAM [%d] REMOVED.
 *   Delete BCAST Vring notification. Vring Index: %d.
 *   VRING %d received TX MACQ delete notification
 * Зовут его: stream_mgr__macq_removed
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r16_to_r13_ret, __st_r15_to_r13, __st_r16_to_r13, dmaq_hw__reset_ptrs, fw_log_emit1, hwd_dma__macq_reg_addr, l2mgr__send_vring_cfg_done, macq_desc__read, macq_desc__write, rx_macq__entry_addr, stream_mgr__build_params
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global STREAM_MGR__2
STREAM_MGR__2:
	.global L_8e81ac
L_8e81ac:
	push_s blink
L_8e81ae:
	bl L_8c01e0
L_8e81b2:
	mov_s r14,r0
L_8e81b4:
	ldb_s r13,[r0,0x7]
L_8e81b6:
	ld_s r15,[r0,0xc]
L_8e81b8:
	ldb r0,[r0, 0x5e]
L_8e81bc:
	breq_s r0,0,L_8e81ce
L_8e81be:
	ld_s r0,[r14,0x68]
L_8e81c0:
	ld_s r1,[r0,0x20]
L_8e81c2:
	jl_s.d [r1]
L_8e81c4:
	mov_s r0,r14
L_8e81c6:
	brne_s r15,0,L_8e81ce
L_8e81c8:
	bl.d L_8c8774
L_8e81cc:
	ld_s r0,[r14]
	.global L_8e81ce
L_8e81ce:
	mov_s r0,0x847f34
L_8e81d4:
	ldb_s r1,[r14,0x7]
L_8e81d6:
	sub r0,r0,0x400
L_8e81da:
	add2_s r0,r0,r1
L_8e81dc:
	add r0,r0,0x44c
L_8e81e0:
	mov_s r2,0x0
L_8e81e2:
	st_s r2,[r0]
L_8e81e4:
	ldb_s r0,[r14,0x7]
L_8e81e6:
	brhs r0,0x9,L_8e81f6
L_8e81ea:
	mov_s r0,0x847b34
L_8e81f0:
	bl.d L_8caed0
L_8e81f4:
	mov_s r1,r14
	.global L_8e81f6
L_8e81f6:
	mov_s r1,0x1010ca8
L_8e81fc:
	mov_s r0,0x2b
L_8e81fe:
	bl.d L_8dcc10
L_8e8202:
	ldb_s r2,[r14,0x7]
L_8e8204:
	breq_s r15,0,L_8e8226
L_8e8206:
	mov_s r1,0x1010ccc
L_8e820c:
	mov_s r0,0x2b
L_8e820e:
	bl.d L_8dcc10
L_8e8212:
	mov_s r2,r13
L_8e8214:
	bl.d L_8d083c
L_8e8218:
	mov_s r0,r13
L_8e821a:
	mov_s r1,r0
L_8e821c:
	mov_s r0,r13
L_8e821e:
	mov_s r2,0x0
L_8e8220:
	bl.d L_8f8e98
L_8e8224:
	ld_s r3,[r14,0x8]
	.global L_8e8226
L_8e8226:
	b L_8c024c
L_8e822a:
	nop_s
L_8e822c:
	push_s blink
L_8e822e:
	bl L_8c01dc
L_8e8232:
	sub_s sp,sp,0x8
L_8e8234:
	mov_s r13,r0
L_8e8236:
	mov_s r1,0x10110c4
L_8e823c:
	mov_s r0,0x2b
L_8e823e:
	bl.d L_8dcc10
L_8e8242:
	ldb_s r2,[r13,0x7]
L_8e8244:
	mov_s r14,0x0
L_8e8246:
	bl.d L_8cd080
L_8e824a:
	stb r14,[r13, 0x5e]
L_8e824e:
	ld_s r1,[r0]
L_8e8250:
	ld_s r2,[r1,0x10]
L_8e8252:
	jl_s.d [r2]
L_8e8254:
	ldb_s r1,[r13,0x7]
L_8e8256:
	bl.d L_8d0d44
L_8e825a:
	ldb_s r0,[r13,0x7]
L_8e825c:
	bl.d L_8ccfd8
L_8e8260:
	ldb_s r0,[r13,0x7]
L_8e8262:
	mov_s r1,0x5
L_8e8264:
	mov_s r2,r14
L_8e8266:
	bl.d L_8e2a50
L_8e826a:
	ldb_s r3,[r13,0x4]
L_8e826c:
	ld_s r0,[gp,0x124]
L_8e826e:
	brne r0,0x0,L_8e82da
L_8e8272:
	stw r14,[r13, 0x5c]
L_8e8276:
	bl.d L_8ccb68
L_8e827a:
	mov_s r0,0x2
L_8e827c:
	mov_s r16,r0
	.global L_8e827e
L_8e827e:
	mov_s r0,0x886e80
L_8e8284:
	ld_s r14,[r0,0x4c]
L_8e8286:
	mov_s r0,0xa0
L_8e8288:
	mov lp_count,r0
L_8e828c:
	nop_s
L_8e828e:
	lp L_8e8296
L_8e8292:
	nop_s
L_8e8294:
	nop_s
	.global L_8e8296
L_8e8296:
	bbit1 r14,0x3,L_8e827e
L_8e829a:
	ld_s r0,[r13]
L_8e829c:
	ldb_s r0,[r0,0x8]
L_8e829e:
	bl.d L_8dfafc
L_8e82a2:
	ldb_s r1,[r13,0x4]
L_8e82a4:
	bl.d L_8c4554
L_8e82a8:
	mov_s r0,r16
L_8e82aa:
	mov_s r13,sp
L_8e82ac:
	mov_s r0,r13
L_8e82ae:
	mov_s r1,0x2
L_8e82b0:
	mov_s r2,0x1
L_8e82b2:
	mov_s r3,r1
L_8e82b4:
	bl.d L_8c50f8
L_8e82b8:
	mov_s r4,r2
L_8e82ba:
	ld_s r0,[sp,0x0]
L_8e82bc:
	mov_s r1,0x2
L_8e82be:
	bset_s r0,r0,0x12
L_8e82c0:
	st_s r0,[sp,0x0]
L_8e82c2:
	mov_s r0,r13
L_8e82c4:
	mov_s r2,0x1
L_8e82c6:
	mov_s r3,r1
L_8e82c8:
	mov r4,0x0
L_8e82cc:
	mov r5,r4
L_8e82d0:
	mov r6,r4
L_8e82d4:
	bl.d L_8c5010
L_8e82d8:
	mov_s r7,r2
	.global L_8e82da
L_8e82da:
	b.d L_8c0244
L_8e82de:
	add_s sp,sp,0x8
