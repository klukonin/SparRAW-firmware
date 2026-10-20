/* conn__start_detect_a @ 0x8e2c74, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detector_services
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ka_detector__is_enabled, periodic_service__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__start_detect_a
conn__start_detect_a:
	.global L_8e2c74
L_8e2c74:
	push_s blink
L_8e2c76:
	bl L_8c01e4
L_8e2c7a:
	mov_s r13,r0
L_8e2c7c:
	bl.d L_8da214
L_8e2c80:
	mov_s r14,r1
L_8e2c82:
	breq_s r0,0,L_8e2c92
L_8e2c84:
	cmp_s r14,0x0
L_8e2c86:
	mov_s r0,r13
L_8e2c88:
	mov_s r1,0x0
L_8e2c8a:
	mov.eq r1,0x2
L_8e2c8e:
	bl L_8e77c4
	.global L_8e2c92
L_8e2c92:
	b L_8c0254
L_8e2c96:
	nop_s
