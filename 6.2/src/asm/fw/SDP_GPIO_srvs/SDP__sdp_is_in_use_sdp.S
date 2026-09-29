/* SDP__sdp_is_in_use_sdp @ 0x8e4b04, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_is_in_use_sdp() the following port was not declared as in-use sdp: %d
 * Зовут его: SDP__sdp_drive_value
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__sdp_is_in_use_sdp
SDP__sdp_is_in_use_sdp:
	.global L_8e4b04
L_8e4b04:
	push_s blink
L_8e4b06:
	brlo.d r0,0x9,L_8e4b24
L_8e4b0a:
	mov_s r2,r0
L_8e4b0c:
	mov_s r1,0x1009004
L_8e4b12:
	bl.d L_8dcc10
L_8e4b16:
	mov_s r0,0x0
L_8e4b18:
	mov_s r0,blink
L_8e4b1a:
	mov_s r1,0x1410
L_8e4b20:
	bl L_8c9b28
	.global L_8e4b24
L_8e4b24:
	pop_s blink
L_8e4b26:
	j_s [blink]
