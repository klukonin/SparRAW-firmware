/* rgf_reg_880c00_8cd5b8 @ 0x8cd5b8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, power_halt_seq, ut_hw_modes_cmd_0x30c
 */
	.section .text.rgf_reg_880c00_8cd5b8,"ax",@progbits
	.global rgf_reg_880c00_8cd5b8
rgf_reg_880c00_8cd5b8:
	.global L_8cd5b8
L_8cd5b8:
	mov_s r1,0x880c00
L_8cd5be:
	ld_s r0,[r1,0x50]
L_8cd5c0:
	bclr_s r0,r0,0x2
L_8cd5c2:
	st_s r0,[r1,0x50]
L_8cd5c4:
	nop_s
L_8cd5c6:
	nop_s
L_8cd5c8:
	nop_s
L_8cd5ca:
	nop_s
L_8cd5cc:
	nop_s
L_8cd5ce:
	nop_s
L_8cd5d0:
	nop_s
L_8cd5d2:
	nop_s
L_8cd5d4:
	nop_s
L_8cd5d6:
	nop_s
L_8cd5d8:
	j_s [blink]
L_8cd5da:
	nop_s
