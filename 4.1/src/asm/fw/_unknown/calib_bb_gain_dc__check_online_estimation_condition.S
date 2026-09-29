/* calib_bb_gain_dc__check_online_estimation_condition @ 0x8c5598, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_bb_gain_dc::check_online_estimation_condition  G_RX_VGA_RANGE_CONFIG.VGA_DC_FINE_FORCE=1
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.calib_bb_gain_dc__check_online_estimation_condition,"ax",@progbits
	.global calib_bb_gain_dc__check_online_estimation_condition
calib_bb_gain_dc__check_online_estimation_condition:
L_8c5598:
	push_s blink
L_8c559a:
	push_s r13
L_8c559c:
	mov_s r13,0x8004e0
L_8c55a2:
	ld_s r0,[r13,0x4]
L_8c55a4:
	brne r0,0x1,L_8c55be
L_8c55a8:
	mov_s r2,0x1008bb0
L_8c55ae:
	mov_s r0,0x6
L_8c55b0:
	bl.d L_8edfb0
L_8c55b4:
	mov_s r1,0x2
L_8c55b6:
	mov_s r0,0x0
L_8c55b8:
	st_s r0,[r13,0x4]
L_8c55ba:
	mov_s r0,0x1
L_8c55bc:
	b_s L_8c55c0
	.global L_8c55be
L_8c55be:
	mov_s r0,0x0
	.global L_8c55c0
L_8c55c0:
	b L_8c033c
