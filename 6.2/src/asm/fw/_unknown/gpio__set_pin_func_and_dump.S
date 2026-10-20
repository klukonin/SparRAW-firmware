/* gpio__set_pin_func_and_dump @ 0x8f4294, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   GPIO0 = 0x%8X GPIO1 = 0x%8X GPIO2 = 0x%8X
 * Зовут его: SDP__sdp_init__2, ut_hw_drivers__step_8f4480
 * Зовёт сам: SDP__hwd_sdp_is_defined_mode, SDP__hwd_sdp_is_gpio_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global gpio__set_pin_func_and_dump
gpio__set_pin_func_and_dump:
	.global L_8f4294
L_8f4294:
	push_s blink
L_8f4296:
	bl L_8c01e4
L_8f429a:
	mov_s r13,r0
L_8f429c:
	bl.d L_8f4330
L_8f42a0:
	mov_s r14,r1
L_8f42a2:
	bl.d L_8f4378
L_8f42a6:
	mov_s r0,r14
L_8f42a8:
	sub_s r1,r14,0x5
L_8f42aa:
	lsr r2,r1,0x3
L_8f42ae:
	bmsk_s r1,r1,0x2
L_8f42b0:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8f42b2:
	mov_s r0,0x880068
L_8f42b8:
	add2_s r0,r0,r2
L_8f42ba:
	ld_s r3,[r0]
L_8f42bc:
	mov_s r2,0xf
L_8f42be:
	asl_s r2,r2,r1
L_8f42c0:
	bic_s r3,r3,r2
L_8f42c2:
	asl_s r13,r13,r1
L_8f42c4:
	or_s r13,r13,r3
L_8f42c6:
	st_s r13,[r0]
L_8f42c8:
	mov_s r0,0x11
L_8f42ca:
	asl_s r0,r0,0x13
L_8f42cc:
	ld_s r2,[r0,0x68]
L_8f42ce:
	mov_s r1,0x101f450
L_8f42d4:
	ld_s r3,[r0,0x6c]
L_8f42d6:
	ld r4,[r0, 0x70]
L_8f42da:
	bl.d L_8dcd00
L_8f42de:
	mov_s r0,0x20
L_8f42e0:
	b L_8c0254
