/* hwd_pcie__set_low_power @ 0x8d4d20, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: assert__restore_hw_for_dump, deep_sleep_enter, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r13_ret, get_reg8825bc_bit3_inv, hwd_pcie_exit_l1, rgf_reg_880280_8d168c
 */
	.section .text.hwd_pcie__set_low_power,"ax",@progbits
	.global hwd_pcie__set_low_power
hwd_pcie__set_low_power:
	.global L_8d4d20
L_8d4d20:
	push_s blink
L_8d4d22:
	push_s r13
L_8d4d24:
	mov.f r13,r0
L_8d4d28:
	bne_s L_8d4d38
L_8d4d2a:
	bl L_8ce774
L_8d4d2e:
	cmp_s r0,0x0
L_8d4d30:
	bl.eq.d L_8ce578
L_8d4d34:
	mov.eq r0,0x1
	.global L_8d4d38
L_8d4d38:
	mov_s r0,0x3
L_8d4d3a:
	bl.d L_8d168c
L_8d4d3e:
	mov_s r1,r13
L_8d4d40:
	mov_s r0,0x4
L_8d4d42:
	bl.d L_8d168c
L_8d4d46:
	mov_s r1,r13
L_8d4d48:
	brne_s r13,0,L_8d4d58
L_8d4d4a:
	bl L_8ce774
L_8d4d4e:
	cmp_s r0,0x0
L_8d4d50:
	bl.eq.d L_8ce578
L_8d4d54:
	mov.eq r0,0x0
	.global L_8d4d58
L_8d4d58:
	b L_8c033c
