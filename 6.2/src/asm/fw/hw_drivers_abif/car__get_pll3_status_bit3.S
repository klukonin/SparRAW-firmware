/* car__get_pll3_status_bit3 @ 0x8d0188, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abif__ack_unmask_pll_unlock_irq, car__enable_pll3_and_wait
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global car__get_pll3_status_bit3
car__get_pll3_status_bit3:
	.global L_8d0188
L_8d0188:
	mov_s r0,0x88af80
L_8d018e:
	ld_s r0,[r0,0x6c]
L_8d0190:
	lsr_s r0,r0,0x3
L_8d0192:
	j_s.d [blink]
L_8d0194:
	bmsk_s r0,r0,0x0
L_8d0196:
	nop_s
