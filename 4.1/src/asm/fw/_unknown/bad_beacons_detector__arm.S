/* bad_beacons_detector__arm @ 0x8e28d8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r13_ret, bad_beacons_detector__configure
 */
	.section .text.bad_beacons_detector__arm,"ax",@progbits
	.global bad_beacons_detector__arm
bad_beacons_detector__arm:
	.global L_8e28d8
L_8e28d8:
	push_s blink
L_8e28da:
	push_s r13
L_8e28dc:
	bl.d L_8c5a34
L_8e28e0:
	mov_s r13,r0
L_8e28e2:
	mov_s r0,0x1
L_8e28e4:
	b.d L_8c033c
L_8e28e8:
	st_s r0,[r13,0x8]
L_8e28ea:
	nop_s
