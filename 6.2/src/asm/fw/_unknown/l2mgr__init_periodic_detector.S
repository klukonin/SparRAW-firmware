/* l2mgr__init_periodic_detector @ 0x8d8ce0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, detector__init_common
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__init_periodic_detector
l2mgr__init_periodic_detector:
	.global L_8d8ce0
L_8d8ce0:
	push_s blink
L_8d8ce2:
	bl.d L_8c01e0
L_8d8ce6:
	mov r4,0x4
L_8d8cea:
	mov_s r14,r0
L_8d8cec:
	mov_s r1,0x989680
L_8d8cf2:
	mov_s r13,0x0
L_8d8cf4:
	mov_s r2,r13
L_8d8cf6:
	mov_s r15,0x1
L_8d8cf8:
	bl.d L_8d8fa0
L_8d8cfc:
	mov_s r3,r15
L_8d8cfe:
	st_s r15,[r14,0x34]
L_8d8d00:
	st_s r13,[r14,0x30]
L_8d8d02:
	b.d L_8c024c
L_8d8d06:
	st_s r13,[r14,0x38]
