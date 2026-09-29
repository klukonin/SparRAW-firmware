/* rf_utils_auto_fill_set_pattern @ 0x8e3268, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rf_utils_auto_fill_set_pattern(): wrong input params; p_fill_info = 0x%x
 * Зовут его: rf_utils__fill_default_patterns
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, hwd__args_to_regs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_utils_auto_fill_set_pattern
rf_utils_auto_fill_set_pattern:
	.global L_8e3268
L_8e3268:
	push_s blink
L_8e326a:
	bl L_8c01dc
L_8e326e:
	mov.f r2,r0
L_8e3272:
	beq_s L_8e3278
L_8e3274:
	ld_s r13,[r2,0x4]
L_8e3276:
	brne_s r13,0,L_8e3286
	.global L_8e3278
L_8e3278:
	mov_s r1,0x1008d80
L_8e327e:
	bl.d L_8dcc10
L_8e3282:
	mov_s r0,0x0
L_8e3284:
	b_s L_8e32b0
	.global L_8e3286
L_8e3286:
	ldb_s r0,[r2,0x1]
L_8e3288:
	ldb r16,[r2]
L_8e328c:
	asl_s r0,r0,0x8
L_8e328e:
	add3 r0,r0,0x524
L_8e3292:
	lsr_s r0,r0,0x3
L_8e3294:
	bic r14,r0,0x3
L_8e3298:
	mov_s r15,0x6
	.global L_8e329a
L_8e329a:
	ld.ab r2,[r13,0x4]
L_8e329e:
	mov_s r0,r16
L_8e32a0:
	mov_s r1,r14
L_8e32a2:
	bl.d L_8d338c
L_8e32a6:
	mov_s r3,0x0
L_8e32a8:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8e32aa:
	/* brhs.d r15,0x1,0x008e329a */
	.byte 0xf3,0x0f,0x75,0x90
L_8e32ae:
	/* _add_s r14,0x4 */
	.byte 0x04,0xe6
	.global L_8e32b0
L_8e32b0:
	b L_8c0244
