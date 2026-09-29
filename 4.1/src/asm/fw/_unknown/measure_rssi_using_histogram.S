/* measure_rssi_using_histogram @ 0x8d9ed0, 296 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   measure_rssi_using_histogram(associated), RSSI 0 detected!!!, com_test:%d
 * Зовут его: agc_start_index
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, hwd_abif__rgf_88a200_8cc674, memset0_words, rf_comm_test
 */
	.section .text.measure_rssi_using_histogram,"ax",@progbits
	.global measure_rssi_using_histogram
measure_rssi_using_histogram:
	.global L_8d9ed0
L_8d9ed0:
	push_s blink
L_8d9ed2:
	bl L_8c02c0
L_8d9ed6:
	mov_s r15,r1
L_8d9ed8:
	mov_s r13,0x804394
L_8d9ede:
	mov_s r0,r13
L_8d9ee0:
	bl.d L_8c1a78
L_8d9ee4:
	mov_s r1,0x40
L_8d9ee6:
	extb_s r15,r15
L_8d9ee8:
	mov_s r14,0x0
L_8d9eea:
	mov_s r0,r14
L_8d9eec:
	bl.d L_8cc674
L_8d9ef0:
	mov_s r1,r15
L_8d9ef2:
	mov_s r0,0x1
L_8d9ef4:
	bl.d L_8cc674
L_8d9ef8:
	mov_s r1,r15
L_8d9efa:
	mov_s r15,0x800494
L_8d9f00:
	ldw_s r0,[r15]
L_8d9f02:
	bbit0 r0,0x0,L_8d9f88
L_8d9f06:
	b_s L_8d9f32
	.global L_8d9f08
L_8d9f08:
	mov_s r0,0x50
L_8d9f0a:
	mov lp_count,r0
L_8d9f0e:
	nop_s
L_8d9f10:
	lp L_8d9f18
L_8d9f14:
	nop_s
L_8d9f16:
	nop_s
	.global L_8d9f18
L_8d9f18:
	mov_s r0,0x883700
L_8d9f1e:
	ld_s r0,[r0]
L_8d9f20:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d9f22:
	cmp_s r0,0x1f
L_8d9f24:
	mov.cc r0,0x1f
L_8d9f28:
	add1 r1,r13,r0
L_8d9f2c:
	ldw_s r0,[r1]
L_8d9f2e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9f30:
	stw_s r0,[r1]
	.global L_8d9f32
L_8d9f32:
	mov_s r15,0x800494
L_8d9f38:
	ldw_s r0,[r15,0x2]
L_8d9f3a:
	brlt r14,r0,L_8d9f08
L_8d9f3e:
	b_s L_8d9f90
	.global L_8d9f40
L_8d9f40:
	mov_s r2,0x883700
L_8d9f46:
	ld_s r3,[r2]
L_8d9f48:
	ld_s r0,[r2]
L_8d9f4a:
	ld_s r1,[r2]
L_8d9f4c:
	min r3,r3,0x1f
L_8d9f50:
	ld_s r2,[r2]
L_8d9f52:
	min r0,r0,0x1f
L_8d9f56:
	min r4,r2,0x1f
L_8d9f5a:
	add1 r2,r13,r3
L_8d9f5e:
	ldw_s r3,[r2]
L_8d9f60:
	min r1,r1,0x1f
L_8d9f64:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8d9f66:
	stw_s r3,[r2]
L_8d9f68:
	add1 r2,r13,r0
L_8d9f6c:
	ldw_s r0,[r2]
L_8d9f6e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d9f70:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9f72:
	stw_s r0,[r2]
L_8d9f74:
	add1 r2,r13,r1
L_8d9f78:
	ldw_s r0,[r2]
L_8d9f7a:
	add1 r1,r13,r4
L_8d9f7e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9f80:
	stw_s r0,[r2]
L_8d9f82:
	ldw_s r0,[r1]
L_8d9f84:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d9f86:
	stw_s r0,[r1]
	.global L_8d9f88
L_8d9f88:
	ldw_s r0,[r15,0x2]
L_8d9f8a:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_8d9f8c:
	brlt r14,r0,L_8d9f40
	.global L_8d9f90
L_8d9f90:
	ldw_s r1,[r13]
L_8d9f92:
	ldw_s r0,[r15,0x4]
L_8d9f94:
	brge r0,r1,L_8d9fb4
L_8d9f98:
	mov_s r0,0x803e84
L_8d9f9e:
	bl.d L_8c5cac
L_8d9fa2:
	ldb_s r1,[r0]
L_8d9fa4:
	mov_s r3,r0
L_8d9fa6:
	mov_s r2,0x1008824
L_8d9fac:
	mov_s r0,0x6
L_8d9fae:
	bl.d L_8edfcc
L_8d9fb2:
	mov_s r1,0x1
	.global L_8d9fb4
L_8d9fb4:
	mov_s r0,0x0
L_8d9fb6:
	mov_s r1,r0
L_8d9fb8:
	b_s L_8d9fbc
	.global L_8d9fba
L_8d9fba:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d9fbc
L_8d9fbc:
	brge r1,0x20,L_8d9ff0
L_8d9fc0:
	mov_s r2,0x800d08
L_8d9fc6:
	ldb_s r3,[r2,0x1]
L_8d9fc8:
	brlt r1,r3,L_8d9fd6
L_8d9fcc:
	sub r14,r1,r3
L_8d9fd0:
	ldw.as r14,[r13,r14]
L_8d9fd4:
	sub_s r0,r0,r14
	.global L_8d9fd6
L_8d9fd6:
	ldw.as r14,[r13,r1]
L_8d9fda:
	add_s r0,r0,r14
L_8d9fdc:
	ldw_s r14,[r15,0x4]
L_8d9fde:
	brge r14,r0,L_8d9fba
L_8d9fe2:
	sub_s r1,r1,r3
L_8d9fe4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8d9fe6:
	ldb_s r0,[r2,0x2]
L_8d9fe8:
	cmp_s r1,0x0
L_8d9fea:
	add.ge r0,r0,r1
L_8d9fee:
	b_s L_8d9ff2
	.global L_8d9ff0
L_8d9ff0:
	mov_s r0,0x0
	.global L_8d9ff2
L_8d9ff2:
	b L_8c032c
L_8d9ff6:
	nop_s
