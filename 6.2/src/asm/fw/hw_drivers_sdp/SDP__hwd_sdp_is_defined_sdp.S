/* SDP__hwd_sdp_is_defined_sdp @ 0x8f4354, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_defined_sdp() the following port was not expected to be sdp: %d
 * Зовут его: SDP__hwd_sdp_is_gpio_sdp, SDP__hwd_sdp_is_int_ctrl_sdp, hw_personality__read_strap, hwd_sdp_drive_value, sdp__read_880b98_bit, sdp__set_defined_bit
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__hwd_sdp_is_defined_sdp
SDP__hwd_sdp_is_defined_sdp:
	.global L_8f4354
L_8f4354:
	push_s blink
L_8f4356:
	brlo.d r0,0x1c,L_8f4374
L_8f435a:
	mov_s r2,r0
L_8f435c:
	mov_s r1,0x101f2ac
L_8f4362:
	bl.d L_8dcc10
L_8f4366:
	mov_s r0,0x0
L_8f4368:
	mov_s r0,blink
L_8f436a:
	mov_s r1,0x1312
L_8f4370:
	bl L_8c9b28
	.global L_8f4374
L_8f4374:
	pop_s blink
L_8f4376:
	j_s [blink]
