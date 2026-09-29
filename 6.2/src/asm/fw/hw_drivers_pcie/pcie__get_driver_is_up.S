/* pcie__get_driver_is_up @ 0x8d13c4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__get_driver_is_up
pcie__get_driver_is_up:
	.global L_8d13c4
L_8d13c4:
	mov_s r0,0x882600
L_8d13ca:
	ld_s r0,[r0,0x5c]
L_8d13cc:
	lsr_s r0,r0
L_8d13ce:
	j_s.d [blink]
L_8d13d0:
	bmsk_s r0,r0,0x0
L_8d13d2:
	nop_s
