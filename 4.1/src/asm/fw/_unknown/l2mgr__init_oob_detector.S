/* l2mgr__init_oob_detector @ 0x8d5aac, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, detector__init_common
 */
	.section .text.l2mgr__init_oob_detector,"ax",@progbits
	.global l2mgr__init_oob_detector
l2mgr__init_oob_detector:
	.global L_8d5aac
L_8d5aac:
	push_s blink
L_8d5aae:
	bl.d L_8c02c0
L_8d5ab2:
	mov r4,0x4
L_8d5ab6:
	mov_s r13,r0
L_8d5ab8:
	mov_s r1,0x186a0
L_8d5abe:
	mov_s r14,0x0
L_8d5ac0:
	mov_s r2,r14
L_8d5ac2:
	mov_s r15,0x1
L_8d5ac4:
	bl.d L_8d5e80
L_8d5ac8:
	mov_s r3,r15
L_8d5aca:
	st_s r15,[r13,0x34]
L_8d5acc:
	b.d L_8c032c
L_8d5ad0:
	st_s r14,[r13,0x30]
L_8d5ad2:
	nop_s
