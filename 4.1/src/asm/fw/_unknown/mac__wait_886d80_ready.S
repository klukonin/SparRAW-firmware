/* mac__wait_886d80_ready @ 0x8e4894, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: hwm__start_33khz_measure
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 * Глобалы (через gp): 0x8003fc
 */
	.section .text.mac__wait_886d80_ready,"ax",@progbits
	.global mac__wait_886d80_ready
mac__wait_886d80_ready:
	.global L_8e4894
L_8e4894:
	push_s blink
L_8e4896:
	push_s r13
L_8e4898:
	ld_s r0,[gp,0x28c]
L_8e489a:
	brlo.d r0,0x1,L_8e48e2
L_8e489e:
	mov_s r13,0x0
	.global L_8e48a0
L_8e48a0:
	mov_s r0,0x886d80
L_8e48a6:
	st 0x63000002,[r0, 0x48]
L_8e48ae:
	mov lp_count,0x3e8
L_8e48b2:
	lp L_8e48c8
L_8e48b6:
	mov_s r0,0x88c180
L_8e48bc:
	ld_s r0,[r0]
L_8e48be:
	lsr_s r0,r0,0x4
L_8e48c0:
	bmsk.f r0,r0,0x3
L_8e48c4:
	beq_s L_8e48c8
L_8e48c6:
	nop_s
	.global L_8e48c8
L_8e48c8:
	breq_s r0,0,L_8e48da
L_8e48ca:
	mov_s r3,blink
L_8e48cc:
	mov_s r2,0x10184b4
L_8e48d2:
	mov_s r0,0x0
L_8e48d4:
	bl.d L_8edfcc
L_8e48d8:
	mov_s r1,r0
	.global L_8e48da
L_8e48da:
	ld_s r0,[gp,0x28c]
L_8e48dc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e48de:
	brlo r13,r0,L_8e48a0
	.global L_8e48e2
L_8e48e2:
	b L_8c033c
L_8e48e6:
	nop_s
