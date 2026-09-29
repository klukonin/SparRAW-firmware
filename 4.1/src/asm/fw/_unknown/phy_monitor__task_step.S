/* phy_monitor__task_step @ 0x8e3af0, 388 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [PHY_LOG] curr_tm %d | last_clear_tm %d | duration_from_last_clear_usec %d
 *   [PHY_LOG] tsf 0x%08x | INA_SYNC_COUNTER_CP %d | INA_SYNC_COUNTER_DP %d |
 *   [NNL] SFD_TIMEOUT_COUNTER_CP %d | SFD_TIMEOUT_COUNTER_DP %d |
 *   [NNL] HEADER_CRC_ERROR_COUNTER_CP %d | HEADER_CRC_ERROR_COUNTER_SC %d |
 *   [NNL] HEADER_CRC_OK_COUNTER_CP %d | HEADER_CRC_OK_COUNTER_SC %d |
 *   [NNL] SFD_SYNC_COUNTER_CP %d | HY_RX_STAT_SFD_SYNC_COUNTER_SC %d |
 *   [NNL] BER_LAST_ZERO_COUNTER_CP %d | BER_LAST_ZERO_COUNTER_SC %d |
 *   [NNL] BER_LAST_NON_ZERO_COUNTER_CP %d | BER_LAST_NON_ZERO_COUNTER_SC %d |
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, fw_log__emit3, fw_read_timer, get_g_8004f4, get_reg883830_s14_w32, hwd_phy__get_883700_8cf970, hwd_phy__get_883700_8cf97c, hwd_phy__get_883800, hwd_phy__set_883900, hwd_phy__snapshot_status
 */
	.section .text.phy_monitor__task_step,"ax",@progbits
	.global phy_monitor__task_step
phy_monitor__task_step:
L_8e3af0:
	push_s blink
L_8e3af2:
	bl L_8c02c0
L_8e3af6:
	sub_s sp,sp,0x40
L_8e3af8:
	bl.d L_8e4694
L_8e3afc:
	mov_s r14,r0
L_8e3afe:
	bl.d L_8cf8c0
L_8e3b02:
	mov_s r13,r0
L_8e3b04:
	mov_s r15,r0
L_8e3b06:
	ld_s r0,[r14,0x34]
L_8e3b08:
	cmp_s r0,0x0
L_8e3b0a:
	bl.ne L_8cfc9c
L_8e3b0e:
	bl.d L_8cf8e8
L_8e3b12:
	mov_s r0,sp
L_8e3b14:
	ld_s r0,[r14,0x34]
L_8e3b16:
	cmp_s r0,0x0
L_8e3b18:
	bl.ne L_8cfc80
L_8e3b1c:
	add_s r1,sp,0x38
L_8e3b1e:
	mov_s r0,0x0
L_8e3b20:
	bl.d L_8e4840
L_8e3b24:
	mov_s r2,r0
L_8e3b26:
	mov_s r2,0x101627c
L_8e3b2c:
	sub r14,r13,r15
L_8e3b30:
	asl r5,r14,0x4
L_8e3b34:
	mov_s r0,0x4
L_8e3b36:
	mov_s r1,0x2
L_8e3b38:
	mov_s r3,r13
L_8e3b3a:
	bl.d L_8ee034
L_8e3b3e:
	mov_s r4,r15
L_8e3b40:
	ld r4,[sp, 0x1c]
L_8e3b44:
	mov_s r2,0x10162c8
L_8e3b4a:
	ld r5,[sp]
L_8e3b4e:
	mov_s r0,0x4
L_8e3b50:
	mov_s r1,0x2
L_8e3b52:
	bl.d L_8ee034
L_8e3b56:
	ld_s r3,[sp,0x38]
L_8e3b58:
	mov_s r2,0x1016314
L_8e3b5e:
	ld r4,[sp, 0x8]
L_8e3b62:
	mov_s r0,0x4
L_8e3b64:
	mov_s r1,0x2
L_8e3b66:
	bl.d L_8edff8
L_8e3b6a:
	ld_s r3,[sp,0x24]
L_8e3b6c:
	mov_s r2,0x1016354
L_8e3b72:
	ld r4,[sp, 0x10]
L_8e3b76:
	mov_s r0,0x4
L_8e3b78:
	mov_s r1,0x2
L_8e3b7a:
	bl.d L_8edff8
L_8e3b7e:
	ld_s r3,[sp,0x2c]
L_8e3b80:
	mov_s r2,0x101639c
L_8e3b86:
	ld r4,[sp, 0xc]
L_8e3b8a:
	mov_s r0,0x4
L_8e3b8c:
	mov_s r1,0x2
L_8e3b8e:
	bl.d L_8edff8
L_8e3b92:
	ld_s r3,[sp,0x28]
L_8e3b94:
	mov_s r2,0x10163e0
L_8e3b9a:
	ld r4,[sp, 0x4]
L_8e3b9e:
	mov_s r0,0x4
L_8e3ba0:
	mov_s r1,0x2
L_8e3ba2:
	bl.d L_8edff8
L_8e3ba6:
	ld_s r3,[sp,0x20]
L_8e3ba8:
	mov_s r2,0x1016424
L_8e3bae:
	ld r4,[sp, 0x14]
L_8e3bb2:
	mov_s r0,0x4
L_8e3bb4:
	mov_s r1,0x2
L_8e3bb6:
	bl.d L_8edff8
L_8e3bba:
	ld_s r3,[sp,0x30]
L_8e3bbc:
	mov_s r2,0x1016468
L_8e3bc2:
	ld r4,[sp, 0x18]
L_8e3bc6:
	mov_s r0,0x4
L_8e3bc8:
	mov_s r1,0x2
L_8e3bca:
	bl.d L_8edff8
L_8e3bce:
	ld_s r3,[sp,0x34]
L_8e3bd0:
	bl L_8cf8cc
L_8e3bd4:
	bl.d L_8cf8d8
L_8e3bd8:
	mov_s r15,r0
L_8e3bda:
	mov_s r4,r0
L_8e3bdc:
	mov_s r2,0x10164b4
L_8e3be2:
	mov_s r0,0x4
L_8e3be4:
	mov_s r1,0x2
L_8e3be6:
	bl.d L_8edff8
L_8e3bea:
	mov_s r3,r15
L_8e3bec:
	bl L_8cf970
L_8e3bf0:
	bl.d L_8cf97c
L_8e3bf4:
	mov_s r15,r0
L_8e3bf6:
	mov_s r4,r0
L_8e3bf8:
	mov_s r2,0x10164f8
L_8e3bfe:
	mov_s r0,0x4
L_8e3c00:
	mov_s r1,0x2
L_8e3c02:
	bl.d L_8edff8
L_8e3c06:
	mov_s r3,r15
L_8e3c08:
	mov_s r2,0x1016534
L_8e3c0e:
	mov_s r0,0x8004d8
L_8e3c14:
	ldb r4,[r0]
L_8e3c18:
	mov_s r0,0x4
L_8e3c1a:
	mov_s r1,0x2
L_8e3c1c:
	bl.d L_8edff8
L_8e3c20:
	ldb r3,[gp, 0xb9]
L_8e3c24:
	mov_s r2,0x101657c
L_8e3c2a:
	ldb r4,[gp, 0xc5]
L_8e3c2e:
	mov_s r0,0x4
L_8e3c30:
	mov_s r1,0x2
L_8e3c32:
	bl.d L_8edff8
L_8e3c36:
	ldb r3,[gp, 0xbb]
L_8e3c3a:
	mov_s r2,0x10165c4
L_8e3c40:
	mov_s r3,0x854d80
L_8e3c46:
	ld r4,[r3, 0x4]
L_8e3c4a:
	mov_s r0,0x4
L_8e3c4c:
	mov_s r1,0x2
L_8e3c4e:
	bl.d L_8edff8
L_8e3c52:
	ld_s r3,[r3,0x1c]
L_8e3c54:
	mov_s r2,0x1016604
L_8e3c5a:
	mov_s r3,0x854800
L_8e3c60:
	ld r4,[r3, 0x8]
L_8e3c64:
	mov_s r0,0x4
L_8e3c66:
	mov_s r1,0x2
L_8e3c68:
	bl.d L_8edff8
L_8e3c6c:
	ld_s r3,[r3,0xc]
L_8e3c6e:
	b.d L_8c032c
L_8e3c72:
	add_s sp,sp,0x40
