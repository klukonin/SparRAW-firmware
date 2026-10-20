/* SDP__hwd_sdp_is_gpio_sdp @ 0x8d14d8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_gpio_sdp() the following port was not expected to be gpio: %d
 *   hw_drivers_sdp.c
 * Зовут его: gpio__dump
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__hwd_sdp_is_gpio_sdp,"ax",@progbits
	.global SDP__hwd_sdp_is_gpio_sdp
SDP__hwd_sdp_is_gpio_sdp:
	.global L_8d14d8
L_8d14d8:
	push_s blink
L_8d14da:
	push_s r13
L_8d14dc:
	bl.d L_8d14a8
L_8d14e0:
	mov_s r13,r0
L_8d14e2:
	brhs r13,0x5,L_8d150c
L_8d14e6:
	mov_s r2,0x1019d48
L_8d14ec:
	mov_s r0,0x0
L_8d14ee:
	mov_s r1,r0
L_8d14f0:
	bl.d L_8edfcc
L_8d14f4:
	mov_s r3,r13
L_8d14f6:
	mov_s r0,blink
L_8d14f8:
	mov_s r2,0x1019c84
L_8d14fe:
	mov_s r1,0x1415
L_8d1504:
	bl.d L_8c82c0
L_8d1508:
	mov r3,0x125
	.global L_8d150c
L_8d150c:
	b L_8c033c
