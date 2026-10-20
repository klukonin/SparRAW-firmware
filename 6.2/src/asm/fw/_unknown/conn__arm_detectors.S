/* conn__arm_detectors @ 0x8e007c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__rearm_all_detectors
 * Зовёт сам: __ld_r13_to_r13_ret, conn__arm_detect_step, conn__arm_detect_tail
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__arm_detectors
conn__arm_detectors:
	.global L_8e007c
L_8e007c:
	b.d L_8e0084
L_8e0080:
	add_s r0,r0,0x70
L_8e0082:
	nop_s
	.global L_8e0084
L_8e0084:
	push_s blink
L_8e0086:
	push_s r13
L_8e0088:
	mov_s r13,r0
L_8e008a:
	ld_s r0,[r0,0x7c]
L_8e008c:
	cmp_s r0,0x0
L_8e008e:
	bl.ne L_8e0104
L_8e0092:
	ld_s r0,[r13,0x7c]
L_8e0094:
	cmp_s r0,0x0
L_8e0096:
	bl.ne.d L_8e00e8
L_8e009a:
	add2.ne r0,r0,0x15
L_8e009e:
	b L_8c025c
L_8e00a2:
	nop_s
