/* ut_hw_modes_cmd_0x308 @ 0x8d4da8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_ret, hw_modes__apply_power_mode, hwd_pcie__set_low_power, hwd_phy__power_up_seq, hwm__apply_mode_flags
 */
	.section .text.ut_hw_modes_cmd_0x308,"ax",@progbits
	.global ut_hw_modes_cmd_0x308
ut_hw_modes_cmd_0x308:
	.global L_8d4da8
L_8d4da8:
	push_s blink
L_8d4daa:
	push_s r13
L_8d4dac:
	mov_s r13,r1
L_8d4dae:
	ld_s r1,[r1]
L_8d4db0:
	breq_s r0,0,L_8d4ddc
L_8d4db2:
	btst_s r1,0x0
L_8d4db4:
	bl.ne.d L_8d50e4
L_8d4db8:
	mov.ne r0,0x1
L_8d4dbc:
	ld_s r0,[r13]
L_8d4dbe:
	bbit0 r0,0x1,L_8d4dca
L_8d4dc2:
	add_s r1,r13,0x4
L_8d4dc4:
	bl.d L_8d5014
L_8d4dc8:
	mov_s r0,0x4
	.global L_8d4dca
L_8d4dca:
	ld_s r0,[r13]
L_8d4dcc:
	bbit0 r0,0x3,L_8d4e0c
L_8d4dd0:
	add r1,r13,0x8
L_8d4dd4:
	bl.d L_8d4d5c
L_8d4dd8:
	mov_s r0,0x1
L_8d4dda:
	b_s L_8d4e0c
	.global L_8d4ddc
L_8d4ddc:
	bbit0 r1,0x3,L_8d4dea
L_8d4de0:
	add r1,r13,0x8
L_8d4de4:
	bl.d L_8d4d5c
L_8d4de8:
	mov_s r0,0x0
	.global L_8d4dea
L_8d4dea:
	ld_s r0,[r13]
L_8d4dec:
	btst_s r0,0x0
L_8d4dee:
	bl.ne.d L_8d50e4
L_8d4df2:
	sub_s.ne r0,r0,r0
L_8d4df4:
	ld_s r0,[r13]
L_8d4df6:
	btst_s r0,0x2
L_8d4df8:
	bl.ne.d L_8d4d20
L_8d4dfc:
	sub_s.ne r0,r0,r0
L_8d4dfe:
	ld_s r0,[r13]
L_8d4e00:
	bbit0 r0,0x1,L_8d4e0c
L_8d4e04:
	add_s r1,r13,0x4
L_8d4e06:
	bl.d L_8d5014
L_8d4e0a:
	mov_s r0,0x0
	.global L_8d4e0c
L_8d4e0c:
	b L_8c033c
