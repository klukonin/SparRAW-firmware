/* bf_sm__step_by_state @ 0x9221f8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_flow_kind1, internal_tx__pending_sm, rx_funcs__rx_flow
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf__reset_rx_counters, bf_substate__dispatch_by_state
 * Глобалы (через gp): 0x8005b0
 */
	.section .text.bf_sm__step_by_state,"ax",@progbits
	.global bf_sm__step_by_state
bf_sm__step_by_state:
	.global L_9221f8
L_9221f8:
	push_s blink
L_9221fa:
	bl.d L_920210
L_9221fe:
	mov_s r2,0x0
L_922200:
	push_s r0
L_922202:
	mov_s r13,0x800ef4
L_922208:
	asl_s r15,r0,0x2
L_92220a:
	add1_s r15,r15,r15
L_92220c:
	ld.a r0,[r15,r13]
L_922210:
	mov_s r1,0x1
L_922212:
	cmp_s r0,0xa
L_922214:
	mov_s r14,0x800fb0
L_92221a:
	sub_s.ne r1,r1,r1
L_92221c:
	b_s L_92223a
	.global L_92221e
L_92221e:
	bl.d L_922850
L_922222:
	ld_s r0,[sp,0x0]
L_922224:
	mov_s r2,r0
L_922226:
	ld_s r0,[sp,0x0]
L_922228:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92222a:
	add1_s r0,r0,r0
L_92222c:
	add_s r1,r13,r0
L_92222e:
	ld_s r1,[r1,0x4]
L_922230:
	ld_s r0,[r13,r0]
L_922232:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_922234:
	or_s r0,r0,r1
L_922236:
	st_s r0,[r14,0x10]
L_922238:
	mov_s r1,0x0
	.global L_92223a
L_92223a:
	cmp_s r2,0x2
L_92223c:
	cmp.ne r2,0x3
L_922240:
	bne_s L_92221e
L_922242:
	ld_s r1,[r15]
L_922244:
	ld_s r0,[gp,0x88]
L_922246:
	st_s r1,[r0,0x14]
L_922248:
	ld_s r1,[r15,0x4]
L_92224a:
	ld_s r0,[gp,0x88]
L_92224c:
	st_s r1,[r0,0x18]
L_92224e:
	ld_s r0,[gp,0x88]
L_922250:
	ldb_s r1,[r14]
L_922252:
	st_s r1,[r0,0x1c]
L_922254:
	ld_s r0,[gp,0x88]
L_922256:
	ldb_s r1,[r14,0x1]
L_922258:
	st_s r1,[r0,0x20]
L_92225a:
	mov_s r0,r2
L_92225c:
	bl.d L_9221a4
L_922260:
	ld_s r1,[sp,0x0]
L_922262:
	b.d L_92027c
L_922266:
	add_s sp,sp,0x4
