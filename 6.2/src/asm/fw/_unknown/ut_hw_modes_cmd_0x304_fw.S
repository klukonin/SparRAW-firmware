/* ut_hw_modes_cmd_0x304_fw @ 0x8d7c04, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_to_r13_ret, hw_modes__pll_bypass, hw_modes__pll_engage, hwd_abif__bgap_ctrl
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes_cmd_0x304_fw
ut_hw_modes_cmd_0x304_fw:
	.global L_8d7c04
L_8d7c04:
	push_s blink
L_8d7c06:
	push_s r13
L_8d7c08:
	brne_s r1,0,L_8d7c36
L_8d7c0a:
	mov_s r13,0x889480
L_8d7c10:
	brne r0,0x1,L_8d7c26
L_8d7c14:
	bl L_8d7748
L_8d7c18:
	ld_s r0,[r13,0x24]
L_8d7c1a:
	bset_s r0,r0,0x0
L_8d7c1c:
	st_s r0,[r13,0x24]
L_8d7c1e:
	bl.d L_8ce5c0
L_8d7c22:
	mov_s r0,0x0
L_8d7c24:
	b_s L_8d7c36
	.global L_8d7c26
L_8d7c26:
	bl.d L_8ce5c0
L_8d7c2a:
	mov_s r0,0x1
L_8d7c2c:
	ld_s r0,[r13,0x24]
L_8d7c2e:
	bclr_s r0,r0,0x0
L_8d7c30:
	st_s r0,[r13,0x24]
L_8d7c32:
	bl L_8d7714
	.global L_8d7c36
L_8d7c36:
	b L_8c025c
L_8d7c3a:
	nop_s
