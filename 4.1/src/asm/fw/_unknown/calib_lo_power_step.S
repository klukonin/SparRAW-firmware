/* calib_lo_power_step @ 0x8d2f38, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_if_gain__vt18, hwf_calib_all
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, calib_lo_power_measure, calib_lo_power_substep, hwd_abif__rgf_88a200_8cc674, hwd_abif__rgf_88af80_8cb8d8, hwd_mac__rgf_886200, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cf52c, hwd_phy__rgf_883000_8cf74c, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48
 * Глобалы (через gp): 0x800208, 0x800209
 */
	.section .text.calib_lo_power_step,"ax",@progbits
	.global calib_lo_power_step
calib_lo_power_step:
	.global L_8d2f38
L_8d2f38:
	push_s blink
L_8d2f3a:
	bl L_8c02c0
L_8d2f3e:
	bl.d L_8d3870
L_8d2f42:
	sub_s sp,sp,0x8
L_8d2f44:
	bl.d L_8cf4c8
L_8d2f48:
	mov_s r0,0x0
L_8d2f4a:
	bl.d L_8cf4fc
L_8d2f4e:
	mov_s r0,0x0
L_8d2f50:
	bl.d L_8cb8d8
L_8d2f54:
	mov_s r0,0x0
L_8d2f56:
	bl.d L_8d4c0c
L_8d2f5a:
	mov_s r0,0x0
L_8d2f5c:
	bl L_8cfcdc
L_8d2f60:
	bl.d L_8d04b0
L_8d2f64:
	mov_s r0,0x0
L_8d2f66:
	bl.d L_8d4c0c
L_8d2f6a:
	mov_s r0,0x1
L_8d2f6c:
	bl L_8cfd48
L_8d2f70:
	ldb_s r0,[gp,0x98]
L_8d2f72:
	mov_s r14,0x8004d8
L_8d2f78:
	mov_s r13,0x842720
L_8d2f7e:
	ldb_s r15,[r14]
L_8d2f80:
	brne r0,0x1,L_8d2fc8
L_8d2f84:
	mov_s r0,r14
L_8d2f86:
	mov_s r1,r15
L_8d2f88:
	bl.d L_8d24e4
L_8d2f8c:
	mov_s r2,0x0
L_8d2f8e:
	ldb_s r1,[r14]
L_8d2f90:
	mov_s r0,0x806764
L_8d2f96:
	sub r2,r1,r15
L_8d2f9a:
	stb_s r2,[r0]
L_8d2f9c:
	ldb_s r0,[gp,0x99]
L_8d2f9e:
	mov_s r3,sp
L_8d2fa0:
	sub_s r1,r1,r0
L_8d2fa2:
	extb_s r1,r1
L_8d2fa4:
	sexb_s r2,r0
L_8d2fa6:
	bl.d L_8d24e4
L_8d2faa:
	mov_s r0,r3
L_8d2fac:
	ldb_s r0,[sp,0x0]
L_8d2fae:
	ld_s r1,[sp,0x4]
L_8d2fb0:
	stb_s r0,[r13,0x6]
L_8d2fb2:
	mov_s r0,0x0
L_8d2fb4:
	brlt.d r1,0x0,L_8d2fc0
L_8d2fb8:
	bset_s r0,r0,0xf
L_8d2fba:
	add_s r0,r0,r1
L_8d2fbc:
	asr_s r0,r0,0x10
L_8d2fbe:
	b_s L_8d301e
	.global L_8d2fc0
L_8d2fc0:
	sub_s r0,r0,r1
L_8d2fc2:
	asr_s r0,r0,0x10
L_8d2fc4:
	neg_s r0,r0
L_8d2fc6:
	b_s L_8d301e
	.global L_8d2fc8
L_8d2fc8:
	brne_s r0,0,L_8d2fee
L_8d2fca:
	ldb r1,[gp, 0x99]
L_8d2fce:
	ld_s r2,[r14,0x4]
L_8d2fd0:
	sub_s r15,r15,r1
L_8d2fd2:
	stb_s r15,[r13,0x6]
L_8d2fd4:
	mov_s r0,0x0
L_8d2fd6:
	brlt.d r2,0x0,L_8d2fe2
L_8d2fda:
	bset_s r0,r0,0xf
L_8d2fdc:
	add_s r0,r0,r2
L_8d2fde:
	asr_s r0,r0,0x10
L_8d2fe0:
	b_s L_8d2fe8
	.global L_8d2fe2
L_8d2fe2:
	sub_s r0,r0,r2
L_8d2fe4:
	asr_s r0,r0,0x10
L_8d2fe6:
	neg_s r0,r0
	.global L_8d2fe8
L_8d2fe8:
	add_s r1,r1,r0
L_8d2fea:
	stb_s r1,[r13,0x7]
L_8d2fec:
	b_s L_8d3022
	.global L_8d2fee
L_8d2fee:
	brne r0,0x2,L_8d3022
L_8d2ff2:
	ldb_s r0,[gp,0x99]
L_8d2ff4:
	mov_s r2,sp
L_8d2ff6:
	sub_s r15,r15,r0
L_8d2ff8:
	extb_s r15,r15
L_8d2ffa:
	stb_s r15,[r13,0x6]
L_8d2ffc:
	mov_s r0,r15
L_8d2ffe:
	bl.d L_8d3f40
L_8d3002:
	ldb r1,[gp, 0x9a]
L_8d3006:
	mov_s r1,0x0
L_8d3008:
	ld_s r0,[sp,0x0]
L_8d300a:
	bset_s r1,r1,0xf
L_8d300c:
	cmp_s r0,0x0
L_8d300e:
	add.ge r0,r0,r1
L_8d3012:
	asr.ge r0,r0,0x10
L_8d3016:
	bge_s L_8d301e
L_8d3018:
	sub_s r1,r1,r0
L_8d301a:
	asr_s r1,r1,0x10
L_8d301c:
	neg_s r0,r1
	.global L_8d301e
L_8d301e:
	sexb_s r0,r0
L_8d3020:
	stb_s r0,[r13,0x7]
	.global L_8d3022
L_8d3022:
	bl L_8cfcdc
L_8d3026:
	mov_s r0,0x0
L_8d3028:
	bl.d L_8cc674
L_8d302c:
	mov_s r1,r0
L_8d302e:
	bl.d L_8d4c0c
L_8d3032:
	mov_s r0,0x0
L_8d3034:
	mov_s r0,0xb
L_8d3036:
	mov_s r1,r0
L_8d3038:
	bl.d L_8d0318
L_8d303c:
	mov_s r2,0x6
L_8d303e:
	bl.d L_8d037c
L_8d3042:
	mov_s r0,0x1
L_8d3044:
	mov_s r0,0x0
L_8d3046:
	bset_s r0,r0,0x10
L_8d3048:
	mov_s r1,0x1
L_8d304a:
	bl.d L_8cf74c
L_8d304e:
	mov_s r2,0xb
L_8d3050:
	bl L_8cfd88
L_8d3054:
	bl L_8cfd48
L_8d3058:
	bl.d L_8ceed4
L_8d305c:
	mov_s r0,0x1
L_8d305e:
	mov_s r0,0x1
L_8d3060:
	bl.d L_8cf52c
L_8d3064:
	ldb_s r1,[r13,0x6]
L_8d3066:
	bl.d L_8cf588
L_8d306a:
	mov_s r0,0x1
L_8d306c:
	bl.d L_8ce260
L_8d3070:
	mov_s r0,0x1
L_8d3072:
	mov_s r0,0x1
L_8d3074:
	mov_s r1,0x1d
L_8d3076:
	bl.d L_8d4bd4
L_8d307a:
	ldb_s r2,[r13,0x6]
L_8d307c:
	b.d L_8c032c
L_8d3080:
	add_s sp,sp,0x8
L_8d3082:
	nop_s
