/* UT_HW_MODES_cmd_handler @ 0x8fada4, 400 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_MODES_cmd_handler ut_subtype_id=0x%x
 * Зовут его: wmi_ut_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, abif__mode_switch, fw_log_emit1, hw__is_fpga_platform, hw__pll_mode_switch, hw_modes__apply_power_mode, hw_modes__enable_pll, hw_modes__pll_bypass, hw_modes__pll_engage, hw_modes__program_rf_clocks, hwd_phy__power_up_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global UT_HW_MODES_cmd_handler
UT_HW_MODES_cmd_handler:
	.global L_8fada4
L_8fada4:
	push_s blink
L_8fada6:
	bl L_8c01e0
L_8fadaa:
	mov_s r15,r0
L_8fadac:
	mov_s r14,r1
L_8fadae:
	mov_s r1,0xb
L_8fadb0:
	bl.d L_8eae60
L_8fadb4:
	ldw_s r2,[r14,0x2]
L_8fadb6:
	mov_s r13,r0
L_8fadb8:
	mov_s r1,0x101d454
L_8fadbe:
	mov_s r0,0x20
L_8fadc0:
	bl.d L_8dcc10
L_8fadc4:
	ldw_s r2,[r14,0x2]
L_8fadc6:
	bl L_8da2c8
L_8fadca:
	ldw_s r2,[r14,0x2]
L_8fadcc:
	breq_s r0,0,L_8fae00
L_8fadce:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_8fadd0:
	st_s r2,[r13,0x4]
L_8fadd2:
	ld_s r0,[r14,0x4]
L_8fadd4:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fadd6:
	st_s r0,[r13,0x8]
L_8fadd8:
	ld_s r0,[r14,0x8]
L_8fadda:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8faddc:
	st_s r0,[r13,0xc]
L_8fadde:
	ld_s r0,[r14,0xc]
L_8fade0:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fade2:
	st_s r0,[r13,0x10]
L_8fade4:
	ld_s r0,[r14,0x10]
L_8fade6:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fade8:
	st_s r0,[r13,0x14]
L_8fadea:
	ld_s r0,[r14,0x14]
L_8fadec:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fadee:
	st_s r0,[r13,0x18]
L_8fadf0:
	ld_s r0,[r14,0x18]
L_8fadf2:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fadf4:
	st_s r0,[r13,0x1c]
L_8fadf6:
	ld_s r0,[r14,0x1c]
L_8fadf8:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8fadfa:
	st_s r0,[r13,0x20]
L_8fadfc:
	mov_s r2,0x24
L_8fadfe:
	b_s L_8faf1a
	.global L_8fae00
L_8fae00:
	cmp r2,0x303
L_8fae04:
	beq_s L_8faea4
L_8fae06:
	bgt L_8fae5c
L_8fae0a:
	cmp r2,0x104
L_8fae0e:
	beq_s L_8fae88
L_8fae10:
	bgt_s L_8fae2c
L_8fae12:
	cmp r2,0x101
L_8fae16:
	beq_s L_8fae78
L_8fae18:
	cmp r2,0x102
L_8fae1c:
	beq_s L_8fae80
L_8fae1e:
	cmp r2,0x103
L_8fae22:
	bne_s L_8faf24
L_8fae24:
	bl L_8d7748
L_8fae28:
	mov_s r0,0x1
L_8fae2a:
	b_s L_8faf16
	.global L_8fae2c
L_8fae2c:
	cmp r2,0x206
L_8fae30:
	beq_s L_8fae90
L_8fae32:
	bgt_s L_8fae46
L_8fae34:
	cmp r2,0x200
L_8fae38:
	bne_s L_8faf24
L_8fae3a:
	ld_s r0,[r14,0x4]
L_8fae3c:
	bl.d L_8d73ec
L_8fae40:
	/* _sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8fae42:
	mov_s r0,0x1
L_8fae44:
	b_s L_8faf16
	.global L_8fae46
L_8fae46:
	cmp r2,0x301
L_8fae4a:
	beq_s L_8fae9a
L_8fae4c:
	cmp r2,0x302
L_8fae50:
	bne_s L_8faf24
L_8fae52:
	bl.d L_8d7c3c
L_8fae56:
	ld_s r0,[r14,0x4]
L_8fae58:
	mov_s r0,0x1
L_8fae5a:
	b_s L_8faf16
	.global L_8fae5c
L_8fae5c:
	mov_s r3,r2
L_8fae5e:
	sub r3,r3,0x304
L_8fae62:
	brhs r3,0x9,L_8faf24
L_8fae66:
	ldb.x r3,[0x803824,r3]
L_8fae6e:
	add r1,pcl,0xc
L_8fae72:
	add1_s r1,r1,r3
L_8fae74:
	j_s.d [r1]
L_8fae76:
	ld_s r0,[r14,0x4]
	.global L_8fae78
L_8fae78:
	bl L_8d7760
L_8fae7c:
	mov_s r0,0x1
L_8fae7e:
	b_s L_8faf16
	.global L_8fae80
L_8fae80:
	bl L_8d772c
L_8fae84:
	mov_s r0,0x1
L_8fae86:
	b_s L_8faf16
	.global L_8fae88
L_8fae88:
	bl L_8d7714
L_8fae8c:
	mov_s r0,0x1
L_8fae8e:
	b_s L_8faf16
	.global L_8fae90
L_8fae90:
	bl.d L_8d7500
L_8fae94:
	ldb_s r0,[r14,0x4]
L_8fae96:
	mov_s r0,0x1
L_8fae98:
	b_s L_8faf16
	.global L_8fae9a
L_8fae9a:
	bl.d L_8d7bd0
L_8fae9e:
	ld_s r0,[r14,0x4]
L_8faea0:
	mov_s r0,0x1
L_8faea2:
	b_s L_8faf16
	.global L_8faea4
L_8faea4:
	ld_s r0,[r14,0x4]
L_8faea6:
	bl.d L_8d7c84
L_8faeaa:
	mov_s r1,0x0
L_8faeac:
	mov_s r0,0x1
L_8faeae:
	b_s L_8faf16
L_8faeb0:
	bl.d L_8d7c04
L_8faeb4:
	mov_s r1,0x0
L_8faeb6:
	mov_s r0,0x1
L_8faeb8:
	b_s L_8faf16
L_8faeba:
	mov_s r1,0x8019b4
L_8faec0:
	bl L_8d7ac0
L_8faec4:
	mov_s r0,0x1
L_8faec6:
	b_s L_8faf16
L_8faec8:
	mov_s r1,0x8019b8
L_8faece:
	bl L_8d7818
L_8faed2:
	mov_s r0,0x1
L_8faed4:
	b_s L_8faf16
L_8faed6:
	bl L_8d7b84
L_8faeda:
	mov_s r0,0x1
L_8faedc:
	b_s L_8faf16
L_8faede:
	mov_s r1,0x8019b0
L_8faee4:
	bl L_8d7864
L_8faee8:
	mov_s r0,0x1
L_8faeea:
	b_s L_8faf16
L_8faeec:
	mov_s r1,0x8019ac
L_8faef2:
	mov_s r2,0x0
L_8faef4:
	mov_s r3,0x0
L_8faef6:
	bl.d L_8d78cc
L_8faefa:
	mov_s r4,r3
L_8faefc:
	mov_s r0,0x1
L_8faefe:
	b_s L_8faf16
L_8faf00:
	bl L_8d7b2c
L_8faf04:
	mov_s r0,0x1
L_8faf06:
	b_s L_8faf16
L_8faf08:
	bl L_8d7cc4
L_8faf0c:
	mov_s r0,0x1
L_8faf0e:
	b_s L_8faf16
L_8faf10:
	bl L_8d7c70
L_8faf14:
	mov_s r0,0x1
	.global L_8faf16
L_8faf16:
	st_s r0,[r13,0x4]
L_8faf18:
	mov_s r2,0x8
	.global L_8faf1a
L_8faf1a:
	mov_s r0,r15
L_8faf1c:
	bl.d L_8eae78
L_8faf20:
	mov_s r1,r13
L_8faf22:
	b_s L_8faf30
	.global L_8faf24
L_8faf24:
	mov_s r0,r15
L_8faf26:
	mov_s r1,0x9
L_8faf28:
	asl_s r1,r1,0x8
L_8faf2a:
	bl.d L_8e5728
L_8faf2e:
	ldw_s r3,[r14]
	.global L_8faf30
L_8faf30:
	b L_8c024c
