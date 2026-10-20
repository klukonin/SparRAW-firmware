/* pcie__ready_for_deep_sleep @ 0x8d1088, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 * Зовёт сам: hwd_pcie__get_882b80, hwd_pcie__rgf_882f80_8d15b4, pcie__l1_idle_and_park
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__ready_for_deep_sleep
pcie__ready_for_deep_sleep:
	.global L_8d1088
L_8d1088:
	push_s blink
L_8d108a:
	bl L_8d1428
L_8d108e:
	breq_s r0,0,L_8d1096
L_8d1090:
	bl L_8d10ac
L_8d1094:
	breq_s r0,0,L_8d109a
	.global L_8d1096
L_8d1096:
	mov_s r0,0x1
L_8d1098:
	b_s L_8d10a6
	.global L_8d109a
L_8d109a:
	bl L_8d15b4
L_8d109e:
	bl L_8d10ac
L_8d10a2:
	brne_s r0,0,L_8d1096
L_8d10a4:
	mov_s r0,0x0
	.global L_8d10a6
L_8d10a6:
	pop_s blink
L_8d10a8:
	j_s [blink]
L_8d10aa:
	nop_s
