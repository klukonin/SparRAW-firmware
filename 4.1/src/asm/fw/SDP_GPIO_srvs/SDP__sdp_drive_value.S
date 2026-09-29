/* SDP__sdp_drive_value @ 0x8dfe00, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::sdp_drive_value() the following sdp port is not output enabled: %d
 *   SDP_GPIO_srvs.c
 * Зовут его: POWER_MNGR__halt, power_deep_sleep_exit_step, tail_SDP__sdp_drive_value
 * Зовёт сам: SDP__sdp_is_in_use_sdp, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, sdp__drive_pin
 */
	.section .text.SDP__sdp_drive_value,"ax",@progbits
	.global SDP__sdp_drive_value
SDP__sdp_drive_value:
	.global L_8dfe00
L_8dfe00:
	push_s blink
L_8dfe02:
	bl L_8c02bc
L_8dfe06:
	mov_s r16,r0
L_8dfe08:
	mov_s r13,r1
L_8dfe0a:
	bl.d L_8dffa8
L_8dfe0e:
	mov_s r0,r1
L_8dfe10:
	mov_s r0,0x800ce8
L_8dfe16:
	ld.as r13,[r0,r13]
L_8dfe1a:
	bbit1 r13,0x8,L_8dfe44
L_8dfe1e:
	mov_s r2,0x10083dc
L_8dfe24:
	mov_s r0,0x0
L_8dfe26:
	mov_s r1,r0
L_8dfe28:
	bl.d L_8edfcc
L_8dfe2c:
	bmsk r3,r13,0x4
L_8dfe30:
	mov_s r0,blink
L_8dfe32:
	mov_s r2,0x100829c
L_8dfe38:
	mov_s r1,0x140f
L_8dfe3e:
	bl.d L_8c82c0
L_8dfe42:
	mov_s r3,0xf5
	.global L_8dfe44
L_8dfe44:
	mov_s r0,r16
L_8dfe46:
	bl.d L_8d13b0
L_8dfe4a:
	bmsk r1,r13,0x4
L_8dfe4e:
	b L_8c0324
L_8dfe52:
	nop_s
