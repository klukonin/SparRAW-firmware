/* lmac_if_set_ss_sectors_default_cfg_handler @ 0x8dbfa0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_set_ss_sectors_default_cfg_handler: INVALID PARAM cid = %d, expected [0-8]
 *   lmac_if_set_ss_sectors_default_cfg_handler: INVALID PARAM sector_sweep_type= %d, exp: TXSS-0,Beacon-1,Both-2
 * Зовут его: wmi_prio_tx_sectors_set_default_cfg
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal, lmac_cmd_pool__alloc, lmac_if__post_cmd, rf_if__tx_sectors_vcall_14, sector_list__validate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_set_ss_sectors_default_cfg_handler
lmac_if_set_ss_sectors_default_cfg_handler:
	.global L_8dbfa0
L_8dbfa0:
	push_s blink
L_8dbfa2:
	bl L_8c01e4
L_8dbfa6:
	ldb_s r2,[r0,0x1]
L_8dbfa8:
	brlt.d r2,0x9,L_8dbfbe
L_8dbfac:
	mov_s r14,r0
L_8dbfae:
	mov_s r1,0x1004db4
	.global L_8dbfb4
L_8dbfb4:
	bl.d L_8dcc10
L_8dbfb8:
	mov_s r0,0x10
L_8dbfba:
	mov_s r0,0x1
L_8dbfbc:
	b_s L_8dc012
	.global L_8dbfbe
L_8dbfbe:
	ldb_s r2,[r14]
L_8dbfc0:
	brlo r2,0x3,L_8dbfcc
L_8dbfc4:
	mov_s r1,0x1004e08
L_8dbfca:
	b_s L_8dbfb4
	.global L_8dbfcc
L_8dbfcc:
	bl L_8c3284
L_8dbfd0:
	mov_s r13,r0
L_8dbfd2:
	mov_s r0,0x8042c8
L_8dbfd8:
	bl L_8cb7f8
L_8dbfdc:
	mov_s r2,0x0
L_8dbfde:
	mov_s r1,r0
L_8dbfe0:
	mov_s r0,r13
L_8dbfe2:
	bl.d L_8d9ac8
L_8dbfe6:
	mov_s r3,r2
L_8dbfe8:
	cmp_s r0,0x0
L_8dbfea:
	mov.eq r0,blink
L_8dbfee:
	mov.eq r1,0x136b
L_8dbff6:
	bl.eq L_8c9b28
L_8dbffa:
	ldb_s r0,[r14,0x1]
L_8dbffc:
	mov_s r1,0x35
L_8dbffe:
	stb r0,[r13, 0x50]
L_8dc002:
	ldb_s r0,[r14]
L_8dc004:
	mov_s r2,0x54
L_8dc006:
	st_s r0,[r13,0x4c]
L_8dc008:
	mov_s r0,r13
L_8dc00a:
	bl.d L_8e5204
L_8dc00e:
	mov_s r3,0x0
L_8dc010:
	mov_s r0,0x0
	.global L_8dc012
L_8dc012:
	b L_8c0254
L_8dc016:
	nop_s
