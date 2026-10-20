/* ut_hw_drivers_cmd_0x508 @ 0x8d0f28, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_rfc.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_rfc_write_core
 */
	.section .text.ut_hw_drivers_cmd_0x508,"ax",@progbits
	.global ut_hw_drivers_cmd_0x508
ut_hw_drivers_cmd_0x508:
	.global L_8d0f28
L_8d0f28:
	push_s blink
L_8d0f2a:
	bl L_8c02bc
L_8d0f2e:
	mov_s r16,r0
L_8d0f30:
	cmp_s r1,0x7f
L_8d0f32:
	mov_s r13,r1
L_8d0f34:
	mov_s r14,r2
L_8d0f36:
	bgt_s L_8d0f52
	.global L_8d0f38
L_8d0f38:
	brge r14,0x10,L_8d0f68
	.global L_8d0f3c
L_8d0f3c:
	bmsk_s r14,r14,0x3
L_8d0f3e:
	asl_s r2,r14,0x7
L_8d0f40:
	bmsk_s r13,r13,0x6
L_8d0f42:
	mov_s r0,r16
L_8d0f44:
	mov_s r1,0xa
L_8d0f46:
	or_s r2,r2,r13
L_8d0f48:
	bl.d L_8d0f80
L_8d0f4c:
	mov_s r3,0x0
L_8d0f4e:
	b L_8c0324
	.global L_8d0f52
L_8d0f52:
	mov_s r0,blink
L_8d0f54:
	mov_s r2,0x1018f58
L_8d0f5a:
	mov_s r1,0x1156
L_8d0f60:
	bl.d L_8c82c0
L_8d0f64:
	mov_s r3,0xe9
L_8d0f66:
	b_s L_8d0f38
	.global L_8d0f68
L_8d0f68:
	mov_s r0,blink
L_8d0f6a:
	mov_s r2,0x1018f58
L_8d0f70:
	mov_s r1,0x115b
L_8d0f76:
	bl.d L_8c82c0
L_8d0f7a:
	mov_s r3,0xea
L_8d0f7c:
	b_s L_8d0f3c
L_8d0f7e:
	nop_s
