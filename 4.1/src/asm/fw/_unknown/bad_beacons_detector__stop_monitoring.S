/* bad_beacons_detector__stop_monitoring @ 0x8e2f70, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector::stop_monitoring
 * Зовут его: lm_if__stop_link_loss_monitoring
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.bad_beacons_detector__stop_monitoring,"ax",@progbits
	.global bad_beacons_detector__stop_monitoring
bad_beacons_detector__stop_monitoring:
	.global L_8e2f70
L_8e2f70:
	push_s blink
L_8e2f72:
	push_s r13
L_8e2f74:
	mov_s r13,r0
L_8e2f76:
	mov_s r2,0x101173c
L_8e2f7c:
	mov_s r0,0xb
L_8e2f7e:
	bl.d L_8edfb0
L_8e2f82:
	mov_s r1,0x2
L_8e2f84:
	mov_s r0,0x0
L_8e2f86:
	b.d L_8c033c
L_8e2f8a:
	st_s r0,[r13,0x8]
