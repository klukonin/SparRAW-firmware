/* hwd_pcie__set_low_power @ 0x8d77dc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: assert__restore_hw_for_dump, deep_sleep_enter, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_pcie__is_ep_under_serdes, hwd_pcie_exit_l1, pcie_lp__set_byte_field
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__set_low_power
hwd_pcie__set_low_power:
	.global L_8d77dc
L_8d77dc:
	push_s blink
L_8d77de:
	push_s r13
L_8d77e0:
	mov.f r13,r0
L_8d77e4:
	bne_s L_8d77f4
L_8d77e6:
	bl L_8d1470
L_8d77ea:
	cmp_s r0,0x0
L_8d77ec:
	bl.eq.d L_8d12ac
L_8d77f0:
	mov.eq r0,0x1
	.global L_8d77f4
L_8d77f4:
	mov_s r0,0x3
L_8d77f6:
	bl.d L_8d473c
L_8d77fa:
	mov_s r1,r13
L_8d77fc:
	mov_s r0,0x4
L_8d77fe:
	bl.d L_8d473c
L_8d7802:
	mov_s r1,r13
L_8d7804:
	brne_s r13,0,L_8d7814
L_8d7806:
	bl L_8d1470
L_8d780a:
	cmp_s r0,0x0
L_8d780c:
	bl.eq.d L_8d12ac
L_8d7810:
	mov.eq r0,0x0
	.global L_8d7814
L_8d7814:
	b L_8c025c
