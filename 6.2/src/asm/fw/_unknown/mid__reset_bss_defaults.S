/* mid__reset_bss_defaults @ 0x8c4d24, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_started_log, l2mgr__stop_discovery
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bcon_tx_build_step, bits__set16_s7_w5, bits__set32_s0_w5, bits__set8_s2_w5, bss_set_mode, dmg_cap__build_sta_capability, l2mgr__apply_mac_address, l2mgr__set_edca_defaults, mid__bits_set32_s5_w5, mid__reset_10b_at_248
 * Глобалы (через gp): 0x8002d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__reset_bss_defaults
mid__reset_bss_defaults:
	.global L_8c4d24
L_8c4d24:
	push_s blink
L_8c4d26:
	bl L_8c01d8
L_8c4d2a:
	sub_s sp,sp,0x4
L_8c4d2c:
	mov_s r14,r0
L_8c4d2e:
	mov_s r17,r2
L_8c4d30:
	mov_s r16,r3
L_8c4d32:
	bl.d L_8e6368
L_8c4d36:
	mov_s r15,r4
L_8c4d38:
	mov_s r0,r14
L_8c4d3a:
	bl.d L_8c4eec
L_8c4d3e:
	mov_s r1,r15
L_8c4d40:
	mov_s r0,0xa
L_8c4d42:
	add3 r13,r14,0x8
L_8c4d46:
	ld_s r1,[r14]
L_8c4d48:
	stw_s r0,[r13,0xe]
L_8c4d4a:
	add_s r1,r1,0xa
L_8c4d4c:
	bl.d L_8e6598
L_8c4d50:
	mov_s r0,r14
L_8c4d52:
	bl.d L_8c4e04
L_8c4d56:
	mov_s r0,r14
L_8c4d58:
	mov_s r0,r14
L_8c4d5a:
	bl.d L_8c4e20
L_8c4d5e:
	mov_s r1,r15
L_8c4d60:
	bl.d L_8c4df8
L_8c4d64:
	mov_s r0,r14
L_8c4d66:
	mov_s r0,r14
L_8c4d68:
	bl.d L_8c4c20
L_8c4d6c:
	mov_s r1,0x1
L_8c4d6e:
	mov_s r0,r14
L_8c4d70:
	mov_s r1,r17
L_8c4d72:
	bl.d L_8e70a8
L_8c4d76:
	mov_s r2,r16
L_8c4d78:
	bl.d L_8d97a4
L_8c4d7c:
	mov_s r0,r14
L_8c4d7e:
	bl.d L_8c4ee4
L_8c4d82:
	mov_s r0,r14
L_8c4d84:
	mov_s r1,0x0
L_8c4d86:
	ldb r2,[sp, 0x3]
L_8c4d8a:
	ldb r0,[sp, 0x2]
L_8c4d8e:
	asl_s r2,r2,0x8
L_8c4d90:
	or_s r0,r0,r2
L_8c4d92:
	bic r2,r0,0x30
L_8c4d96:
	stb r2,[sp, 0x2]
L_8c4d9a:
	lsr_s r2,r2,0x8
L_8c4d9c:
	mov_s r0,sp
L_8c4d9e:
	bl.d L_8ed538
L_8c4da2:
	stb r2,[sp, 0x3]
L_8c4da6:
	add r0,sp,0x1
L_8c4daa:
	bl L_8ed1fc
L_8c4dae:
	mov_s r1,0xc
L_8c4db0:
	mov_s r0,sp
L_8c4db2:
	bl L_8ed37c
L_8c4db6:
	add r0,sp,0x1
L_8c4dba:
	bl L_8ed274
L_8c4dbe:
	mov_s r1,0x803c00
L_8c4dc4:
	ld_s r0,[r1,0xc]
L_8c4dc6:
	brne_s r0,0,L_8c4dcc
L_8c4dc8:
	ld_s r0,[r1,0x10]
L_8c4dca:
	breq_s r0,0,L_8c4dd6
	.global L_8c4dcc
L_8c4dcc:
	mov_s r1,0x4
L_8c4dce:
	add r0,sp,0x1
L_8c4dd2:
	bl L_8ed274
	.global L_8c4dd6
L_8c4dd6:
	mov_s r1,sp
L_8c4dd8:
	bl.d L_8e70c4
L_8c4ddc:
	mov_s r0,r14
L_8c4dde:
	ld_s r1,[r14]
L_8c4de0:
	mov_s r0,r14
L_8c4de2:
	ld_s r1,[r1,0x14]
L_8c4de4:
	bl.d L_8e73a0
L_8c4de8:
	mov_s r2,0x0
L_8c4dea:
	ld_s r0,[gp,0x150]
L_8c4dec:
	stw_s r0,[r13,0x10]
L_8c4dee:
	ld_s r0,[gp,0x150]
L_8c4df0:
	stw_s r0,[r13,0xe]
L_8c4df2:
	b.d L_8c023c
L_8c4df6:
	add_s sp,sp,0x4
