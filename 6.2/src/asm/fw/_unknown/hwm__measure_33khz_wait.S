/* hwm__measure_33khz_wait @ 0x8e9954, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: hwm__start_33khz_measure
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 * Глобалы (через gp): 0x800414
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__measure_33khz_wait
hwm__measure_33khz_wait:
	.global L_8e9954
L_8e9954:
	push_s blink
L_8e9956:
	push_s r13
L_8e9958:
	ld_s r0,[gp,0x290]
L_8e995a:
	brlo.d r0,0x1,L_8e99a0
L_8e995e:
	mov_s r13,0x0
	.global L_8e9960
L_8e9960:
	mov_s r0,0x886d80
L_8e9966:
	st 0x63000002,[r0, 0x48]
L_8e996e:
	mov lp_count,0x3e8
L_8e9972:
	lp L_8e9988
L_8e9976:
	mov_s r0,0x88c180
L_8e997c:
	ld_s r0,[r0]
L_8e997e:
	lsr_s r0,r0,0x4
L_8e9980:
	bmsk.f r0,r0,0x3
L_8e9984:
	beq_s L_8e9988
L_8e9986:
	nop_s
	.global L_8e9988
L_8e9988:
	breq_s r0,0,L_8e9998
L_8e998a:
	mov_s r2,blink
L_8e998c:
	mov_s r1,0x101d480
L_8e9992:
	bl.d L_8dcc10
L_8e9996:
	mov_s r0,0x0
	.global L_8e9998
L_8e9998:
	ld_s r0,[gp,0x290]
L_8e999a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e999c:
	brlo r13,r0,L_8e9960
	.global L_8e99a0
L_8e99a0:
	b L_8c025c
