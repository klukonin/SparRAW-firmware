/* ka_detector__is_enabled @ 0x8da214, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detect_step, conn__start_detect_a, ka_necessity_detector__start_monitoring, ka_necessity_detector__task
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, ll_detector__is_armed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka_detector__is_enabled
ka_detector__is_enabled:
	.global L_8da214
L_8da214:
	push_s blink
L_8da216:
	push_s r13
L_8da218:
	bl.d L_8da35c
L_8da21c:
	mov_s r13,r0
L_8da21e:
	cmp_s r0,0x0
L_8da220:
	mov_s r0,0x0
L_8da222:
	beq_s L_8da24e
L_8da224:
	ldb r0,[r13, 0x30]
L_8da228:
	brge r0,0x8,L_8da252
	.global L_8da22c
L_8da22c:
	ldb r1,[r13, 0x30]
L_8da230:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8da232:
	ld_s r2,[r13,0x34]
L_8da234:
	add3_s r1,r1,r1
L_8da236:
	ld_s r1,[r2,r1]
L_8da238:
	mov_s r0,0x0
L_8da23a:
	bbit0 r1,0x1,L_8da24c
L_8da23e:
	mov_s r1,0x803c00
L_8da244:
	ld_s r1,[r1,0xc]
L_8da246:
	cmp_s r1,0x0
L_8da248:
	mov.eq r0,0x1
	.global L_8da24c
L_8da24c:
	extb_s r0,r0
	.global L_8da24e
L_8da24e:
	b L_8c025c
	.global L_8da252
L_8da252:
	mov_s r0,blink
L_8da254:
	mov_s r1,0x1546
L_8da25a:
	bl L_8c9b28
L_8da25e:
	b_s L_8da22c
