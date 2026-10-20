/* SDP__hwd_sdp_is_defined_mode @ 0x8d1478, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_defined_mode() the following is not a valid GPIO mode: %d
 *   hw_drivers_sdp.c
 * Зовут его: gpio__dump
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__hwd_sdp_is_defined_mode,"ax",@progbits
	.global SDP__hwd_sdp_is_defined_mode
SDP__hwd_sdp_is_defined_mode:
	.global L_8d1478
L_8d1478:
	push_s blink
L_8d147a:
	brlo.d r0,0x4,L_8d14a4
L_8d147e:
	mov_s r3,r0
L_8d1480:
	mov_s r2,0x1019cfc
L_8d1486:
	mov_s r0,0x0
L_8d1488:
	bl.d L_8edfcc
L_8d148c:
	mov_s r1,r0
L_8d148e:
	mov_s r0,blink
L_8d1490:
	mov_s r2,0x1019c84
L_8d1496:
	mov_s r1,0x1414
L_8d149c:
	bl.d L_8c82c0
L_8d14a0:
	mov r3,0x148
	.global L_8d14a4
L_8d14a4:
	pop_s blink
L_8d14a6:
	j_s [blink]
