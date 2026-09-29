/* bad_beacons_detector__stop_monitoring @ 0x8e8050, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector::stop_monitoring
 * Зовут его: lm_if__stop_link_loss_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons_detector__stop_monitoring
bad_beacons_detector__stop_monitoring:
	.global L_8e8050
L_8e8050:
	push_s blink
L_8e8052:
	push_s r13
L_8e8054:
	mov_s r13,r0
L_8e8056:
	mov_s r1,0x1014dac
L_8e805c:
	bl.d L_8dcba8
L_8e8060:
	mov_s r0,0x2b
L_8e8062:
	mov_s r0,0x0
L_8e8064:
	b.d L_8c025c
L_8e8068:
	st_s r0,[r13,0x8]
L_8e806a:
	nop_s
