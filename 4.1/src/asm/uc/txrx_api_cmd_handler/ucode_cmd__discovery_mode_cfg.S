/* ucode_cmd__discovery_mode_cfg @ 0x934de4, 388 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_api_cmd_handler.c
 *   **********    DISCOVERY ON  (Type: %d) (tail: %d, head: %d)********
 *   [NNL] non_idle_mask: 0x%x
 *   **********    DISCOVERY OFF (Type: %d) (tail: %d, head: %d)********
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bf_clear_all_sta, perform_shallow_sleep, uc_sysassert
 * Глобалы (через gp): 0x800544
 */
	.section .text.ucode_cmd__discovery_mode_cfg,"ax",@progbits
	.global ucode_cmd__discovery_mode_cfg
ucode_cmd__discovery_mode_cfg:
	.global L_934de4
L_934de4:
	push_s blink
L_934de6:
	bl L_92020c
L_934dea:
	ld_s r2,[r0,0x4]
L_934dec:
	stb r2,[gp, -0xef]
L_934df0:
	ld_s r0,[r0]
L_934df2:
	extb r4,r2
L_934df6:
	breq r0,0x0,L_934ec4
L_934dfa:
	breq r0,0x1,L_934e14
L_934dfe:
	mov_s r0,blink
L_934e00:
	mov_s r2,0x1001830
L_934e06:
	mov r1,0x104
L_934e0a:
	bl.d L_925548
L_934e0e:
	mov r3,0x10c
L_934e12:
	b_s L_934f64
	.global L_934e14
L_934e14:
	mov_s r1,0x80209c
L_934e1a:
	ldb_s r2,[r1,0x4]
L_934e1c:
	mov r5,0x1001848
L_934e24:
	mov r16,0x1
L_934e28:
	bbit0 r2,0x2,L_934e74
L_934e2c:
	ld_s r0,[r1]
L_934e2e:
	mov_s r3,0x800ef4
L_934e34:
	add_s r15,r0,0x3
L_934e36:
	extb_s r15,r15
L_934e38:
	ld_s r14,[r3,0x78]
L_934e3a:
	mov_s r13,0x8020b0
L_934e40:
	add2 r15,r13,r15
L_934e44:
	st_s r14,[r15]
L_934e46:
	add_s r14,r0,0x2
L_934e48:
	extb_s r14,r14
L_934e4a:
	ld_s r3,[r3,0x7c]
L_934e4c:
	add2 r14,r13,r14
L_934e50:
	st_s r3,[r14]
L_934e52:
	add_s r3,r0,0x1
L_934e54:
	extb_s r3,r3
L_934e56:
	add2 r3,r13,r3
L_934e5a:
	st r4,[r3]
L_934e5e:
	bmsk r3,r5,0x13
L_934e62:
	or r3,r3,0xae000000
L_934e6a:
	extb_s r14,r0
L_934e6c:
	add2_s r13,r13,r14
L_934e6e:
	st_s r3,[r13]
L_934e70:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_934e72:
	st_s r0,[r1]
	.global L_934e74
L_934e74:
	mov_s r0,0x100188c
L_934e7a:
	bbit0 r2,0x2,L_934eac
L_934e7e:
	ld_s r2,[r1]
L_934e80:
	mov_s r3,0x800ef4
L_934e86:
	add_s r14,r2,0x1
L_934e88:
	extb_s r14,r14
L_934e8a:
	ld_s r3,[r3,0x6c]
L_934e8c:
	mov_s r13,0x8020b0
L_934e92:
	add2 r14,r13,r14
L_934e96:
	st_s r3,[r14]
L_934e98:
	bmsk_s r0,r0,0x13
L_934e9a:
	or r0,r0,0xa6000000
L_934ea2:
	extb_s r3,r2
L_934ea4:
	add2_s r13,r13,r3
L_934ea6:
	st_s r0,[r13]
L_934ea8:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
L_934eaa:
	st_s r2,[r1]
	.global L_934eac
L_934eac:
	mov_s r0,0x801ed0
L_934eb2:
	mov_s r1,0x0
L_934eb4:
	mov_s r2,r1
L_934eb6:
	mov_s r3,0x1
L_934eb8:
	bl.d L_92af4c
L_934ebc:
	mov_s r4,r3
L_934ebe:
	st.as r16,[gp,0x7]
L_934ec2:
	b_s L_934f64
	.global L_934ec4
L_934ec4:
	mov_s r2,0x80209c
L_934eca:
	ldb_s r3,[r2,0x4]
L_934ecc:
	mov r6,0x10018a8
L_934ed4:
	mov_s r1,0x800ef4
L_934eda:
	mov r5,0x0
L_934ede:
	bbit0 r3,0x2,L_934f24
L_934ee2:
	ld_s r13,[r2]
L_934ee4:
	mov_s r14,0x8020b0
L_934eea:
	add_s r0,r13,0x3
L_934eec:
	extb_s r0,r0
L_934eee:
	ld_s r15,[r1,0x78]
L_934ef0:
	add2 r0,r14,r0
L_934ef4:
	st_s r15,[r0]
L_934ef6:
	add_s r15,r13,0x2
L_934ef8:
	extb_s r15,r15
L_934efa:
	ld_s r0,[r1,0x7c]
L_934efc:
	add2 r15,r14,r15
L_934f00:
	st_s r0,[r15]
L_934f02:
	add_s r0,r13,0x1
L_934f04:
	extb_s r0,r0
L_934f06:
	add2 r0,r14,r0
L_934f0a:
	st r4,[r0]
L_934f0e:
	bmsk r0,r6,0x13
L_934f12:
	or r0,r0,0xae000000
L_934f1a:
	extb_s r15,r13
L_934f1c:
	add2_s r14,r14,r15
L_934f1e:
	st_s r0,[r14]
L_934f20:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
L_934f22:
	st_s r13,[r2]
	.global L_934f24
L_934f24:
	mov_s r0,0x100188c
L_934f2a:
	bbit0 r3,0x2,L_934f56
L_934f2e:
	ld_s r3,[r2]
L_934f30:
	mov_s r13,0x8020b0
L_934f36:
	add_s r14,r3,0x1
L_934f38:
	extb_s r14,r14
L_934f3a:
	ld_s r15,[r1,0x6c]
L_934f3c:
	add2 r14,r13,r14
L_934f40:
	st_s r15,[r14]
L_934f42:
	bmsk_s r0,r0,0x13
L_934f44:
	or r0,r0,0xa6000000
L_934f4c:
	extb_s r14,r3
L_934f4e:
	add2_s r13,r13,r14
L_934f50:
	st_s r0,[r13]
L_934f52:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_934f54:
	st_s r3,[r2]
	.global L_934f56
L_934f56:
	ld_s r2,[r1,0x7c]
L_934f58:
	ld_s r0,[r1,0x78]
L_934f5a:
	st.as r5,[gp,0x7]
L_934f5e:
	cmp_s r2,r0
L_934f60:
	bl.hi L_92211c
	.global L_934f64
L_934f64:
	b L_920274
