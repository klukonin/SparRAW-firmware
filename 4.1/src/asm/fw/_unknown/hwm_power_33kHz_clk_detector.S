/* hwm_power_33kHz_clk_detector @ 0x8d4cc0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwm_power_33kHz_clk_detector:  External clock (33KHz) detcetion was not performed since SysClock is not equal to 165MHz!
 * Зовут его: POWER_MNGR__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, hwm__probe_33khz_clk, hwm__start_33khz_measure, mac__load_gp_timer_value, rgf_reg_880c00_8cd568, rgf_reg_880c00_8cd5b8
 */
	.section .text.hwm_power_33kHz_clk_detector,"ax",@progbits
	.global hwm_power_33kHz_clk_detector
hwm_power_33kHz_clk_detector:
	.global L_8d4cc0
L_8d4cc0:
	push_s blink
L_8d4cc2:
	bl L_8c02c4
L_8d4cc6:
	mov_s r0,0x880a80
L_8d4ccc:
	ld_s r0,[r0,0x3c]
L_8d4cce:
	bbit1 r0,0x1,L_8d4ce4
L_8d4cd2:
	mov_s r2,0x10182d4
L_8d4cd8:
	mov_s r0,0xe
L_8d4cda:
	bl.d L_8edfb0
L_8d4cde:
	mov_s r1,0x2
L_8d4ce0:
	mov_s r13,0x0
L_8d4ce2:
	b_s L_8d4d1a
	.global L_8d4ce4
L_8d4ce4:
	lr r14,[0xa]
L_8d4ce8:
	bic r0,r14,0x6
L_8d4cec:
	flag r0
L_8d4cf0:
	bl.d L_8cd568
L_8d4cf4:
	bic r14,r14,-0x7
L_8d4cf8:
	bl L_8e4864
L_8d4cfc:
	bl.d L_8cd5b8
L_8d4d00:
	mov_s r13,r0
L_8d4d02:
	bl.d L_8e4958
L_8d4d06:
	mov_s r0,0x0
L_8d4d08:
	mov_s r0,0x0
L_8d4d0a:
	bl.d L_8e499c
L_8d4d0e:
	mov_s r1,r0
L_8d4d10:
	lr r0,[0xa]
L_8d4d14:
	or_s r14,r14,r0
L_8d4d16:
	flag r14
	.global L_8d4d1a
L_8d4d1a:
	b.d L_8c0334
L_8d4d1e:
	mov_s r0,r13
