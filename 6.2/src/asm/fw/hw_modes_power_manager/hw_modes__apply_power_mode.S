/* hw_modes__apply_power_mode @ 0x8d7ac0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, ut_hw_modes_cmd_0x308
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, hwd_dma__set_power_mode_map, hwd_mac__set_power_mode_map, hwd_pcie__set_mode_map, hwd_phy__uses_rgf_880c00_8d1d34, mac__set_880bf0_mode_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__apply_power_mode
hw_modes__apply_power_mode:
	.global L_8d7ac0
L_8d7ac0:
	push_s blink
L_8d7ac2:
	bl L_8c01e4
L_8d7ac6:
	mov_s r13,r0
L_8d7ac8:
	brhs.d r0,0x5,L_8d7ae0
L_8d7acc:
	mov_s r14,r1
L_8d7ace:
	ldb.x r10,[0x80381c,r13]
L_8d7ad6:
	add r0,pcl,0xc
L_8d7ada:
	add1 r0,r0,r10
L_8d7ade:
	j_s [r0]
	.global L_8d7ae0
L_8d7ae0:
	mov_s r0,blink
L_8d7ae2:
	mov_s r1,0x12dd
L_8d7ae8:
	bl L_8c9b28
L_8d7aec:
	ld_s r0,[r14]
L_8d7aee:
	btst_s r0,0x0
L_8d7af0:
	bl.ne.d L_8d0908
L_8d7af4:
	mov.ne r0,r13
L_8d7af8:
	ld_s r0,[r14]
L_8d7afa:
	btst_s r0,0x1
L_8d7afc:
	bl.ne.d L_8d18e8
L_8d7b00:
	mov.ne r0,r13
L_8d7b04:
	ld_s r0,[r14]
L_8d7b06:
	btst_s r0,0x2
L_8d7b08:
	bl.ne.d L_8d1d34
L_8d7b0c:
	mov.ne r0,r13
L_8d7b10:
	ld_s r0,[r14]
L_8d7b12:
	btst_s r0,0x3
L_8d7b14:
	bl.ne.d L_8d0f40
L_8d7b18:
	mov.ne r0,r13
L_8d7b1c:
	ld_s r0,[r14]
L_8d7b1e:
	btst_s r0,0x4
L_8d7b20:
	bl.ne.d L_8d0144
L_8d7b24:
	mov.ne r0,r13
L_8d7b28:
	b L_8c0254
