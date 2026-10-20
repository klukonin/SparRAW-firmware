/* pcie__set_880c50_b12 @ 0x8d03f4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, power_halt_seq, ut_hw_modes_cmd_0x30c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_880c50_b12
pcie__set_880c50_b12:
	.global L_8d03f4
L_8d03f4:
	mov_s r1,0x880c00
L_8d03fa:
	ld_s r0,[r1,0x50]
L_8d03fc:
	bset_s r0,r0,0x1
L_8d03fe:
	st_s r0,[r1,0x50]
L_8d0400:
	ld_s r0,[r1,0x50]
L_8d0402:
	bset_s r0,r0,0x2
L_8d0404:
	st_s r0,[r1,0x50]
L_8d0406:
	nop_s
L_8d0408:
	nop_s
L_8d040a:
	nop_s
L_8d040c:
	nop_s
L_8d040e:
	nop_s
L_8d0410:
	nop_s
L_8d0412:
	nop_s
L_8d0414:
	nop_s
L_8d0416:
	nop_s
L_8d0418:
	nop_s
L_8d041a:
	j_s [blink]
