/* lmac_if__echo_evt_body @ 0x8e557c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_echo_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, debug_mbox__get_or_init, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__echo_evt_body
lmac_if__echo_evt_body:
	.global L_8e557c
L_8e557c:
	push_s blink
L_8e557e:
	bl L_8c01dc
L_8e5582:
	sub_s sp,sp,0x4
L_8e5584:
	mov_s r16,r0
L_8e5586:
	mov_s r15,r1
L_8e5588:
	mov_s r13,r2
L_8e558a:
	bl.d L_8d9f9c
L_8e558e:
	mov_s r14,r3
L_8e5590:
	mov_s r2,0x0
L_8e5592:
	st_s r2,[sp,0x0]
L_8e5594:
	mov_s r1,r16
L_8e5596:
	mov_s r3,r15
L_8e5598:
	mov_s r4,r13
L_8e559a:
	mov_s r5,r14
L_8e559c:
	mov_s r6,r2
L_8e559e:
	bl.d L_8e4fc4
L_8e55a2:
	mov_s r7,r2
L_8e55a4:
	b.d L_8c0244
L_8e55a8:
	add_s sp,sp,0x4
L_8e55aa:
	nop_s
