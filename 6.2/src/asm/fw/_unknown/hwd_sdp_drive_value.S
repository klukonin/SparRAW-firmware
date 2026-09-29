/* hwd_sdp_drive_value @ 0x8f4258, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_sdp_drive_value() - value=[%d], sdp_port=[%d]
 * Зовут его: SDP__sdp_drive_value, SDP__sdp_init__2, ut_hw_drivers__step_8f4480
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_sdp_drive_value
hwd_sdp_drive_value:
	.global L_8f4258
L_8f4258:
	push_s blink
L_8f425a:
	bl L_8c01e4
L_8f425e:
	mov_s r14,r0
L_8f4260:
	mov_s r13,r1
L_8f4262:
	mov_s r1,0x101f2fc
L_8f4268:
	mov_s r0,0x20
L_8f426a:
	mov_s r2,r14
L_8f426c:
	bl.d L_8dcc80
L_8f4270:
	mov_s r3,r13
L_8f4272:
	bl.d L_8f4354
L_8f4276:
	mov_s r0,r13
L_8f4278:
	mov_s r1,0x0
L_8f427a:
	mov_s r0,0x880b80
L_8f4280:
	bset r1,r1,r13
L_8f4284:
	brne r14,0x1,L_8f428c
L_8f4288:
	st_s r1,[r0,0x10]
L_8f428a:
	b_s L_8f428e
	.global L_8f428c
L_8f428c:
	st_s r1,[r0,0x8]
	.global L_8f428e
L_8f428e:
	b L_8c0254
L_8f4292:
	nop_s
