/* hwm__apply_mode_flags @ 0x8d7818, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, assert__restore_hw_for_dump, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_abif__rgf_880b00, hwd_pcie__set_clk_gating, hwd_phy__enable_880a80, mac__set_880afc_bits26_31_fw, pcie__apply_mode_fw_8825c0__8d10c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm__apply_mode_flags
hwm__apply_mode_flags:
	.global L_8d7818
L_8d7818:
	push_s blink
L_8d781a:
	bl L_8c01e4
L_8d781e:
	mov_s r14,r0
L_8d7820:
	ld_s r0,[r1]
L_8d7822:
	mov_s r13,r1
L_8d7824:
	btst_s r0,0x0
L_8d7826:
	bl.ne.d L_8d04b8
L_8d782a:
	mov.ne r0,r14
L_8d782e:
	ld_s r0,[r13]
L_8d7830:
	btst_s r0,0x1
L_8d7832:
	bl.ne.d L_8d10c8
L_8d7836:
	mov.ne r0,r14
L_8d783a:
	ld_s r0,[r13]
L_8d783c:
	btst_s r0,0x2
L_8d783e:
	bl.ne.d L_8d1b2c
L_8d7842:
	mov.ne r0,r14
L_8d7846:
	ld_s r0,[r13]
L_8d7848:
	btst_s r0,0x3
L_8d784a:
	bl.ne.d L_8d0e5c
L_8d784e:
	mov.ne r0,r14
L_8d7852:
	ld_s r0,[r13]
L_8d7854:
	btst_s r0,0x4
L_8d7856:
	bl.ne.d L_8d00cc
L_8d785a:
	mov.ne r0,r14
L_8d785e:
	b L_8c0254
L_8d7862:
	nop_s
