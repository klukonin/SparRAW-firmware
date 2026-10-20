/* bcn_tx_init_ss_params @ 0x8c3d2c, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bcn_tx_init_ss_params: discovery beacon total sectors %d
 *   lmac_if.cpp
 *   bcn_tx_init_ss_params: IDLE  hi:low %x:%x  total sectors %d
 *   bcn_tx_init_ss_params: WORK  hi:low %x:%x  total sectors %d
 *   bcn_tx_init_ss_params: num_sectors_per_ant=%d, mask_hi[0:31]=0x%08x, mask_lo[32:63]=0x%08x
 * Зовут его: lmac_if__build_bcon_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bcon_ss__call_vmethod_10, bcon_ss__call_vmethod_14, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, memset0_words, popcount32
 */
	.section .text.bcn_tx_init_ss_params,"ax",@progbits
	.global bcn_tx_init_ss_params
bcn_tx_init_ss_params:
	.global L_8c3d2c
L_8c3d2c:
	sub_s sp,sp,0x8
L_8c3d2e:
	push_s blink
L_8c3d30:
	bl L_8c02c0
L_8c3d34:
	st_s r1,[sp,0x10]
L_8c3d36:
	st_s r2,[sp,0x14]
L_8c3d38:
	mov_s r14,r0
L_8c3d3a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c3d3c:
	bl.d L_8c1a78
L_8c3d40:
	mov_s r1,0x70
L_8c3d42:
	ld.as r13,[gp,-0x3]
L_8c3d46:
	breq_s r13,0,L_8c3d80
	.global L_8c3d48
L_8c3d48:
	ld_s r0,[r13,0x28]
L_8c3d4a:
	stb_s r0,[r14,0x1c]
L_8c3d4c:
	ldb_s r0,[sp,0x10]
L_8c3d4e:
	bbit0 r0,0x1,L_8c3d96
L_8c3d52:
	mov_s r13,0x803e84
L_8c3d58:
	mov_s r0,r13
L_8c3d5a:
	bl.d L_8ca8ac
L_8c3d5e:
	mov_s r1,0x0
L_8c3d60:
	st_s r0,[r14,0x8]
L_8c3d62:
	mov_s r0,r13
L_8c3d64:
	bl.d L_8ca8dc
L_8c3d68:
	mov_s r1,0x0
L_8c3d6a:
	st_s r0,[r14,0x4]
L_8c3d6c:
	mov_s r3,0x10
L_8c3d6e:
	stw_s r3,[r14,0x1e]
L_8c3d70:
	mov_s r2,0x1004d4c
L_8c3d76:
	mov_s r0,0x0
L_8c3d78:
	bl.d L_8edfcc
L_8c3d7c:
	mov_s r1,0x2
L_8c3d7e:
	b_s L_8c3e10
	.global L_8c3d80
L_8c3d80:
	mov_s r0,blink
L_8c3d82:
	mov_s r2,0x1003e50
L_8c3d88:
	mov_s r1,0x4d
L_8c3d8a:
	bset_s r1,r1,0xc
L_8c3d8c:
	bl.d L_8c82c0
L_8c3d90:
	mov r3,0x554
L_8c3d94:
	b_s L_8c3d48
	.global L_8c3d96
L_8c3d96:
	ldb r0,[sp, 0x15]
L_8c3d9a:
	lsr_s r0,r0,0x4
L_8c3d9c:
	bmsk_s r0,r0,0x1
L_8c3d9e:
	brne r0,0x1,L_8c3de0
L_8c3da2:
	mov_s r15,0x803e84
L_8c3da8:
	mov_s r0,r15
L_8c3daa:
	bl.d L_8ca8ac
L_8c3dae:
	mov_s r1,0x0
L_8c3db0:
	st_s r0,[r14,0x8]
L_8c3db2:
	mov_s r0,r15
L_8c3db4:
	bl.d L_8ca8dc
L_8c3db8:
	mov_s r1,0x0
L_8c3dba:
	st_s r0,[r14,0x4]
L_8c3dbc:
	bl.d L_8c6c5c
L_8c3dc0:
	ld_s r0,[r14,0x8]
L_8c3dc2:
	mov_s r3,r0
L_8c3dc4:
	bl.d L_8c6c5c
L_8c3dc8:
	ld_s r0,[r14,0x4]
L_8c3dca:
	mov_s r2,0x1004d88
L_8c3dd0:
	add r5,r0,r3
L_8c3dd4:
	stw r5,[r14, 0x1e]
L_8c3dd8:
	ld_s r3,[r13,0x2c]
L_8c3dda:
	ld r4,[r13, 0x30]
L_8c3dde:
	b_s L_8c3e08
	.global L_8c3de0
L_8c3de0:
	ld_s r0,[r13,0x34]
L_8c3de2:
	st_s r0,[r14,0x8]
L_8c3de4:
	ld_s r1,[r13,0x38]
L_8c3de6:
	bl.d L_8c6c5c
L_8c3dea:
	st_s r1,[r14,0x4]
L_8c3dec:
	mov_s r3,r0
L_8c3dee:
	bl.d L_8c6c5c
L_8c3df2:
	ld_s r0,[r14,0x4]
L_8c3df4:
	mov_s r2,0x1004dc8
L_8c3dfa:
	add r5,r0,r3
L_8c3dfe:
	stw r5,[r14, 0x1e]
L_8c3e02:
	ld_s r3,[r13,0x34]
L_8c3e04:
	ld r4,[r13, 0x38]
	.global L_8c3e08
L_8c3e08:
	mov_s r0,0x0
L_8c3e0a:
	bl.d L_8ee034
L_8c3e0e:
	mov_s r1,0x2
	.global L_8c3e10
L_8c3e10:
	bl.d L_8c6c5c
L_8c3e14:
	ld_s r0,[r14,0x8]
L_8c3e16:
	stb_s r0,[r14,0x1d]
L_8c3e18:
	bl.d L_8c6c5c
L_8c3e1c:
	ld_s r0,[r14,0x4]
L_8c3e1e:
	ldb_s r3,[r14,0x1d]
L_8c3e20:
	mov_s r2,0x1004e08
L_8c3e26:
	add_s r3,r3,r0
L_8c3e28:
	extb_s r3,r3
L_8c3e2a:
	ld r4,[r14, 0x8]
L_8c3e2e:
	stb_s r3,[r14,0x1d]
L_8c3e30:
	ld r5,[r14, 0x4]
L_8c3e34:
	mov_s r0,0x0
L_8c3e36:
	bl.d L_8ee034
L_8c3e3a:
	mov_s r1,0x2
L_8c3e3c:
	mov_s r12,0xc
L_8c3e3e:
	.byte 0xf3,0x04
