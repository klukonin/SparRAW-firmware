/* return_field_type @ 0x8dc14c, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   return_field_type:%d, sta_id:%d
 *   RESET_KEYS event handle Sta id %d
 *   *** SET_GLOBAL_KEY EVENT RECEIVED FROM UCODE ***
 *   *** SET_DEST_STA_RF_PARAMS EVENT RECEIVED FROM UCODE ***
 *   *** SET_DEST_STA_FEATURES_VERSION_TRACKING EVENT RECEIVED FROM UCODE ***
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal, install_key_handle, l2mgr__apply_key_to_prings, vring__enable_first_pending_gtk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global return_field_type
return_field_type:
	.global L_8dc14c
L_8dc14c:
	push_s blink
L_8dc14e:
	bl L_8c01e4
L_8dc152:
	mov_s r14,r0
L_8dc154:
	ld_s r2,[r14,0x4]
L_8dc156:
	mov_s r1,0x10040ac
L_8dc15c:
	mov_s r0,0x20
L_8dc15e:
	bl.d L_8dcc80
L_8dc162:
	ld_s r3,[r14]
L_8dc164:
	ld_s r0,[r14,0x4]
L_8dc166:
	mov_s r13,0x0
L_8dc168:
	cmp_s r0,0x4
L_8dc16a:
	cmp.ne r0,0x8
L_8dc16e:
	cmp.ne r0,0x10
L_8dc172:
	beq_s L_8dc180
L_8dc174:
	bl.d L_8cbffc
L_8dc178:
	ld_s r0,[r14]
L_8dc17a:
	mov.f r13,r0
L_8dc17e:
	beq_s L_8dc196
	.global L_8dc180
L_8dc180:
	ld_s r1,[r14,0x4]
L_8dc182:
	brhs r1,0x11,L_8dc1e8
L_8dc186:
	ldb.x r1,[0x801f2c,r1]
L_8dc18e:
	add r0,pcl,0xa
L_8dc192:
	add1_s r0,r0,r1
L_8dc194:
	j_s [r0]
	.global L_8dc196
L_8dc196:
	mov_s r0,blink
L_8dc198:
	mov_s r1,0x4b
L_8dc19a:
	bl.d L_8c9b28
L_8dc19e:
	bset_s r1,r1,0xc
L_8dc1a0:
	b_s L_8dc180
L_8dc1a2:
	bl.d L_8f5a5c
L_8dc1a6:
	mov_s r0,r13
L_8dc1a8:
	b_s L_8dc1f2
L_8dc1aa:
	mov_s r1,0x10040cc
L_8dc1b0:
	mov_s r0,0x20
L_8dc1b2:
	bl.d L_8dcc10
L_8dc1b6:
	ld_s r2,[r14]
L_8dc1b8:
	bl.d L_8fa7f8
L_8dc1bc:
	mov_s r0,r13
L_8dc1be:
	b_s L_8dc1f2
L_8dc1c0:
	mov_s r1,0x10040f0
L_8dc1c6:
	bl.d L_8dcba8
L_8dc1ca:
	mov_s r0,0x25
L_8dc1cc:
	bl L_8cd0a4
L_8dc1d0:
	b_s L_8dc1f2
L_8dc1d2:
	mov_s r1,0x1004124
	.global L_8dc1d8
L_8dc1d8:
	bl.d L_8dcba8
L_8dc1dc:
	mov_s r0,0x25
L_8dc1de:
	b_s L_8dc1f2
L_8dc1e0:
	mov_s r1,0x1004160
L_8dc1e6:
	b_s L_8dc1d8
	.global L_8dc1e8
L_8dc1e8:
	mov_s r0,blink
L_8dc1ea:
	mov_s r1,0x4c
L_8dc1ec:
	bl.d L_8c9b28
L_8dc1f0:
	bset_s r1,r1,0xc
	.global L_8dc1f2
L_8dc1f2:
	b L_8c0254
L_8dc1f6:
	nop_s
