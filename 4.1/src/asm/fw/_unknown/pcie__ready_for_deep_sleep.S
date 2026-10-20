/* pcie__ready_for_deep_sleep @ 0x8ce344, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 * Зовёт сам: hwd_pcie__get_882b80, hwd_pcie__rgf_882f80_8ce8bc, pcie__l1_idle_and_park
 */
	.section .text.pcie__ready_for_deep_sleep,"ax",@progbits
	.global pcie__ready_for_deep_sleep
pcie__ready_for_deep_sleep:
	.global L_8ce344
L_8ce344:
	push_s blink
L_8ce346:
	bl L_8ce72c
L_8ce34a:
	breq_s r0,0,L_8ce352
L_8ce34c:
	bl L_8ce368
L_8ce350:
	breq_s r0,0,L_8ce356
	.global L_8ce352
L_8ce352:
	mov_s r0,0x1
L_8ce354:
	b_s L_8ce362
	.global L_8ce356
L_8ce356:
	bl L_8ce8bc
L_8ce35a:
	bl L_8ce368
L_8ce35e:
	brne_s r0,0,L_8ce352
L_8ce360:
	mov_s r0,0x0
	.global L_8ce362
L_8ce362:
	pop_s blink
L_8ce364:
	j_s [blink]
L_8ce366:
	nop_s
