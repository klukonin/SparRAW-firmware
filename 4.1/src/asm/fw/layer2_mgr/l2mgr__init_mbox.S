/* l2mgr__init_mbox @ 0x8ed544, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init_operational_if
 * Зовёт сам: __ld_r13_ret, operational_if__mbox_init
 */
	.section .text.l2mgr__init_mbox,"ax",@progbits
	.global l2mgr__init_mbox
l2mgr__init_mbox:
	.global L_8ed544
L_8ed544:
	push_s blink
L_8ed546:
	push_s r13
L_8ed548:
	mov_s r13,r0
L_8ed54a:
	bl.d L_8d6df8
L_8ed54e:
	mov_s r0,r1
L_8ed550:
	b.d L_8c033c
