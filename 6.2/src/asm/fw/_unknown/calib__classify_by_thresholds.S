/* calib__classify_by_thresholds @ 0x8e2d5c, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: silent_rssi__calibrate_single_rf_module
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rfca__touch_rf_module, temp__get_rf_by_index
 * Глобалы (через gp): 0x800408
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__classify_by_thresholds
calib__classify_by_thresholds:
	.global L_8e2d5c
L_8e2d5c:
	push_s blink
L_8e2d5e:
	bl L_8c01e0
L_8e2d62:
	mov_s r13,r0
L_8e2d64:
	mov_s r14,r1
L_8e2d66:
	mov_s r0,r1
L_8e2d68:
	mov_s r15,0x1
L_8e2d6a:
	bl.d L_8cca40
L_8e2d6e:
	mov_s r1,r15
L_8e2d70:
	ld.as r1,[gp,0xa1]
L_8e2d74:
	ldb.x r2,[r1]
L_8e2d78:
	cmp_s r0,r2
L_8e2d7a:
	mov.lt r15,0x0
L_8e2d7e:
	blt_s L_8e2d96
L_8e2d80:
	ldb.x r2,[r1, 0x1]
L_8e2d84:
	brlt r0,r2,L_8e2d96
L_8e2d88:
	ldb.x r2,[r1, 0x2]
L_8e2d8c:
	mov_s r15,0x1
L_8e2d8e:
	cmp_s r0,r2
L_8e2d90:
	sub.lt r15,r15,r15
L_8e2d94:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
	.global L_8e2d96
L_8e2d96:
	add_s r1,r1,0x77
L_8e2d98:
	add_s r1,r1,r14
L_8e2d9a:
	stb_s r15,[r1]
L_8e2d9c:
	ld.as r1,[gp,0xa1]
L_8e2da0:
	ldb.x r2,[r1, 0x14]
L_8e2da4:
	cmp_s r0,r2
L_8e2da6:
	mov_s r2,0x0
L_8e2da8:
	blt_s L_8e2dc2
L_8e2daa:
	ldb.x r2,[r1, 0x15]
L_8e2dae:
	cmp_s r0,r2
L_8e2db0:
	mov_s r2,0x1
L_8e2db2:
	blt_s L_8e2dc2
L_8e2db4:
	ldb.x r2,[r1, 0x16]
L_8e2db8:
	cmp_s r0,r2
L_8e2dba:
	mov_s r2,0x1
L_8e2dbc:
	sub.lt r2,r2,r2
L_8e2dc0:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8e2dc2
L_8e2dc2:
	add_s r1,r1,0x7f
L_8e2dc4:
	add_s r1,r1,r14
L_8e2dc6:
	stb_s r2,[r1]
L_8e2dc8:
	ld.as r1,[gp,0xa1]
L_8e2dcc:
	add r3,r1,0x20
L_8e2dd0:
	ldb.x r2,[r3, 0x18]
L_8e2dd4:
	cmp_s r0,r2
L_8e2dd6:
	mov_s r2,0x0
L_8e2dd8:
	blt_s L_8e2df2
L_8e2dda:
	ldb.x r2,[r3, 0x19]
L_8e2dde:
	cmp_s r0,r2
L_8e2de0:
	mov_s r2,0x1
L_8e2de2:
	blt_s L_8e2df2
L_8e2de4:
	ldb.x r2,[r3, 0x1a]
L_8e2de8:
	cmp_s r0,r2
L_8e2dea:
	mov_s r2,0x1
L_8e2dec:
	sub.lt r2,r2,r2
L_8e2df0:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8e2df2
L_8e2df2:
	add r1,r1,0x87
L_8e2df6:
	add_s r1,r1,r14
L_8e2df8:
	stb_s r2,[r1]
L_8e2dfa:
	ld.as r1,[gp,0xa1]
L_8e2dfe:
	add3 r3,r1,0x8
L_8e2e02:
	ldb.x r2,[r3, 0xc]
L_8e2e06:
	cmp_s r0,r2
L_8e2e08:
	mov_s r2,0x0
L_8e2e0a:
	blt_s L_8e2e24
L_8e2e0c:
	ldb.x r2,[r3, 0xd]
L_8e2e10:
	cmp_s r0,r2
L_8e2e12:
	mov_s r2,0x1
L_8e2e14:
	blt_s L_8e2e24
L_8e2e16:
	ldb.x r2,[r3, 0xe]
L_8e2e1a:
	cmp_s r0,r2
L_8e2e1c:
	mov_s r2,0x1
L_8e2e1e:
	sub.lt r2,r2,r2
L_8e2e22:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8e2e24
L_8e2e24:
	add r1,r1,0x8f
L_8e2e28:
	add_s r1,r1,r14
L_8e2e2a:
	stb_s r2,[r1]
L_8e2e2c:
	ld.as r1,[gp,0xa1]
L_8e2e30:
	add3 r3,r1,0xc
L_8e2e34:
	ldb.x r2,[r3, 0x10]
L_8e2e38:
	cmp_s r0,r2
L_8e2e3a:
	mov.lt r0,0x0
L_8e2e3e:
	blt_s L_8e2e5a
L_8e2e40:
	ldb.x r2,[r3, 0x11]
L_8e2e44:
	cmp_s r0,r2
L_8e2e46:
	mov.lt r0,0x1
L_8e2e4a:
	blt_s L_8e2e5a
L_8e2e4c:
	ldb.x r2,[r3, 0x12]
L_8e2e50:
	cmp_s r0,r2
L_8e2e52:
	mov_s r0,0x1
L_8e2e54:
	sub.lt r0,r0,r0
L_8e2e58:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
	.global L_8e2e5a
L_8e2e5a:
	add r1,r1,0x97
L_8e2e5e:
	add_s r1,r1,r14
L_8e2e60:
	stb_s r0,[r1]
L_8e2e62:
	mov_s r0,r13
L_8e2e64:
	mov_s r1,r14
L_8e2e66:
	bl.d L_8e2fc0
L_8e2e6a:
	mov_s r2,0x0
L_8e2e6c:
	ld_s r0,[gp,0x284]
L_8e2e6e:
	mov_s r1,r0
L_8e2e70:
	add r1,r1,0x97
L_8e2e74:
	ldb.x r1,[r1,r14]
L_8e2e78:
	add_s r0,r0,0x73
L_8e2e7a:
	ldb.x r0,[r0,r1]
L_8e2e7e:
	b.d L_8c024c
L_8e2e82:
	stb r0,[r13, 0x4d]
L_8e2e86:
	nop_s
