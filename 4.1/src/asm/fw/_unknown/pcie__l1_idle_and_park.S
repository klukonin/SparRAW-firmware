/* pcie__l1_idle_and_park @ 0x8ce368, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ready_for_deep_sleep
 * Зовёт сам: hwd_pcie_ltssm_is_l1_idle, set_reg_882fd0
 */
	.section .text.pcie__l1_idle_and_park,"ax",@progbits
	.global pcie__l1_idle_and_park
pcie__l1_idle_and_park:
	.global L_8ce368
L_8ce368:
	push_s blink
L_8ce36a:
	bl L_8ce32c
L_8ce36e:
	breq_s r0,0,L_8ce37e
L_8ce370:
	bl L_8ce8f8
L_8ce374:
	bl L_8ce32c
L_8ce378:
	cmp_s r0,0x0
L_8ce37a:
	mov_s r0,0x1
L_8ce37c:
	bne_s L_8ce380
	.global L_8ce37e
L_8ce37e:
	mov_s r0,0x0
	.global L_8ce380
L_8ce380:
	pop_s blink
L_8ce382:
	j_s [blink]
