/* SDP__hwd_sdp_is_gpio_sdp @ 0x8f4378, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_gpio_sdp() the following port was not expected to be gpio: %d
 * Зовут его: gpio__set_pin_func_and_dump
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__hwd_sdp_is_gpio_sdp
SDP__hwd_sdp_is_gpio_sdp:
	.global L_8f4378
L_8f4378:
	push_s blink
L_8f437a:
	push_s r13
L_8f437c:
	bl.d L_8f4354
L_8f4380:
	mov_s r13,r0
L_8f4382:
	brhs r13,0x5,L_8f43a0
L_8f4386:
	mov_s r1,0x101f400
L_8f438c:
	mov_s r0,0x0
L_8f438e:
	bl.d L_8dcc10
L_8f4392:
	mov_s r2,r13
L_8f4394:
	mov_s r0,blink
L_8f4396:
	mov_s r1,0x1415
L_8f439c:
	bl L_8c9b28
	.global L_8f43a0
L_8f43a0:
	b L_8c025c
