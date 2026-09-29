/* SDP__hwd_sdp_is_defined_mode @ 0x8f4330, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_defined_mode() the following is not a valid GPIO mode: %d
 * Зовут его: gpio__set_pin_func_and_dump
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__hwd_sdp_is_defined_mode
SDP__hwd_sdp_is_defined_mode:
	.global L_8f4330
L_8f4330:
	push_s blink
L_8f4332:
	brlo.d r0,0x4,L_8f4350
L_8f4336:
	mov_s r2,r0
L_8f4338:
	mov_s r1,0x101f3b4
L_8f433e:
	bl.d L_8dcc10
L_8f4342:
	mov_s r0,0x0
L_8f4344:
	mov_s r0,blink
L_8f4346:
	mov_s r1,0x1414
L_8f434c:
	bl L_8c9b28
	.global L_8f4350
L_8f4350:
	pop_s blink
L_8f4352:
	j_s [blink]
