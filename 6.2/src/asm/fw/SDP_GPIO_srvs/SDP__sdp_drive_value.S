/* SDP__sdp_drive_value @ 0x8e4abc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_drive_value() the following sdp port is not output enabled: %d
 * Зовут его: POWER_MNGR__halt, deep_sleep_exit, sdp__drive_pin_timed
 * Зовёт сам: SDP__sdp_is_in_use_sdp, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, hwd_sdp_drive_value
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SDP__sdp_drive_value
SDP__sdp_drive_value:
	.global L_8e4abc
L_8e4abc:
	push_s blink
L_8e4abe:
	bl L_8c01dc
L_8e4ac2:
	mov_s r16,r0
L_8e4ac4:
	mov_s r13,r1
L_8e4ac6:
	bl.d L_8e4b04
L_8e4aca:
	mov_s r0,r1
L_8e4acc:
	mov_s r0,0x800c34
L_8e4ad2:
	ld.as r13,[r0,r13]
L_8e4ad6:
	bbit1 r13,0x8,L_8e4af6
L_8e4ada:
	mov_s r1,0x1009054
L_8e4ae0:
	mov_s r0,0x0
L_8e4ae2:
	bl.d L_8dcc10
L_8e4ae6:
	bmsk r2,r13,0x4
L_8e4aea:
	mov_s r0,blink
L_8e4aec:
	mov_s r1,0x140f
L_8e4af2:
	bl L_8c9b28
	.global L_8e4af6
L_8e4af6:
	mov_s r0,r16
L_8e4af8:
	bl.d L_8f4258
L_8e4afc:
	bmsk r1,r13,0x4
L_8e4b00:
	b L_8c0244
