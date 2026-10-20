/* SDP__hwd_sdp_is_defined_sdp @ 0x8d14a8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_defined_sdp() the following port was not expected to be sdp: %d
 *   hw_drivers_sdp.c
 * Зовут его: SDP__hwd_sdp_is_gpio_sdp, SDP__hwd_sdp_is_int_ctrl_sdp, hw_personality__read_strap, rgf_reg_880b00, sdp__drive_pin
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__hwd_sdp_is_defined_sdp,"ax",@progbits
	.global SDP__hwd_sdp_is_defined_sdp
SDP__hwd_sdp_is_defined_sdp:
	.global L_8d14a8
L_8d14a8:
	push_s blink
L_8d14aa:
	brlo.d r0,0x1c,L_8d14d4
L_8d14ae:
	mov_s r3,r0
L_8d14b0:
	mov_s r2,0x1019c34
L_8d14b6:
	mov_s r0,0x0
L_8d14b8:
	bl.d L_8edfcc
L_8d14bc:
	mov_s r1,r0
L_8d14be:
	mov_s r0,blink
L_8d14c0:
	mov_s r2,0x1019c84
L_8d14c6:
	mov_s r1,0x1312
L_8d14cc:
	bl.d L_8c82c0
L_8d14d0:
	mov r3,0x117
	.global L_8d14d4
L_8d14d4:
	pop_s blink
L_8d14d6:
	j_s [blink]
