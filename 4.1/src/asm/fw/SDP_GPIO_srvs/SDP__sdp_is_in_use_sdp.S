/* SDP__sdp_is_in_use_sdp @ 0x8dffa8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_is_in_use_sdp() the following port was not declared as in-use sdp: %d
 *   SDP_GPIO_srvs.c
 * Зовут его: SDP__sdp_drive_value
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__sdp_is_in_use_sdp,"ax",@progbits
	.global SDP__sdp_is_in_use_sdp
SDP__sdp_is_in_use_sdp:
	.global L_8dffa8
L_8dffa8:
	push_s blink
L_8dffaa:
	brlo.d r0,0x8,L_8dffd4
L_8dffae:
	mov_s r3,r0
L_8dffb0:
	mov_s r2,0x100838c
L_8dffb6:
	mov_s r0,0x0
L_8dffb8:
	bl.d L_8edfcc
L_8dffbc:
	mov_s r1,r0
L_8dffbe:
	mov_s r0,blink
L_8dffc0:
	mov_s r2,0x100829c
L_8dffc6:
	mov_s r1,0x1410
L_8dffcc:
	bl.d L_8c82c0
L_8dffd0:
	mov r3,0x183
	.global L_8dffd4
L_8dffd4:
	pop_s blink
L_8dffd6:
	j_s [blink]
