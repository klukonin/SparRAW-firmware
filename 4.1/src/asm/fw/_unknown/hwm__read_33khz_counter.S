/* hwm__read_33khz_counter @ 0x8e48e8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__probe_33khz_clk, hwm__start_33khz_measure
 * Зовёт сам: __ld_r13_ret
 * Глобалы (через gp): 0x800400
 */
	.section .text.hwm__read_33khz_counter,"ax",@progbits
	.global hwm__read_33khz_counter
hwm__read_33khz_counter:
	.global L_8e48e8
L_8e48e8:
	push_s blink
L_8e48ea:
	push_s r13
L_8e48ec:
	ld_s r0,[gp,0x290]
L_8e48ee:
	brlo.d r0,0x1,L_8e491c
L_8e48f2:
	mov_s r13,0x0
	.global L_8e48f4
L_8e48f4:
	mov_s r0,0x886d80
L_8e48fa:
	st 0x63000001,[r0, 0x48]
L_8e4902:
	mov_s r0,0x7d
L_8e4904:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8e4906:
	mov lp_count,r0
L_8e490a:
	nop_s
L_8e490c:
	lp L_8e4914
L_8e4910:
	nop_s
L_8e4912:
	nop_s
	.global L_8e4914
L_8e4914:
	ld_s r0,[gp,0x290]
L_8e4916:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e4918:
	brlo r13,r0,L_8e48f4
	.global L_8e491c
L_8e491c:
	b L_8c033c
