/* mac__cmd_63_repeat @ 0x8e99a4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__probe_33khz_clk, hwm__start_33khz_measure
 * Зовёт сам: __ld_r13_to_r13_ret
 * Глобалы (через gp): 0x800418
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__cmd_63_repeat
mac__cmd_63_repeat:
	.global L_8e99a4
L_8e99a4:
	push_s blink
L_8e99a6:
	push_s r13
L_8e99a8:
	ld_s r0,[gp,0x294]
L_8e99aa:
	brlo.d r0,0x1,L_8e99d8
L_8e99ae:
	mov_s r13,0x0
	.global L_8e99b0
L_8e99b0:
	mov_s r0,0x886d80
L_8e99b6:
	st 0x63000001,[r0, 0x48]
L_8e99be:
	mov_s r0,0x7d
L_8e99c0:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8e99c2:
	mov lp_count,r0
L_8e99c6:
	nop_s
L_8e99c8:
	lp L_8e99d0
L_8e99cc:
	nop_s
L_8e99ce:
	nop_s
	.global L_8e99d0
L_8e99d0:
	ld_s r0,[gp,0x294]
L_8e99d2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e99d4:
	brlo r13,r0,L_8e99b0
	.global L_8e99d8
L_8e99d8:
	b L_8c025c
