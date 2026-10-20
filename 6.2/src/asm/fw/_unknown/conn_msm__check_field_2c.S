/* conn_msm__check_field_2c @ 0x8e6308, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_msm__on_own_start_link__ready_for_assoc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x800231
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_msm__check_field_2c
conn_msm__check_field_2c:
	.global L_8e6308
L_8e6308:
	push_s blink
L_8e630a:
	bl L_8c01e4
L_8e630e:
	mov_s r13,r0
L_8e6310:
	ld_s r0,[r0,0x2c]
L_8e6312:
	mov_s r14,0x0
L_8e6314:
	breq_s r0,0,L_8e631c
L_8e6316:
	bl L_8c8de0
L_8e631a:
	st_s r14,[r13,0x2c]
	.global L_8e631c
L_8e631c:
	stb r14,[r13, 0x3c]
L_8e6320:
	ldb_s r0,[gp,0xad]
L_8e6322:
	cmp_s r0,0x1
L_8e6324:
	mov.le r14,0x7a120
L_8e632c:
	ble_s L_8e633a
L_8e632e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e6330:
	/* mul64 r0,0x493e0 */
	.byte 0x04,0x28,0x80,0x0f,0x04,0x00,0xe0,0x93
L_8e6338:
	mov_s r14,mlo
	.global L_8e633a
L_8e633a:
	mov_s r0,0x4808
L_8e6340:
	mov_s r1,r13
L_8e6342:
	mov_s r2,0x0
L_8e6344:
	mov_s r3,0x1
L_8e6346:
	mov_s r4,r14
L_8e6348:
	mov_s r5,r2
L_8e634a:
	bl.d L_8e0c0c
L_8e634e:
	mov_s r6,r2
L_8e6350:
	b.d L_8c0254
L_8e6354:
	st_s r0,[r13,0x2c]
L_8e6356:
	nop_s
