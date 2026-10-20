/* rgf_reg_880c00_8cd568 @ 0x8cd568, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, power_halt_seq, ut_hw_modes_cmd_0x30c
 */
	.section .text.rgf_reg_880c00_8cd568,"ax",@progbits
	.global rgf_reg_880c00_8cd568
rgf_reg_880c00_8cd568:
	.global L_8cd568
L_8cd568:
	mov_s r1,0x880c00
L_8cd56e:
	ld_s r0,[r1,0x50]
L_8cd570:
	bset_s r0,r0,0x1
L_8cd572:
	st_s r0,[r1,0x50]
L_8cd574:
	ld_s r0,[r1,0x50]
L_8cd576:
	bset_s r0,r0,0x2
L_8cd578:
	st_s r0,[r1,0x50]
L_8cd57a:
	nop_s
L_8cd57c:
	nop_s
L_8cd57e:
	nop_s
L_8cd580:
	nop_s
L_8cd582:
	nop_s
L_8cd584:
	nop_s
L_8cd586:
	nop_s
L_8cd588:
	nop_s
L_8cd58a:
	nop_s
L_8cd58c:
	nop_s
L_8cd58e:
	j_s [blink]
