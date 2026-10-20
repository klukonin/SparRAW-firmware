/* ut_hw_modes_step @ 0x8d4aa8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, calib_lo_leakage__vt20, calib_mngr_step_b, hwf_calib__release_hw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rgf_88a000_8cd018, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_sel_nibbles
 */
	.section .text.ut_hw_modes_step,"ax",@progbits
	.global ut_hw_modes_step
ut_hw_modes_step:
	.global L_8d4aa8
L_8d4aa8:
	push_s blink
L_8d4aaa:
	bl L_8c02b8
L_8d4aae:
	mov_s r16,r0
L_8d4ab0:
	mov_s r0,r1
L_8d4ab2:
	bl.d L_8cd018
L_8d4ab6:
	mov_s r1,r2
L_8d4ab8:
	mov_s r14,0x88af00
L_8d4abe:
	mov_s r0,0xfffff0ff
L_8d4ac4:
	mov_s r13,0x88ae00
L_8d4aca:
	mov_s r15,0x88ae80
L_8d4ad0:
	mov_s r17,r0
L_8d4ad2:
	breq r16,0x0,L_8d4b08
L_8d4ad6:
	ld_s r1,[r14,0x40]
L_8d4ad8:
	and_s r0,r0,r1
L_8d4ada:
	bclr_s r0,r0,0x0
L_8d4adc:
	bset_s r0,r0,0xa
L_8d4ade:
	bset_s r0,r0,0xb
L_8d4ae0:
	bclr_s r0,r0,0x4
L_8d4ae2:
	st_s r0,[r14,0x40]
L_8d4ae4:
	mov_s r0,0x2
L_8d4ae6:
	mov_s r1,0x1
L_8d4ae8:
	bl.d L_8cbb20
L_8d4aec:
	mov_s r2,0x0
L_8d4aee:
	ld_s r0,[r13,0x6c]
L_8d4af0:
	bset_s r0,r0,0xb
L_8d4af2:
	bset_s r0,r0,0xc
L_8d4af4:
	bset_s r0,r0,0xd
L_8d4af6:
	st_s r0,[r13,0x6c]
L_8d4af8:
	ld_s r0,[r15,0x30]
L_8d4afa:
	or r0,r0,0x180
L_8d4afe:
	st_s r0,[r15,0x30]
L_8d4b00:
	bl.d L_8cb8d8
L_8d4b04:
	mov_s r0,0x1
L_8d4b06:
	b_s L_8d4b36
	.global L_8d4b08
L_8d4b08:
	bl.d L_8cb8d8
L_8d4b0c:
	mov_s r0,0x0
L_8d4b0e:
	ld_s r0,[r14,0x40]
L_8d4b10:
	mov_s r1,0x2
L_8d4b12:
	and r0,r0,r17
L_8d4b16:
	or r0,r0,0x11
L_8d4b1a:
	st_s r0,[r14,0x40]
L_8d4b1c:
	mov_s r0,0x3
L_8d4b1e:
	bl.d L_8cbb20
L_8d4b22:
	mov_s r2,0x0
L_8d4b24:
	ld_s r0,[r13,0x6c]
L_8d4b26:
	bclr_s r0,r0,0xb
L_8d4b28:
	bclr_s r0,r0,0xc
L_8d4b2a:
	bclr_s r0,r0,0xd
L_8d4b2c:
	st_s r0,[r13,0x6c]
L_8d4b2e:
	ld_s r0,[r15,0x30]
L_8d4b30:
	bic r0,r0,0x180
L_8d4b34:
	st_s r0,[r15,0x30]
	.global L_8d4b36
L_8d4b36:
	b L_8c031c
L_8d4b3a:
	nop_s
