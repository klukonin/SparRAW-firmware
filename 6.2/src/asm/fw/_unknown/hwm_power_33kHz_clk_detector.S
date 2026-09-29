/* hwm_power_33kHz_clk_detector @ 0x8d777c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwm_power_33kHz_clk_detector:  External clock (33KHz) detcetion was not performed since SysClock is not equal to 165MHz!
 * Зовут его: power_mngr__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, hwm__probe_33khz_clk, hwm__start_33khz_measure, mac__reload_tsf64, pcie__clear_880c50_b2, pcie__set_880c50_b12
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_power_33kHz_clk_detector
hwm_power_33kHz_clk_detector:
	.global L_8d777c
L_8d777c:
	push_s blink
L_8d777e:
	bl L_8c01e4
L_8d7782:
	mov_s r0,0x880a80
L_8d7788:
	ld_s r0,[r0,0x3c]
L_8d778a:
	bbit1 r0,0x1,L_8d779e
L_8d778e:
	mov_s r1,0x101cf98
L_8d7794:
	bl.d L_8dcba8
L_8d7798:
	mov_s r0,0x2e
L_8d779a:
	mov_s r13,0x0
L_8d779c:
	b_s L_8d77d4
	.global L_8d779e
L_8d779e:
	lr r14,[0xa]
L_8d77a2:
	bic r0,r14,0x6
L_8d77a6:
	flag r0
L_8d77aa:
	bl.d L_8d03f4
L_8d77ae:
	bic r14,r14,-0x7
L_8d77b2:
	bl L_8e9924
L_8d77b6:
	bl.d L_8d0444
L_8d77ba:
	mov_s r13,r0
L_8d77bc:
	bl.d L_8e9a14
L_8d77c0:
	mov_s r0,0x0
L_8d77c2:
	mov_s r0,0x0
L_8d77c4:
	bl.d L_8e9a58
L_8d77c8:
	mov_s r1,r0
L_8d77ca:
	lr r0,[0xa]
L_8d77ce:
	or_s r14,r14,r0
L_8d77d0:
	flag r14
	.global L_8d77d4
L_8d77d4:
	b.d L_8c0254
L_8d77d8:
	mov_s r0,r13
L_8d77da:
	nop_s
