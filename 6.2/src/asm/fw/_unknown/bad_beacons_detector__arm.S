/* bad_beacons_detector__arm @ 0x8e7adc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, bad_beacons__check_counter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons_detector__arm
bad_beacons_detector__arm:
	.global L_8e7adc
L_8e7adc:
	push_s blink
L_8e7ade:
	push_s r13
L_8e7ae0:
	bl.d L_8c67bc
L_8e7ae4:
	mov_s r13,r0
L_8e7ae6:
	mov_s r0,0x1
L_8e7ae8:
	b.d L_8c025c
L_8e7aec:
	st_s r0,[r13,0x8]
L_8e7aee:
	nop_s
