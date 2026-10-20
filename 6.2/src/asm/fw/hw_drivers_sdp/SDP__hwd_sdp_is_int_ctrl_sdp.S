/* SDP__hwd_sdp_is_int_ctrl_sdp @ 0x8f43a4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_int_ctrl_sdp() the following port was not expected to be interrupt controled: %d
 * Зовут его: sdp__init_int_ctrl, sdp__set_int_ctrl_bit
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__hwd_sdp_is_int_ctrl_sdp
SDP__hwd_sdp_is_int_ctrl_sdp:
	.global L_8f43a4
L_8f43a4:
	push_s blink
L_8f43a6:
	push_s r13
L_8f43a8:
	bl.d L_8f4354
L_8f43ac:
	mov_s r13,r0
L_8f43ae:
	brlo r13,0xa,L_8f43b6
L_8f43b2:
	brlo r13,0x10,L_8f43d0
	.global L_8f43b6
L_8f43b6:
	mov_s r1,0x101f350
L_8f43bc:
	mov_s r0,0x0
L_8f43be:
	bl.d L_8dcc10
L_8f43c2:
	mov_s r2,r13
L_8f43c4:
	mov_s r0,blink
L_8f43c6:
	mov_s r1,0x1310
L_8f43cc:
	bl L_8c9b28
	.global L_8f43d0
L_8f43d0:
	b L_8c025c
