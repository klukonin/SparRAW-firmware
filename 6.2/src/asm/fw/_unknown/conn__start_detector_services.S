/* conn__start_detector_services @ 0x8e2bfc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__start_all_detector_services
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__start_detect_a, conn__start_detect_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__start_detector_services
conn__start_detector_services:
	.global L_8e2bfc
L_8e2bfc:
	b.d L_8e2c04
L_8e2c00:
	add_s r0,r0,0x70
L_8e2c02:
	nop_s
	.global L_8e2c04
L_8e2c04:
	push_s blink
L_8e2c06:
	bl L_8c01e4
L_8e2c0a:
	mov_s r13,r0
L_8e2c0c:
	ld_s r0,[r0,0x7c]
L_8e2c0e:
	mov_s r14,r1
L_8e2c10:
	cmp_s r0,0x0
L_8e2c12:
	bl.ne L_8e2c98
L_8e2c16:
	ld_s r0,[r13,0x7c]
L_8e2c18:
	cmp_s r0,0x0
L_8e2c1a:
	add2.ne r0,r0,0x15
L_8e2c1e:
	bl.ne.d L_8e2c74
L_8e2c22:
	mov.ne r1,r14
L_8e2c26:
	b L_8c0254
L_8e2c2a:
	nop_s
