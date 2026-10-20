/* ba_sm__send_addba_req @ 0x8e50c8, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending ADDBA REQ. stream idx: %d, tid: %d
 * Зовут его: ba_setup_sm__action_8f866c
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r20_to_r13_ret, __st_r20_to_r13, frame__build_addba_req, fw_log_emit2, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__by_obj_mid, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__send_addba_req
ba_sm__send_addba_req:
	.global L_8e50c8
L_8e50c8:
	push_s blink
L_8e50ca:
	bl L_8c01cc
L_8e50ce:
	sub_s sp,sp,0x4
L_8e50d0:
	mov_s r13,r0
L_8e50d2:
	mov_s r16,r1
L_8e50d4:
	mov_s r19,r2
L_8e50d6:
	mov_s r18,r3
L_8e50d8:
	bl.d L_8c3414
L_8e50dc:
	mov r20,r4
L_8e50e0:
	mov_s r14,r0
L_8e50e2:
	bl.d L_8cc41c
L_8e50e6:
	ld_s r0,[r13,0x40]
L_8e50e8:
	mov.f r15,r0
L_8e50ec:
	beq_s L_8e5164
	.global L_8e50ee
L_8e50ee:
	mov_s r0,0x0
L_8e50f0:
	mov_s r17,r0
L_8e50f2:
	st_s r0,[sp,0x0]
L_8e50f4:
	ld_s r3,[r13,0x40]
L_8e50f6:
	mov_s r1,sp
L_8e50f8:
	ld_s r3,[r3]
L_8e50fa:
	mov_s r0,r14
L_8e50fc:
	mov_s r2,r15
L_8e50fe:
	bl.d L_8e9c7c
L_8e5102:
	mov r4,0xd
L_8e5106:
	ld_s r0,[sp,0x0]
L_8e5108:
	ld_s r3,[r13,0x40]
L_8e510a:
	add_s r0,r0,r14
L_8e510c:
	ldw r5,[r3, 0x5c]
L_8e5110:
	sub.f r6,r20,0x0
L_8e5114:
	ldb_s r3,[r3,0x4]
L_8e5116:
	extb r1,r16
L_8e511a:
	mov.ne r6,0x1
L_8e511e:
	mov_s r2,r19
L_8e5120:
	bl.d L_8f4dc8
L_8e5124:
	mov r4,r18
L_8e5128:
	ld_s r1,[sp,0x0]
L_8e512a:
	add_s r0,r0,r1
L_8e512c:
	st_s r0,[sp,0x0]
L_8e512e:
	ld_s r3,[r13,0x40]
L_8e5130:
	mov_s r1,0x10135bc
L_8e5136:
	ldb_s r2,[r3,0x7]
L_8e5138:
	mov_s r0,0x2b
L_8e513a:
	bl.d L_8dcc80
L_8e513e:
	ldb_s r3,[r3,0x4]
L_8e5140:
	ld_s r0,[r13,0x40]
L_8e5142:
	mov r5,0x30c4
L_8e514a:
	ldw r4,[sp]
L_8e514e:
	mov_s r1,r17
L_8e5150:
	ld_s r0,[r0]
L_8e5152:
	mov_s r2,0x1
L_8e5154:
	mov_s r3,r14
L_8e5156:
	bl.d L_8e5874
L_8e515a:
	mov r6,r17
L_8e515e:
	b.d L_8c0224
L_8e5162:
	add_s sp,sp,0x4
	.global L_8e5164
L_8e5164:
	mov_s r0,blink
L_8e5166:
	mov_s r1,0x1283
L_8e516c:
	bl L_8c9b28
L_8e5170:
	b_s L_8e50ee
L_8e5172:
	nop_s
