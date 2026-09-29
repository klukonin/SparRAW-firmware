/* ut_hw_drivers__step_8f4480 @ 0x8f3f1c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, gpio__set_pin_func_and_dump, gpio__write_ctrl_b84, hwd_sdp_drive_value, sdp__set_defined_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__step_8f4480
ut_hw_drivers__step_8f4480:
	.global L_8f3f1c
L_8f3f1c:
	push_s blink
L_8f3f1e:
	bl L_8c01d4
L_8f3f22:
	mov_s r17,r0
L_8f3f24:
	mov_s r16,r1
L_8f3f26:
	mov_s r18,r2
L_8f3f28:
	bl.d L_8f4480
L_8f3f2c:
	mov_s r0,0x1
L_8f3f2e:
	mov_s r14,0x0
L_8f3f30:
	b_s L_8f3f4e
	.global L_8f3f32
L_8f3f32:
	mov_s r0,0x1
L_8f3f34:
	bl.d L_8f43d4
L_8f3f38:
	mov_s r1,r13
L_8f3f3a:
	and r0,r15,r18
L_8f3f3e:
	sub.f r0,r0,0x0
L_8f3f42:
	mov.ne r0,0x1
L_8f3f46:
	bl.d L_8f4258
L_8f3f4a:
	mov_s r1,r13
	.global L_8f3f4c
L_8f3f4c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8f3f4e
L_8f3f4e:
	brge r14,0x17,L_8f3f78
L_8f3f52:
	add_s r13,r14,0x5
L_8f3f54:
	mov_s r15,0x0
L_8f3f56:
	bset r15,r15,r14
L_8f3f5a:
	tst r15,r17
L_8f3f5e:
	sub_s.ne r0,r0,r0
L_8f3f60:
	bl.ne.d L_8f4294
L_8f3f64:
	mov.ne r1,r13
L_8f3f68:
	tst r15,r16
L_8f3f6c:
	bne_s L_8f3f32
L_8f3f6e:
	mov_s r0,0x0
L_8f3f70:
	bl.d L_8f43d4
L_8f3f74:
	mov_s r1,r13
L_8f3f76:
	b_s L_8f3f4c
	.global L_8f3f78
L_8f3f78:
	b L_8c0234
