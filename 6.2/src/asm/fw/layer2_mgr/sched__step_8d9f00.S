/* sched__step_8d9f00 @ 0x8f58e4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: operational_if__init_mbox_ptr
 * Зовёт сам: __ld_r13_to_r13_ret, operational_if__mbox_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__step_8d9f00
sched__step_8d9f00:
	.global L_8f58e4
L_8f58e4:
	push_s blink
L_8f58e6:
	push_s r13
L_8f58e8:
	mov_s r13,r0
L_8f58ea:
	bl.d L_8d9f00
L_8f58ee:
	mov_s r0,r1
L_8f58f0:
	b.d L_8c025c
L_8f58f4:
	st_s r0,[r13]
L_8f58f6:
	nop_s
