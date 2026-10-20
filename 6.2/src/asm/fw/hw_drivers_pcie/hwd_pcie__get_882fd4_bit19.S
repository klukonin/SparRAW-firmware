/* hwd_pcie__get_882fd4_bit19 @ 0x8d163c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__get_882fd4_bit19
hwd_pcie__get_882fd4_bit19:
	.global L_8d163c
L_8d163c:
	mov_s r0,0x882f80
L_8d1642:
	ld_s r0,[r0,0x54]
L_8d1644:
	lsr_s r0,r0,0x13
L_8d1646:
	j_s.d [blink]
L_8d1648:
	bmsk_s r0,r0,0x0
L_8d164a:
	nop_s
