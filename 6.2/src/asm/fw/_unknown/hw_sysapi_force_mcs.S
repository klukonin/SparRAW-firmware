/* hw_sysapi_force_mcs @ 0x8cdde8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_force_mcs(): sta_id = %d, force_en = %d, mcs = %d
 *   sta_id [%d] out of range
 *   mcs [%d] is not supported
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit3, lmac_if_send_cmd_0x30
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_force_mcs
hw_sysapi_force_mcs:
	.global L_8cdde8
L_8cdde8:
	push_s blink
L_8cddea:
	bl L_8c01dc
L_8cddee:
	mov_s r13,r0
L_8cddf0:
	mov_s r16,r1
L_8cddf2:
	mov_s r15,r2
L_8cddf4:
	mov_s r1,0x101a49c
L_8cddfa:
	mov_s r0,0x25
L_8cddfc:
	mov_s r2,r13
L_8cddfe:
	mov_s r3,r16
L_8cde00:
	bl.d L_8dcd00
L_8cde04:
	mov_s r4,r15
L_8cde06:
	brlt r13,0x8,L_8cde1c
L_8cde0a:
	mov_s r1,0x101a4d8
L_8cde10:
	mov_s r0,0x5
L_8cde12:
	mov_s r2,r13
	.global L_8cde14
L_8cde14:
	bl L_8dcc10
L_8cde18:
	mov_s r0,0x0
L_8cde1a:
	b_s L_8cde40
	.global L_8cde1c
L_8cde1c:
	mov_s r0,0x1dde
L_8cde22:
	mov_s r14,0x1
L_8cde24:
	bbit1 r0,r15,L_8cde34
L_8cde28:
	mov_s r1,0x101a4f4
L_8cde2e:
	mov_s r0,0x5
L_8cde30:
	mov_s r2,r15
L_8cde32:
	b_s L_8cde14
	.global L_8cde34
L_8cde34:
	mov_s r0,r13
L_8cde36:
	mov_s r1,r16
L_8cde38:
	bl.d L_8db7f8
L_8cde3c:
	mov_s r2,r15
L_8cde3e:
	mov_s r0,r14
	.global L_8cde40
L_8cde40:
	b L_8c0244
