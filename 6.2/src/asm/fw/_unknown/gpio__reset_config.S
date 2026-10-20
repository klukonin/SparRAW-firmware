/* gpio__reset_config @ 0x8f4444, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Resetting GPIOs configurations
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: fw_log_emit0, gpio__write_ctrl_b84
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global gpio__reset_config
gpio__reset_config:
	.global L_8f4444
L_8f4444:
	push_s blink
L_8f4446:
	mov_s r1,0x101f330
L_8f444c:
	bl.d L_8dcba8
L_8f4450:
	mov_s r0,0x20
L_8f4452:
	mov_s r0,0x11
L_8f4454:
	asl_s r0,r0,0x13
L_8f4456:
	st 0x22222,[r0, 0x68]
L_8f445e:
	mov_s r1,0x0
L_8f4460:
	st_s r1,[r0,0x6c]
L_8f4462:
	st_s r1,[r0,0x70]
L_8f4464:
	st_s r1,[r0,0x74]
L_8f4466:
	st_s r1,[r0,0x78]
L_8f4468:
	st_s r1,[r0,0x7c]
L_8f446a:
	mov_s r0,0x880b00
L_8f4470:
	st_s r1,[r0,0x6c]
L_8f4472:
	st_s r1,[r0,0x70]
L_8f4474:
	bl.d L_8f4480
L_8f4478:
	mov_s r0,0x1
L_8f447a:
	pop_s blink
L_8f447c:
	j_s [blink]
L_8f447e:
	nop_s
