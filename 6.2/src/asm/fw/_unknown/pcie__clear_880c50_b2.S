/* pcie__clear_880c50_b2 @ 0x8d0444, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm_power_33kHz_clk_detector, power_halt_seq, ut_hw_modes_cmd_0x30c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__clear_880c50_b2
pcie__clear_880c50_b2:
	.global L_8d0444
L_8d0444:
	mov_s r1,0x880c00
L_8d044a:
	ld_s r0,[r1,0x50]
L_8d044c:
	bclr_s r0,r0,0x2
L_8d044e:
	st_s r0,[r1,0x50]
L_8d0450:
	nop_s
L_8d0452:
	nop_s
L_8d0454:
	nop_s
L_8d0456:
	nop_s
L_8d0458:
	nop_s
L_8d045a:
	nop_s
L_8d045c:
	nop_s
L_8d045e:
	nop_s
L_8d0460:
	nop_s
L_8d0462:
	nop_s
L_8d0464:
	j_s [blink]
L_8d0466:
	nop_s
