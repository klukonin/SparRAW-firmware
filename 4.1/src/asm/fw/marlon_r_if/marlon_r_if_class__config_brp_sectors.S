/* marlon_r_if_class__config_brp_sectors @ 0x8c5f18, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   valid_antennas_vec=0x%X, valid_antennas_count=%d, BRP_ARRAY_MAX_SIZE=%d
 *   marlon_r_if.cpp
 *   marlon_r_if_class::config_brp_sectors: Failed to write brp sectors to RF HW, ant=%d,counter=%d
 * Зовут его: marlon_r_if_class__config_channel
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, brp_sectors__clear_table, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, marlon_r_if__write_reg, marlon_r_if_class__rf_write_with_block_retries
 */
	.section .text.marlon_r_if_class__config_brp_sectors,"ax",@progbits
	.global marlon_r_if_class__config_brp_sectors
marlon_r_if_class__config_brp_sectors:
	.global L_8c5f18
L_8c5f18:
	push_s blink
L_8c5f1a:
	bl.d L_8c02b4
L_8c5f1e:
	mov r2,0x55c
L_8c5f22:
	sub sp,sp,0x180
L_8c5f26:
	mov_s r14,r0
L_8c5f28:
	mov_s r3,0x3f5f40
L_8c5f2e:
	bl.d L_8e7f60
L_8c5f32:
	ldb_s r1,[r0]
L_8c5f34:
	mov_s r0,0x0
L_8c5f36:
	st_s r0,[r14,0x4]
L_8c5f38:
	mov_s r0,r14
L_8c5f3a:
	ldb_s r1,[r14]
L_8c5f3c:
	mov r2,0x560
L_8c5f40:
	mov_s r13,0x1
L_8c5f42:
	bl.d L_8e7f60
L_8c5f46:
	mov_s r3,r13
L_8c5f48:
	st_s r13,[r14,0x4]
L_8c5f4a:
	mov_s r0,0x50
L_8c5f4c:
	mov lp_count,r0
L_8c5f50:
	nop_s
L_8c5f52:
	lp L_8c5f5a
L_8c5f56:
	nop_s
L_8c5f58:
	nop_s
	.global L_8c5f5a
L_8c5f5a:
	mov r18,0x6
L_8c5f5e:
	mov_s r15,0x13
L_8c5f60:
	asl_s r15,r15,0x9
L_8c5f62:
	mov r17,0x0
L_8c5f66:
	bl.d L_8caccc
L_8c5f6a:
	mov_s r0,r14
L_8c5f6c:
	mov_s r4,r0
L_8c5f6e:
	mov r16,0x857000
L_8c5f76:
	ld r3,[r16, 0x4c]
L_8c5f7a:
	mov_s r2,0x1005b74
L_8c5f80:
	mov_s r0,0x0
L_8c5f82:
	mov_s r1,0x2
L_8c5f84:
	bl.d L_8ee034
L_8c5f88:
	mov r5,0x30
L_8c5f8c:
	mov_s r13,0x0
L_8c5f8e:
	b_s L_8c5ff0
	.global L_8c5f90
L_8c5f90:
	add_s r2,r2,0x20000000
	.global L_8c5f96
L_8c5f96:
	st_s r2,[r0,0x4]
L_8c5f98:
	add r17,r1,0x1
L_8c5f9c:
	add_s r15,r15,0x18
	.global L_8c5f9e
L_8c5f9e:
	cmp_s r13,0xf
L_8c5fa0:
	cmp.ne r13,0x1f
L_8c5fa4:
	bne_s L_8c5fee
L_8c5fa6:
	brlo r17,0x31,L_8c5fc0
L_8c5faa:
	mov_s r0,blink
L_8c5fac:
	mov_s r2,0x1005078
L_8c5fb2:
	mov_s r1,0x1346
L_8c5fb8:
	bl.d L_8c82c0
L_8c5fbc:
	mov r3,0x387
	.global L_8c5fc0
L_8c5fc0:
	mov_s r2,sp
L_8c5fc2:
	mov_s r0,r14
L_8c5fc4:
	ldb_s r1,[r14]
L_8c5fc6:
	mov_s r3,r17
L_8c5fc8:
	mov r4,0x10
L_8c5fcc:
	bl.d L_8deaac
L_8c5fd0:
	mov r5,0x5
L_8c5fd4:
	brne_s r0,0,L_8c5fea
L_8c5fd6:
	mov_s r2,0x1005bbc
L_8c5fdc:
	mov_s r0,0x0
L_8c5fde:
	mov_s r1,r0
L_8c5fe0:
	mov_s r3,r13
L_8c5fe2:
	bl.d L_8edff8
L_8c5fe6:
	mov r4,r17
	.global L_8c5fea
L_8c5fea:
	mov r17,0x0
	.global L_8c5fee
L_8c5fee:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c5ff0
L_8c5ff0:
	brhs r13,0x20,L_8c6040
L_8c5ff4:
	mov_s r2,0x0
L_8c5ff6:
	ld r0,[r16, 0x4c]
L_8c5ffa:
	bset r2,r2,r13
L_8c5ffe:
	tst_s r2,r0
L_8c6000:
	beq_s L_8c5f9e
L_8c6002:
	add r1,r15,0x14
L_8c6006:
	add3 r0,sp,r17
L_8c600a:
	st_s r1,[r0]
L_8c600c:
	st_s r2,[r0,0x4]
L_8c600e:
	add r1,r17,0x1
L_8c6012:
	add r3,r15,0x8
L_8c6016:
	add3 r0,sp,r1
L_8c601a:
	st_s r3,[r0]
L_8c601c:
	st_s r2,[r0,0x4]
L_8c601e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c6020:
	lsr r0,r13,0x2
L_8c6024:
	add1_s r0,r0,r0
L_8c6026:
	asl r2,r18,r0
L_8c602a:
	add r3,r15,0x10
L_8c602e:
	add3 r0,sp,r1
L_8c6032:
	brhs.d r13,0x10,L_8c5f90
L_8c6036:
	st_s r3,[r0]
L_8c6038:
	add_s r2,r2,0x10000000
L_8c603e:
	b_s L_8c5f96
	.global L_8c6040
L_8c6040:
	b.d L_8c0314
L_8c6044:
	add sp,sp,0x180
