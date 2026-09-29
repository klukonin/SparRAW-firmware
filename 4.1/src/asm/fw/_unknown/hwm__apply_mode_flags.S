/* hwm__apply_mode_flags @ 0x8d4d5c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, assert__restore_hw_for_dump, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_abif__rgf_880b00, hwd_pcie__set_clk_gating, hwd_phy__enable_880a80, pcie__apply_880a80_mode, rgf_reg_880a80_8cd62c
 */
	.section .text.hwm__apply_mode_flags,"ax",@progbits
	.global hwm__apply_mode_flags
hwm__apply_mode_flags:
	.global L_8d4d5c
L_8d4d5c:
	push_s blink
L_8d4d5e:
	bl L_8c02c4
L_8d4d62:
	mov_s r14,r0
L_8d4d64:
	ld_s r0,[r1]
L_8d4d66:
	mov_s r13,r1
L_8d4d68:
	btst_s r0,0x0
L_8d4d6a:
	bl.ne.d L_8cd62c
L_8d4d6e:
	mov.ne r0,r14
L_8d4d72:
	ld_s r0,[r13]
L_8d4d74:
	btst_s r0,0x1
L_8d4d76:
	bl.ne.d L_8ce384
L_8d4d7a:
	mov.ne r0,r14
L_8d4d7e:
	ld_s r0,[r13]
L_8d4d80:
	btst_s r0,0x2
L_8d4d82:
	bl.ne.d L_8cee90
L_8d4d86:
	mov.ne r0,r14
L_8d4d8a:
	ld_s r0,[r13]
L_8d4d8c:
	btst_s r0,0x3
L_8d4d8e:
	bl.ne.d L_8ce110
L_8d4d92:
	mov.ne r0,r14
L_8d4d96:
	ld_s r0,[r13]
L_8d4d98:
	btst_s r0,0x4
L_8d4d9a:
	bl.ne.d L_8cd1ac
L_8d4d9e:
	mov.ne r0,r14
L_8d4da2:
	b L_8c0334
L_8d4da6:
	nop_s
