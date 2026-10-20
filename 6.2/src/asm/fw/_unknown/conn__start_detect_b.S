/* conn__start_detect_b @ 0x8e2c98, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detector_services
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, periodic_service__start, tx_ageing_detector__is_enabled
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__start_detect_b
conn__start_detect_b:
	.global L_8e2c98
L_8e2c98:
	push_s blink
L_8e2c9a:
	bl L_8c01e4
L_8e2c9e:
	mov_s r13,r0
L_8e2ca0:
	bl.d L_8da260
L_8e2ca4:
	mov_s r14,r1
L_8e2ca6:
	breq_s r0,0,L_8e2cb6
L_8e2ca8:
	cmp_s r14,0x0
L_8e2caa:
	mov_s r0,r13
L_8e2cac:
	mov_s r1,0x0
L_8e2cae:
	mov.eq r1,0x2
L_8e2cb2:
	bl L_8e77c4
	.global L_8e2cb6
L_8e2cb6:
	b L_8c0254
L_8e2cba:
	nop_s
