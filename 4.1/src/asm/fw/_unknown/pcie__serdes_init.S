/* pcie__serdes_init @ 0x8eeac0, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sparrow wPCIeR support for backward compatibility with Marlon
 *   Sparrow PCIe PM Support!
 *   Sparrow PCIe reset Serdes1!
 *   Clock gate PCIE uneeded clocks!
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, g_80008c__clear_if_8825c0_bit1, pcie__force_clear_l0s, pcie__l1_sub_timing_setup, pcie__pm_host_config, pcie__program_880a80_seq, pcie__serdes_cfg, pcie__serdes_clk_gate, pcie__serdes_program_all, rgf_reg_882600
 */
	.section .text.pcie__serdes_init,"ax",@progbits
	.global pcie__serdes_init
pcie__serdes_init:
	.global L_8eeac0
L_8eeac0:
	push_s blink
L_8eeac2:
	bl L_8c02c0
L_8eeac6:
	mov_s r14,0x882580
L_8eeacc:
	ld_s r15,[r14,0x40]
L_8eeace:
	mov_s r13,0x11
L_8eead0:
	asl_s r13,r13,0x13
L_8eead2:
	ld_s r0,[r13]
L_8eead4:
	cmp_s r0,0x632072f
L_8eeada:
	cmp.ne r0,0x1632072f
L_8eeae2:
	bl.eq L_8eec58
L_8eeae6:
	mov_s r0,0x1
L_8eeae8:
	st.as r0,[r13,0x81]
L_8eeaec:
	ld_s r0,[gp,-0x160]
L_8eeaee:
	brne r0,0x1,L_8eeb12
L_8eeaf2:
	mov_s r2,0x10034c4
L_8eeaf8:
	mov_s r0,0xf
L_8eeafa:
	bl.d L_8edfb0
L_8eeafe:
	mov_s r1,0x2
L_8eeb00:
	ld_s r0,[r14,0x40]
L_8eeb02:
	and r0,r0,0xf801ffff
L_8eeb0a:
	bset_s r0,r0,0x11
L_8eeb0c:
	bset_s r0,r0,0x12
L_8eeb0e:
	bset_s r0,r0,0x17
L_8eeb10:
	st_s r0,[r14,0x40]
	.global L_8eeb12
L_8eeb12:
	mov_s r13,0x882000
L_8eeb18:
	st 0x7fff,[r13, 0xc]
L_8eeb20:
	ld_s r0,[r13,0x28]
L_8eeb22:
	mov_s r2,0x1003504
L_8eeb28:
	bclr_s r0,r0,0x15
L_8eeb2a:
	bclr_s r0,r0,0x5
L_8eeb2c:
	bclr_s r0,r0,0x6
L_8eeb2e:
	bset_s r0,r0,0x5
L_8eeb30:
	bset_s r0,r0,0x6
L_8eeb32:
	bset_s r0,r0,0x15
L_8eeb34:
	st_s r0,[r13,0x28]
L_8eeb36:
	mov_s r0,0xf
L_8eeb38:
	bl.d L_8edfb0
L_8eeb3c:
	mov_s r1,0x2
L_8eeb3e:
	bl L_8ce7d8
L_8eeb42:
	bl L_8cea38
L_8eeb46:
	bl L_8dc264
L_8eeb4a:
	bbit1 r15,0x0,L_8eeb62
L_8eeb4e:
	mov_s r2,0x1003520
L_8eeb54:
	mov_s r0,0xf
L_8eeb56:
	bl.d L_8edfb0
L_8eeb5a:
	mov_s r1,0x2
L_8eeb5c:
	bl.d L_8ced44
L_8eeb60:
	mov_s r0,0x1
	.global L_8eeb62
L_8eeb62:
	mov_s r2,0x100353c
L_8eeb68:
	mov_s r0,0xf
L_8eeb6a:
	bl.d L_8edfb0
L_8eeb6e:
	mov_s r1,0x2
L_8eeb70:
	bl.d L_8ce3d0
L_8eeb74:
	mov_s r0,0x1
L_8eeb76:
	mov_s r0,0xd
L_8eeb78:
	bl.d L_8efd50
L_8eeb7c:
	mov_s r1,0x0
L_8eeb7e:
	mov_s r0,0xe
L_8eeb80:
	bl.d L_8efd50
L_8eeb84:
	mov_s r1,0x0
L_8eeb86:
	mov_s r14,0xa
L_8eeb88:
	mov_s r0,r14
L_8eeb8a:
	bl.d L_8efd50
L_8eeb8e:
	mov_s r1,0x1
L_8eeb90:
	ld_s r2,[r13,0x40]
L_8eeb92:
	mov_s r0,0xffff80ff
L_8eeb98:
	and_s r2,r2,r0
L_8eeb9a:
	mov_s r1,0x25
L_8eeb9c:
	asl_s r1,r1,0x8
L_8eeb9e:
	or_s r2,r2,r1
L_8eeba0:
	st_s r2,[r13,0x40]
L_8eeba2:
	ld_s r2,[r13,0x48]
L_8eeba4:
	and_s r2,r2,r0
L_8eeba6:
	or_s r2,r2,r1
L_8eeba8:
	st_s r2,[r13,0x48]
L_8eebaa:
	ld_s r2,[r13,0x50]
L_8eebac:
	and_s r2,r2,r0
L_8eebae:
	or_s r2,r2,r1
L_8eebb0:
	st_s r2,[r13,0x50]
L_8eebb2:
	mov_s r2,0x882200
L_8eebb8:
	ld_s r3,[r2,0x58]
L_8eebba:
	and_s r3,r3,r0
L_8eebbc:
	or_s r3,r3,r1
L_8eebbe:
	st_s r3,[r2,0x58]
L_8eebc0:
	ld_s r3,[r2,0x60]
L_8eebc2:
	and_s r3,r3,r0
L_8eebc4:
	or_s r3,r3,r1
L_8eebc6:
	st_s r3,[r2,0x60]
L_8eebc8:
	mov_s r3,0x882380
L_8eebce:
	ld_s r15,[r3,0x60]
L_8eebd0:
	and_s r15,r15,r0
L_8eebd2:
	or_s r15,r15,r1
L_8eebd4:
	st_s r15,[r3,0x60]
L_8eebd6:
	ld_s r15,[r3,0x68]
L_8eebd8:
	and_s r0,r0,r15
L_8eebda:
	or_s r1,r1,r0
L_8eebdc:
	st_s r1,[r3,0x68]
L_8eebde:
	mov_s r0,0x882b80
L_8eebe4:
	ld_s r1,[r0,0x14]
L_8eebe6:
	st_s r14,[r0,0x14]
L_8eebe8:
	ld_s r1,[r0,0x20]
L_8eebea:
	st_s r14,[r0,0x20]
L_8eebec:
	ld_s r1,[r0,0x2c]
L_8eebee:
	st_s r14,[r0,0x2c]
L_8eebf0:
	ld_s r1,[r0,0x38]
L_8eebf2:
	st_s r14,[r0,0x38]
L_8eebf4:
	ld_s r1,[r0,0x10]
L_8eebf6:
	st_s r14,[r0,0x10]
L_8eebf8:
	ld_s r1,[r0,0x1c]
L_8eebfa:
	st_s r14,[r0,0x1c]
L_8eebfc:
	ld_s r1,[r0,0x28]
L_8eebfe:
	st_s r14,[r0,0x28]
L_8eec00:
	ld_s r1,[r0,0x34]
L_8eec02:
	st_s r14,[r0,0x34]
L_8eec04:
	ld_s r0,[r13,0x24]
L_8eec06:
	bset_s r0,r0,0x6
L_8eec08:
	st_s r0,[r13,0x24]
L_8eec0a:
	ld_s r0,[r2,0x3c]
L_8eec0c:
	bset_s r0,r0,0x6
L_8eec0e:
	st_s r0,[r2,0x3c]
L_8eec10:
	ld_s r0,[r3,0x44]
L_8eec12:
	bset_s r0,r0,0x6
L_8eec14:
	st_s r0,[r3,0x44]
L_8eec16:
	ld_s r0,[r2,0x4c]
L_8eec18:
	or r0,r0,0x300
L_8eec1c:
	st_s r0,[r2,0x4c]
L_8eec1e:
	ld_s r0,[r3,0x54]
L_8eec20:
	or r0,r0,0x300
L_8eec24:
	st_s r0,[r3,0x54]
L_8eec26:
	mov_s r0,0xb
L_8eec28:
	bl.d L_8efd50
L_8eec2c:
	mov_s r1,0x0
L_8eec2e:
	bl L_8ec05c
L_8eec32:
	bl L_8ebc90
L_8eec36:
	b L_8c032c
L_8eec3a:
	nop_s
