/* ut_hw_modes_cmd_0x308 @ 0x8d7864, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_to_r13_ret, hw_modes__apply_power_mode, hwd_pcie__set_low_power, hwd_phy__power_up_seq, hwm__apply_mode_flags
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes_cmd_0x308
ut_hw_modes_cmd_0x308:
	.global L_8d7864
L_8d7864:
	push_s blink
L_8d7866:
	push_s r13
L_8d7868:
	mov_s r13,r1
L_8d786a:
	ld_s r1,[r1]
L_8d786c:
	breq_s r0,0,L_8d7898
L_8d786e:
	btst_s r1,0x0
L_8d7870:
	bl.ne.d L_8d7b84
L_8d7874:
	mov.ne r0,0x1
L_8d7878:
	ld_s r0,[r13]
L_8d787a:
	bbit0 r0,0x1,L_8d7886
L_8d787e:
	add_s r1,r13,0x4
L_8d7880:
	bl.d L_8d7ac0
L_8d7884:
	mov_s r0,0x4
	.global L_8d7886
L_8d7886:
	ld_s r0,[r13]
L_8d7888:
	bbit0 r0,0x3,L_8d78c8
L_8d788c:
	add r1,r13,0x8
L_8d7890:
	bl.d L_8d7818
L_8d7894:
	mov_s r0,0x1
L_8d7896:
	b_s L_8d78c8
	.global L_8d7898
L_8d7898:
	bbit0 r1,0x3,L_8d78a6
L_8d789c:
	add r1,r13,0x8
L_8d78a0:
	bl.d L_8d7818
L_8d78a4:
	mov_s r0,0x0
	.global L_8d78a6
L_8d78a6:
	ld_s r0,[r13]
L_8d78a8:
	btst_s r0,0x0
L_8d78aa:
	bl.ne.d L_8d7b84
L_8d78ae:
	sub_s.ne r0,r0,r0
L_8d78b0:
	ld_s r0,[r13]
L_8d78b2:
	btst_s r0,0x2
L_8d78b4:
	bl.ne.d L_8d77dc
L_8d78b8:
	sub_s.ne r0,r0,r0
L_8d78ba:
	ld_s r0,[r13]
L_8d78bc:
	bbit0 r0,0x1,L_8d78c8
L_8d78c0:
	add_s r1,r13,0x4
L_8d78c2:
	bl.d L_8d7ac0
L_8d78c6:
	mov_s r0,0x0
	.global L_8d78c8
L_8d78c8:
	b L_8c025c
