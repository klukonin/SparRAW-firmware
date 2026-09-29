/* WBE_DRIVER__pcie_boot_init @ 0x8e8a1c, 928 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   MAIN() BOOT STARTS
 *   MAIN() set MAC_SXD_ERRORS_ISR interrupt to level 1
 *   MAIN() Running Full FW
 *   MAIN() FW Boot occur before HW Boot ended
 *   main.c
 *   MAIN() HW statemachine WA
 *   MAIN() RUNNING IN FPGA MODE !!!!!!
 *   BUG_5382_WA - hwd_pcie_perst_deassert_int_clear()
 * Зовут его: fw_boot__clear_bss
 * Зовёт сам: POWER_MNGR__init, __ld_r14_to_r13_ret, __st_r14_to_r13, arc_action_point__install_default, baseband__identify, boot__init_subsystems, boot__install_diag_magic, boot__publish_ids, boot__read_strap_bit, boot_fill_addr_tables, calib_mngr__init_schemes, cnt_handler__clear_all
 * Глобалы (через gp): 0x8002c4, 0x800354, 0x800414
 */
	.section .text.WBE_DRIVER__pcie_boot_init,"ax",@progbits
	.global WBE_DRIVER__pcie_boot_init
WBE_DRIVER__pcie_boot_init:
	.global L_8e8a1c
L_8e8a1c:
	push_s blink
L_8e8a1e:
	bl L_8c02c4
L_8e8a22:
	mov_s r0,0x8033dc
L_8e8a28:
	bl L_8ed000
L_8e8a2c:
	mov lp_count,0xd
L_8e8a30:
	mov_s r1,0x0
L_8e8a32:
	lp L_8e8a4a
L_8e8a36:
	mov_s r0,0x8030b0
L_8e8a3c:
	ldb_s r2,[r0,r1]
L_8e8a3e:
	mov_s r0,0x8891b4
L_8e8a44:
	add2_s r0,r0,r1
L_8e8a46:
	st_s r2,[r0]
L_8e8a48:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e8a4a
L_8e8a4a:
	mov r1,-0x3
L_8e8a4e:
	mov_s r0,0x857280
L_8e8a54:
	st_s r1,[r0,0x14]
L_8e8a56:
	mov_s r13,0x0
L_8e8a58:
	mov_s r1,0x880a3c
L_8e8a5e:
	ld_s r0,[r1,0x28]
L_8e8a60:
	st_s r13,[r1,0x40]
L_8e8a62:
	bclr_s r0,r0,0x0
L_8e8a64:
	st_s r0,[r1,0x28]
L_8e8a66:
	ld_s r0,[r1,0x58]
L_8e8a68:
	st_s r13,[r1,0x3c]
L_8e8a6a:
	bclr_s r0,r0,0x0
L_8e8a6c:
	bl.d L_8d5d84
L_8e8a70:
	st_s r0,[r1,0x58]
L_8e8a72:
	bl L_8ed218
L_8e8a76:
	bl L_8edf58
L_8e8a7a:
	mov_s r2,0x10007a0
L_8e8a80:
	mov_s r0,r13
L_8e8a82:
	bl.d L_8edfb0
L_8e8a86:
	mov_s r1,0x2
L_8e8a88:
	mov_s r0,0x6
L_8e8a8a:
	bl.d L_8c31f8
L_8e8a8e:
	mov_s r1,r13
L_8e8a90:
	mov_s r2,0x10007b4
L_8e8a96:
	mov_s r0,r13
L_8e8a98:
	bl.d L_8edfb0
L_8e8a9c:
	mov_s r1,0x2
L_8e8a9e:
	bl L_8f1964
L_8e8aa2:
	bl L_8f1a00
L_8e8aa6:
	mov_s r2,0x10007e8
L_8e8aac:
	mov_s r0,r13
L_8e8aae:
	bl.d L_8edfb0
L_8e8ab2:
	mov_s r1,0x2
L_8e8ab4:
	ld_s r0,[gp,0x154]
L_8e8ab6:
	brne r0,0x11111111,L_8e8ac8
L_8e8abe:
	st.as 0x22222222,[gp,0x55]
L_8e8ac6:
	b_s L_8e8aec
	.global L_8e8ac8
L_8e8ac8:
	mov_s r2,0x1000800
L_8e8ace:
	mov_s r0,r13
L_8e8ad0:
	bl.d L_8edfb0
L_8e8ad4:
	mov_s r1,0x2
L_8e8ad6:
	mov_s r0,blink
L_8e8ad8:
	mov_s r2,0x100082c
L_8e8ade:
	mov_s r1,0x11b1
L_8e8ae4:
	bl.d L_8c82c0
L_8e8ae8:
	mov r3,0x11b
	.global L_8e8aec
L_8e8aec:
	bl L_8ec3e4
L_8e8af0:
	bl L_8e5350
L_8e8af4:
	bl L_8ed434
L_8e8af8:
	bl L_8d6ea8
L_8e8afc:
	mov_s r2,0x1000834
L_8e8b02:
	mov_s r0,0x0
L_8e8b04:
	bl.d L_8edfb0
L_8e8b08:
	mov_s r1,0x2
	.global L_8e8b0a
L_8e8b0a:
	nop_s
L_8e8b0c:
	nop_s
L_8e8b0e:
	nop_s
L_8e8b10:
	nop_s
L_8e8b12:
	nop_s
L_8e8b14:
	nop_s
L_8e8b16:
	nop_s
L_8e8b18:
	nop_s
L_8e8b1a:
	nop_s
L_8e8b1c:
	nop_s
L_8e8b1e:
	nop_s
L_8e8b20:
	nop_s
L_8e8b22:
	nop_s
L_8e8b24:
	nop_s
L_8e8b26:
	nop_s
L_8e8b28:
	nop_s
L_8e8b2a:
	mov_s r0,0x11
L_8e8b2c:
	asl_s r0,r0,0x13
L_8e8b2e:
	ld.as r0,[r0,0x80]
L_8e8b32:
	bbit0 r0,0x6,L_8e8b0a
L_8e8b36:
	mov_s r1,0x880180
L_8e8b3c:
	st 0x80000000,[r1, 0x58]
L_8e8b44:
	ld_s r0,[r1,0x58]
L_8e8b46:
	bmsk_s r0,r0,0x4
L_8e8b48:
	brne r0,0x15,L_8e8b54
L_8e8b4c:
	st 0x40000000,[r1, 0x58]
	.global L_8e8b54
L_8e8b54:
	bl L_8d7210
L_8e8b58:
	breq_s r0,0,L_8e8b68
L_8e8b5a:
	mov_s r2,0x1000850
L_8e8b60:
	mov_s r0,0x0
L_8e8b62:
	bl.d L_8edfb0
L_8e8b66:
	mov_s r1,0x2
	.global L_8e8b68
L_8e8b68:
	bl L_8eb9ac
L_8e8b6c:
	bl L_8dfe54
L_8e8b70:
	bl L_8cedcc
L_8e8b74:
	bl L_8d7244
L_8e8b78:
	breq_s r0,0,L_8e8b8c
L_8e8b7a:
	mov_s r2,0x1000674
L_8e8b80:
	mov_s r0,0x0
L_8e8b82:
	bl.d L_8edfb0
L_8e8b86:
	mov_s r1,0x2
L_8e8b88:
	bl L_8cecb8
	.global L_8e8b8c
L_8e8b8c:
	mov_s r2,0x10006a8
L_8e8b92:
	mov_s r0,0x0
L_8e8b94:
	bl.d L_8edfb0
L_8e8b98:
	mov_s r1,0x2
L_8e8b9a:
	bl L_8cecc4
L_8e8b9e:
	ld_s r0,[gp,0x1e4]
L_8e8ba0:
	breq_s r0,0,L_8e8bb4
L_8e8ba2:
	mov_s r2,0x10006cc
L_8e8ba8:
	mov_s r0,0x0
L_8e8baa:
	bl.d L_8edfb0
L_8e8bae:
	mov_s r1,0x2
L_8e8bb0:
	bl L_8cecac
	.global L_8e8bb4
L_8e8bb4:
	mov_s r2,0x10006ec
L_8e8bba:
	mov_s r0,0x0
L_8e8bbc:
	bl.d L_8edfb0
L_8e8bc0:
	mov_s r1,0x2
L_8e8bc2:
	bl L_8ce4fc
L_8e8bc6:
	mov_s r2,0x1000708
L_8e8bcc:
	mov_s r0,0x0
L_8e8bce:
	bl.d L_8edfb0
L_8e8bd2:
	mov_s r1,0x2
L_8e8bd4:
	bl L_8ce464
L_8e8bd8:
	mov_s r2,0x1000720
L_8e8bde:
	mov_s r0,0x0
L_8e8be0:
	bl.d L_8edfb0
L_8e8be4:
	mov_s r1,0x2
L_8e8be6:
	mov_s r32,r13
L_8e8be8:
	mov_s r2,0x1000738
L_8e8bee:
	mov_s r0,0x0
L_8e8bf0:
	bl.d L_8edfb0
L_8e8bf4:
	mov_s r1,0x2
L_8e8bf6:
	bl L_8eeac0
L_8e8bfa:
	mov_s r2,0x1000874
L_8e8c00:
	mov_s r0,0x0
L_8e8c02:
	bl.d L_8edfb0
L_8e8c06:
	mov_s r1,0x2
L_8e8c08:
	bl L_8c0384
L_8e8c0c:
	mov_s r2,0x1000894
L_8e8c12:
	mov_s r0,0x0
L_8e8c14:
	bl.d L_8edfb0
L_8e8c18:
	mov_s r1,0x2
L_8e8c1a:
	bl L_8ee16c
L_8e8c1e:
	bl L_8d99e0
L_8e8c22:
	mov_s r2,0x10008b4
L_8e8c28:
	mov_s r0,0x0
L_8e8c2a:
	bl.d L_8edfb0
L_8e8c2e:
	mov_s r1,0x2
L_8e8c30:
	bl L_8ed4a0
L_8e8c34:
	bl L_8d7540
L_8e8c38:
	breq_s r0,0,L_8e8c4c
L_8e8c3a:
	mov_s r2,0x10008d0
L_8e8c40:
	mov_s r0,0x0
L_8e8c42:
	bl.d L_8edfb0
L_8e8c46:
	mov_s r1,0x2
L_8e8c48:
	bl L_8d4ca4
	.global L_8e8c4c
L_8e8c4c:
	mov_s r2,0x10008f4
L_8e8c52:
	mov_s r0,0x0
L_8e8c54:
	bl.d L_8edfb0
L_8e8c58:
	mov_s r1,0x2
L_8e8c5a:
	bl.d L_8d7724
L_8e8c5e:
	mov_s r0,0x3
L_8e8c60:
	bl.d L_8d775c
L_8e8c64:
	mov_s r0,0x0
L_8e8c66:
	bl L_8d7540
L_8e8c6a:
	breq_s r0,0,L_8e8c7e
L_8e8c6c:
	mov_s r2,0x100090c
L_8e8c72:
	mov_s r0,0x0
L_8e8c74:
	bl.d L_8edfb0
L_8e8c78:
	mov_s r1,0x2
L_8e8c7a:
	bl L_8ceff0
	.global L_8e8c7e
L_8e8c7e:
	bl L_8d7540
L_8e8c82:
	brne_s r0,0,L_8e8c8a
L_8e8c84:
	bl L_8d7210
L_8e8c88:
	breq_s r0,0,L_8e8cd8
	.global L_8e8c8a
L_8e8c8a:
	mov_s r2,0x1000928
L_8e8c90:
	mov_s r0,0x0
L_8e8c92:
	bl.d L_8edfb0
L_8e8c96:
	mov_s r1,0x2
L_8e8c98:
	mov_s r14,0x803e84
L_8e8c9e:
	bl.d L_8d69bc
L_8e8ca2:
	mov_s r0,r14
L_8e8ca4:
	mov_s r2,0x1000940
L_8e8caa:
	mov_s r0,0x0
L_8e8cac:
	bl.d L_8edfb0
L_8e8cb0:
	mov_s r1,0x2
L_8e8cb2:
	mov_s r0,r14
L_8e8cb4:
	bl.d L_8d8f80
L_8e8cb8:
	mov_s r1,0x80
L_8e8cba:
	bl.d L_8ec45c
L_8e8cbe:
	mov_s r0,r14
L_8e8cc0:
	bl.d L_8de988
L_8e8cc4:
	mov_s r0,r14
L_8e8cc6:
	mov_s r2,0x1000978
L_8e8ccc:
	mov_s r0,0x0
L_8e8cce:
	bl.d L_8edfb0
L_8e8cd2:
	mov_s r1,0x1
L_8e8cd4:
	bl L_8cfef4
	.global L_8e8cd8
L_8e8cd8:
	ld_s r0,[gp,0x2a4]
L_8e8cda:
	breq_s r0,0,L_8e8cee
L_8e8cdc:
	mov_s r2,0x10009b4
L_8e8ce2:
	mov_s r0,0x0
L_8e8ce4:
	bl.d L_8edfb0
L_8e8ce8:
	mov_s r1,0x2
L_8e8cea:
	bl L_8c918c
	.global L_8e8cee
L_8e8cee:
	mov_s r2,0x10009f0
L_8e8cf4:
	mov_s r0,0x0
L_8e8cf6:
	bl.d L_8edfb0
L_8e8cfa:
	mov_s r1,0x2
L_8e8cfc:
	bl L_8d780c
L_8e8d00:
	mov_s r0,0x880a3c
L_8e8d06:
	st_s r13,[r0,0x24]
L_8e8d08:
	st_s r13,[r0,0x1c]
L_8e8d0a:
	st_s r13,[r0,0x20]
L_8e8d0c:
	mov_s r2,0x1000a10
L_8e8d12:
	mov_s r0,0x0
L_8e8d14:
	bl.d L_8edfb0
L_8e8d18:
	mov_s r1,0x2
L_8e8d1a:
	bl L_8cd9b4
L_8e8d1e:
	mov_s r2,0x1000a68
L_8e8d24:
	mov_s r0,0x0
L_8e8d26:
	bl.d L_8edfb0
L_8e8d2a:
	mov_s r1,0x2
L_8e8d2c:
	mov_s r32,r13
L_8e8d2e:
	mov_s r2,0x1000a88
L_8e8d34:
	mov_s r0,0x0
L_8e8d36:
	bl.d L_8edfb0
L_8e8d3a:
	mov_s r1,0x2
L_8e8d3c:
	mov_s r0,0x3ffff
L_8e8d42:
	bl L_8e96e8
L_8e8d46:
	bl L_8f0ccc
L_8e8d4a:
	mov_s r2,0x1000758
L_8e8d50:
	mov_s r0,0x0
L_8e8d52:
	bl.d L_8edfb0
L_8e8d56:
	mov_s r1,0x2
L_8e8d58:
	bl L_8d6380
L_8e8d5c:
	mov_s r2,0x1000770
L_8e8d62:
	mov_s r0,0x0
L_8e8d64:
	bl.d L_8edfb0
L_8e8d68:
	mov_s r1,0x2
L_8e8d6a:
	bl L_8d579c
L_8e8d6e:
	mov_s r2,0x1000788
L_8e8d74:
	mov_s r0,0x0
L_8e8d76:
	bl.d L_8edfb0
L_8e8d7a:
	mov_s r1,0x2
L_8e8d7c:
	bl L_8d580c
L_8e8d80:
	bl L_8edc94
L_8e8d84:
	bl.d L_8e35cc
L_8e8d88:
	mov_s r0,0x4
L_8e8d8a:
	mov_s r2,0x1000ac0
L_8e8d90:
	mov_s r0,0x0
L_8e8d92:
	bl.d L_8edfb0
L_8e8d96:
	mov_s r1,0x2
L_8e8d98:
	bl L_8e3524
L_8e8d9c:
	bl L_8d7540
L_8e8da0:
	cmp_s r0,0x0
L_8e8da2:
	bl.ne L_8ee90c
L_8e8da6:
	mov_s r2,0x1000b00
L_8e8dac:
	mov_s r0,0x0
L_8e8dae:
	bl.d L_8edfb0
L_8e8db2:
	mov_s r1,0x2
L_8e8db4:
	bl L_8e5354
L_8e8db8:
	b L_8c0334
