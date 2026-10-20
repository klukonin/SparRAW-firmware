/* l2_mgr__validate_scan @ 0x8ebbc8, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::validate_scan() failed, non-existent devid
 *   l2_mgr::validate_scan() failed, already connected
 *   l2_mgr::validate_scan() rejected, error in MAC address!!
 *   l2_mgr::validate_scan() for MID#%d blocked, in PCP/AP mode.
 *   l2_mgr::validate_scan() rejected, other scan is ongoing
 *   l2_mgr::validate_scan() rejected, is CONNECTING!!
 *   l2_mgr::validate_scan() rejected, is DISCONNECTING!!
 *   l2_mgr::validate_scan() PASS!
 * Зовут его: low_sme__wmi_scan_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, l2_mgr__is_busy_flag_set, mid__state_is_2_or_3, mid_list__any_in_state2_fw, mid_list__by_mid_fw
 * Глобалы (через gp): 0x800231, 0x80048c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__validate_scan
l2_mgr__validate_scan:
	.global L_8ebbc8
L_8ebbc8:
	push_s blink
L_8ebbca:
	bl L_8c01dc
L_8ebbce:
	sub_s sp,sp,0x4
L_8ebbd0:
	bl.d L_8cc3dc
L_8ebbd4:
	mov_s r16,r0
L_8ebbd6:
	brne_s r0,0,L_8ebbe0
L_8ebbd8:
	mov_s r1,0x100f044
L_8ebbde:
	b_s L_8ebc1a
	.global L_8ebbe0
L_8ebbe0:
	ld_s r0,[gp,0x308]
L_8ebbe2:
	breq_s r0,0,L_8ebbf6
L_8ebbe4:
	mov_s r0,0x857720
L_8ebbea:
	ldb_s r0,[r0,0x1c]
L_8ebbec:
	brge r0,0x2,L_8ebbf6
L_8ebbf0:
	ldb_s r0,[gp,0xad]
L_8ebbf2:
	brlt r0,0x2,L_8ebc04
	.global L_8ebbf6
L_8ebbf6:
	bl L_8c37ac
L_8ebbfa:
	breq_s r0,0,L_8ebc04
L_8ebbfc:
	mov_s r1,0x100f078
L_8ebc02:
	b_s L_8ebc1a
	.global L_8ebc04
L_8ebc04:
	bl.d L_8cc3dc
L_8ebc08:
	mov_s r0,r16
L_8ebc0a:
	ldb_s r0,[r0,0xa]
L_8ebc0c:
	bxor r0,r0,0x0
L_8ebc10:
	bbit1 r0,0x0,L_8ebc24
L_8ebc14:
	mov_s r1,0x100f0ac
	.global L_8ebc1a
L_8ebc1a:
	bl.d L_8dcba8
L_8ebc1e:
	mov_s r0,0x19
L_8ebc20:
	mov_s r0,0x0
L_8ebc22:
	b_s L_8ebcce
	.global L_8ebc24
L_8ebc24:
	bl.d L_8da488
L_8ebc28:
	mov_s r0,r16
L_8ebc2a:
	breq_s r0,0,L_8ebc3e
L_8ebc2c:
	mov_s r1,0x100f0e8
L_8ebc32:
	mov_s r0,0x19
L_8ebc34:
	bl.d L_8dcc10
L_8ebc38:
	mov_s r2,r16
L_8ebc3a:
	mov_s r0,0x0
L_8ebc3c:
	b_s L_8ebcce
	.global L_8ebc3e
L_8ebc3e:
	bl L_8cb7a0
L_8ebc42:
	breq_s r0,0,L_8ebc4c
L_8ebc44:
	mov_s r1,0x100f124
L_8ebc4a:
	b_s L_8ebc1a
	.global L_8ebc4c
L_8ebc4c:
	bl.d L_8c64f4
L_8ebc50:
	mov_s r0,0x1
L_8ebc52:
	breq_s r0,0,L_8ebc5c
L_8ebc54:
	mov_s r1,0x100f15c
L_8ebc5a:
	b_s L_8ebc1a
	.global L_8ebc5c
L_8ebc5c:
	bl.d L_8c64f4
L_8ebc60:
	mov_s r0,0x2
L_8ebc62:
	breq_s r0,0,L_8ebc6c
L_8ebc64:
	mov_s r1,0x100f190
L_8ebc6a:
	b_s L_8ebc1a
	.global L_8ebc6c
L_8ebc6c:
	bl.d L_8cc484
L_8ebc70:
	mov_s r13,sp
L_8ebc72:
	mov_s r1,r0
L_8ebc74:
	bl.d L_8e5dfc
L_8ebc78:
	mov_s r0,r13
L_8ebc7a:
	b_s L_8ebc98
	.global L_8ebc7c
L_8ebc7c:
	bl.d L_8df444
L_8ebc80:
	mov_s r0,r13
L_8ebc82:
	bl L_8cc3dc
L_8ebc86:
	mov.f r14,r0
L_8ebc8a:
	beq_s L_8ebcb0
	.global L_8ebc8c
L_8ebc8c:
	mov_s r0,r14
L_8ebc8e:
	mov_s r15,0x0
L_8ebc90:
	bl.d L_8cc424
L_8ebc94:
	mov_s r1,r15
L_8ebc96:
	brne_s r0,0,L_8ebcbe
	.global L_8ebc98
L_8ebc98:
	bl.d L_8cdcc4
L_8ebc9c:
	mov_s r0,r13
L_8ebc9e:
	brne_s r0,0,L_8ebc7c
L_8ebca0:
	mov_s r1,0x100f1c8
L_8ebca6:
	bl.d L_8dcba8
L_8ebcaa:
	mov_s r0,0x29
L_8ebcac:
	mov_s r0,0x1
L_8ebcae:
	b_s L_8ebcce
	.global L_8ebcb0
L_8ebcb0:
	mov_s r0,blink
L_8ebcb2:
	mov_s r1,0x16b6
L_8ebcb8:
	bl L_8c9b28
L_8ebcbc:
	b_s L_8ebc8c
	.global L_8ebcbe
L_8ebcbe:
	mov_s r1,0x100f1e8
L_8ebcc4:
	mov_s r0,0x19
L_8ebcc6:
	bl.d L_8dcc10
L_8ebcca:
	ldb_s r2,[r14,0x10]
L_8ebccc:
	mov_s r0,r15
	.global L_8ebcce
L_8ebcce:
	b.d L_8c0244
L_8ebcd2:
	add_s sp,sp,0x4
