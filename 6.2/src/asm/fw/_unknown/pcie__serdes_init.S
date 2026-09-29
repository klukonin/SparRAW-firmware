/* pcie__serdes_init @ 0x8f6e08, 372 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sparrow wPCIeR support for backward compatibility with Marlon
 *   Sparrow PCIe PM Support!
 *   Sparrow PCIe reset Serdes1!
 *   Clock gate PCIE uneeded clocks!
 * Зовут его: fw_main
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, hwd_pcie__port1_serdes_reset, pcie__force_clear_l0s, pcie__hp_ctrl_write_bit, pcie__program_seq_fw_8825c0__8d1114, pcie__serdes_clear_flag_if_bit1, pcie__serdes_program_all, pcie_pm_host_config, pcie_serdes__init_seq, pcie_serdes__shlicht_wa
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__serdes_init
pcie__serdes_init:
	.global L_8f6e08
L_8f6e08:
	push_s blink
L_8f6e0a:
	bl L_8c01e0
L_8f6e0e:
	mov_s r14,0x882580
L_8f6e14:
	ld_s r15,[r14,0x40]
L_8f6e16:
	mov_s r13,0x11
L_8f6e18:
	asl_s r13,r13,0x13
L_8f6e1a:
	ld_s r0,[r13]
L_8f6e1c:
	cmp_s r0,0x632072f
L_8f6e22:
	cmp.ne r0,0x1632072f
L_8f6e2a:
	bl.eq L_8f6f7c
L_8f6e2e:
	mov_s r0,0x1
L_8f6e30:
	st.as r0,[r13,0x81]
L_8f6e34:
	ld_s r0,[gp,-0x17c]
L_8f6e36:
	brne r0,0x1,L_8f6e58
L_8f6e3a:
	mov_s r1,0x1003100
L_8f6e40:
	bl.d L_8dcba8
L_8f6e44:
	mov_s r0,0x2f
L_8f6e46:
	ld_s r0,[r14,0x40]
L_8f6e48:
	and r0,r0,0xf801ffff
L_8f6e50:
	bset_s r0,r0,0x11
L_8f6e52:
	bset_s r0,r0,0x12
L_8f6e54:
	bset_s r0,r0,0x17
L_8f6e56:
	st_s r0,[r14,0x40]
	.global L_8f6e58
L_8f6e58:
	mov_s r13,0x882000
L_8f6e5e:
	st 0x7fff,[r13, 0xc]
L_8f6e66:
	ld_s r0,[r13,0x28]
L_8f6e68:
	mov_s r1,0x1003140
L_8f6e6e:
	bclr_s r0,r0,0x15
L_8f6e70:
	bclr_s r0,r0,0x5
L_8f6e72:
	bclr_s r0,r0,0x6
L_8f6e74:
	bset_s r0,r0,0x5
L_8f6e76:
	bset_s r0,r0,0x6
L_8f6e78:
	bset_s r0,r0,0x15
L_8f6e7a:
	st_s r0,[r13,0x28]
L_8f6e7c:
	bl.d L_8dcba8
L_8f6e80:
	mov_s r0,0x2f
L_8f6e82:
	bl L_8d14d4
L_8f6e86:
	bl L_8d1720
L_8f6e8a:
	bl L_8e033c
L_8f6e8e:
	bbit1 r15,0x0,L_8f6ea4
L_8f6e92:
	mov_s r1,0x100315c
L_8f6e98:
	bl.d L_8dcba8
L_8f6e9c:
	mov_s r0,0x2f
L_8f6e9e:
	bl.d L_8d1a00
L_8f6ea2:
	mov_s r0,0x1
	.global L_8f6ea4
L_8f6ea4:
	mov_s r1,0x1003178
L_8f6eaa:
	bl.d L_8dcba8
L_8f6eae:
	mov_s r0,0x2f
L_8f6eb0:
	bl.d L_8d1114
L_8f6eb4:
	mov_s r0,0x1
L_8f6eb6:
	mov_s r0,0xd
L_8f6eb8:
	bl.d L_8f8094
L_8f6ebc:
	mov_s r1,0x0
L_8f6ebe:
	mov_s r0,0xe
L_8f6ec0:
	bl.d L_8f8094
L_8f6ec4:
	mov_s r1,0x0
L_8f6ec6:
	mov_s r14,0xa
L_8f6ec8:
	mov_s r0,r14
L_8f6eca:
	bl.d L_8f8094
L_8f6ece:
	mov_s r1,0x1
L_8f6ed0:
	ld_s r2,[r13,0x40]
L_8f6ed2:
	mov_s r0,0xffff80ff
L_8f6ed8:
	and_s r2,r2,r0
L_8f6eda:
	mov_s r1,0x25
L_8f6edc:
	asl_s r1,r1,0x8
L_8f6ede:
	or_s r2,r2,r1
L_8f6ee0:
	st_s r2,[r13,0x40]
L_8f6ee2:
	ld_s r2,[r13,0x48]
L_8f6ee4:
	and_s r2,r2,r0
L_8f6ee6:
	or_s r2,r2,r1
L_8f6ee8:
	st_s r2,[r13,0x48]
L_8f6eea:
	ld_s r2,[r13,0x50]
L_8f6eec:
	and_s r2,r2,r0
L_8f6eee:
	or_s r2,r2,r1
L_8f6ef0:
	st_s r2,[r13,0x50]
L_8f6ef2:
	mov_s r2,0x882200
L_8f6ef8:
	ld_s r3,[r2,0x58]
L_8f6efa:
	and_s r3,r3,r0
L_8f6efc:
	or_s r3,r3,r1
L_8f6efe:
	st_s r3,[r2,0x58]
L_8f6f00:
	ld_s r3,[r2,0x60]
L_8f6f02:
	and_s r3,r3,r0
L_8f6f04:
	or_s r3,r3,r1
L_8f6f06:
	st_s r3,[r2,0x60]
L_8f6f08:
	mov_s r3,0x882380
L_8f6f0e:
	ld_s r15,[r3,0x60]
L_8f6f10:
	and_s r15,r15,r0
L_8f6f12:
	or_s r15,r15,r1
L_8f6f14:
	st_s r15,[r3,0x60]
L_8f6f16:
	ld_s r15,[r3,0x68]
L_8f6f18:
	and_s r0,r0,r15
L_8f6f1a:
	or_s r1,r1,r0
L_8f6f1c:
	st_s r1,[r3,0x68]
L_8f6f1e:
	mov_s r0,0x882b80
L_8f6f24:
	ld_s r1,[r0,0x14]
L_8f6f26:
	st_s r14,[r0,0x14]
L_8f6f28:
	ld_s r1,[r0,0x20]
L_8f6f2a:
	st_s r14,[r0,0x20]
L_8f6f2c:
	ld_s r1,[r0,0x2c]
L_8f6f2e:
	st_s r14,[r0,0x2c]
L_8f6f30:
	ld_s r1,[r0,0x38]
L_8f6f32:
	st_s r14,[r0,0x38]
L_8f6f34:
	ld_s r1,[r0,0x10]
L_8f6f36:
	st_s r14,[r0,0x10]
L_8f6f38:
	ld_s r1,[r0,0x1c]
L_8f6f3a:
	st_s r14,[r0,0x1c]
L_8f6f3c:
	ld_s r1,[r0,0x28]
L_8f6f3e:
	st_s r14,[r0,0x28]
L_8f6f40:
	ld_s r1,[r0,0x34]
L_8f6f42:
	st_s r14,[r0,0x34]
L_8f6f44:
	ld_s r0,[r13,0x24]
L_8f6f46:
	bset_s r0,r0,0x6
L_8f6f48:
	st_s r0,[r13,0x24]
L_8f6f4a:
	ld_s r0,[r2,0x3c]
L_8f6f4c:
	bset_s r0,r0,0x6
L_8f6f4e:
	st_s r0,[r2,0x3c]
L_8f6f50:
	ld_s r0,[r3,0x44]
L_8f6f52:
	bset_s r0,r0,0x6
L_8f6f54:
	st_s r0,[r3,0x44]
L_8f6f56:
	ld_s r0,[r2,0x4c]
L_8f6f58:
	or r0,r0,0x300
L_8f6f5c:
	st_s r0,[r2,0x4c]
L_8f6f5e:
	ld_s r0,[r3,0x54]
L_8f6f60:
	or r0,r0,0x300
L_8f6f64:
	st_s r0,[r3,0x54]
L_8f6f66:
	mov_s r0,0xb
L_8f6f68:
	bl.d L_8f8094
L_8f6f6c:
	mov_s r1,0x0
L_8f6f6e:
	bl L_8f3d6c
L_8f6f72:
	bl L_8f344c
L_8f6f76:
	b L_8c024c
L_8f6f7a:
	nop_s
