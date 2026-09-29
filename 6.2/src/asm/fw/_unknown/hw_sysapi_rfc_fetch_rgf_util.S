/* hw_sysapi_rfc_fetch_rgf_util @ 0x8ce1b4, 380 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   -->> hw_sysapi_rfc_fetch_rgf_util
 *   hw_sysapi_rfc_fetch_rgf_util: connected: 0X%X
 *   hw_sysapi_rfc_fetch_rgf_util: wrong size
 *   hw_sysapi_rfc_fetch_rgf_util: not connected.
 *   -->> hw_sysapi_rfc_read
 *   <<-- hw_sysapi_rfc_read, returning with success
 *   <<-- hw_sysapi_rfc_read, read fail, returning
 *   -->> hw_sysapi_rfc_write
 * Зовут его: hw_sysapi_rfc_read_write_rgf
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit1, hwd_abif__dvs_rfca_cmd_enable, hwd_rfc_read_rgf, hwd_rfc_write_verify, rf__get_connected_mask, rfca__get_rf_mask
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_rfc_fetch_rgf_util
hw_sysapi_rfc_fetch_rgf_util:
	.global L_8ce1b4
L_8ce1b4:
	push_s blink
L_8ce1b6:
	bl L_8c01cc
L_8ce1ba:
	sub_s sp,sp,0x4
L_8ce1bc:
	mov_s r13,r0
L_8ce1be:
	add2 r17,r0,0x1d
L_8ce1c2:
	add r18,r0,0x18
L_8ce1c6:
	mov_s r1,0x101ab40
L_8ce1cc:
	bl.d L_8dcba8
L_8ce1d0:
	mov_s r0,0x25
L_8ce1d2:
	ld_s r0,[r13,0x8]
L_8ce1d4:
	mov_s r14,0x1
L_8ce1d6:
	mov_s r19,r0
L_8ce1d8:
	mov_s r15,0x0
L_8ce1da:
	b_s L_8ce1e4
	.global L_8ce1dc
L_8ce1dc:
	sub_s r1,r0,0x1
L_8ce1de:
	and_s r0,r0,r1
L_8ce1e0:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8ce1e2:
	extw_s r15,r15
	.global L_8ce1e4
L_8ce1e4:
	brne_s r0,0,L_8ce1dc
L_8ce1e6:
	mov_s r0,0x8042c8
L_8ce1ec:
	bl L_8ccb38
L_8ce1f0:
	bl.d L_8ce9c4
L_8ce1f4:
	mov_s r16,r0
L_8ce1f6:
	mov_s r20,r0
L_8ce1f8:
	mov_s r1,0x101ab64
L_8ce1fe:
	mov_s r0,0x25
L_8ce200:
	bl.d L_8dcc10
L_8ce204:
	mov_s r2,r16
L_8ce206:
	ld_s r0,[r13,0x14]
L_8ce208:
	breq_s r0,0,L_8ce224
L_8ce20a:
	ld_s r0,[r13,0xc]
L_8ce20c:
	mulu64 r0,r15
L_8ce210:
	brlo mlo,0x18,L_8ce224
L_8ce214:
	mov_s r1,0x101ab94
L_8ce21a:
	bl.d L_8dcba8
L_8ce21e:
	mov_s r0,0x5
L_8ce220:
	mov_s r14,0x3
L_8ce222:
	b_s L_8ce328
	.global L_8ce224
L_8ce224:
	and r0,r16,r19
L_8ce228:
	breq r0,r19,L_8ce23c
L_8ce22c:
	mov_s r1,0x101abc0
L_8ce232:
	bl.d L_8dcba8
L_8ce236:
	mov_s r0,0x5
L_8ce238:
	mov_s r14,0x2
L_8ce23a:
	b_s L_8ce328
	.global L_8ce23c
L_8ce23c:
	mov_s r0,sp
L_8ce23e:
	mov_s r16,r0
L_8ce240:
	bl.d L_8e5dfc
L_8ce244:
	extb r1,r19
L_8ce248:
	b_s L_8ce2f4
	.global L_8ce24a
L_8ce24a:
	mov_s r0,0x0
L_8ce24c:
	bset r0,r0,r15
L_8ce250:
	extb_s r0,r0
L_8ce252:
	bl.d L_8ce910
L_8ce256:
	mov_s r1,0x0
L_8ce258:
	ld_s r0,[r13,0x14]
L_8ce25a:
	extb_s r15,r15
L_8ce25c:
	breq_s r0,0,L_8ce2b0
L_8ce25e:
	mov_s r1,0x101abf0
L_8ce264:
	bl.d L_8dcba8
L_8ce268:
	mov_s r0,0x25
L_8ce26a:
	ld_s r0,[r13,0xc]
L_8ce26c:
	brlo r0,0x1,L_8ce298
L_8ce270:
	mov_s r14,0x0
	.global L_8ce272
L_8ce272:
	ld.as r1,[r18,r14]
L_8ce276:
	bl.d L_8d3588
L_8ce27a:
	mov_s r0,r15
L_8ce27c:
	ld_s r1,[r13,0x10]
L_8ce27e:
	add2 r12,r17,r1
L_8ce282:
	st_s r0,[r12]
L_8ce284:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ce286:
	st_s r1,[r13,0x10]
L_8ce288:
	breq r0,0xdeadbeef,L_8ce2a0
L_8ce290:
	ld_s r0,[r13,0xc]
L_8ce292:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ce294:
	brlo r14,r0,L_8ce272
	.global L_8ce298
L_8ce298:
	mov_s r1,0x101ac08
L_8ce29e:
	b_s L_8ce2ea
	.global L_8ce2a0
L_8ce2a0:
	mov_s r1,0x101ac38
	.global L_8ce2a6
L_8ce2a6:
	bl.d L_8dcba8
L_8ce2aa:
	mov_s r0,0x25
L_8ce2ac:
	mov_s r14,0x0
L_8ce2ae:
	b_s L_8ce2f2
	.global L_8ce2b0
L_8ce2b0:
	mov_s r1,0x101ac68
L_8ce2b6:
	bl.d L_8dcba8
L_8ce2ba:
	mov_s r0,0x25
L_8ce2bc:
	mov_s r14,0x0
L_8ce2be:
	b_s L_8ce2c2
	.global L_8ce2c0
L_8ce2c0:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
	.global L_8ce2c2
L_8ce2c2:
	ld_s r0,[r13,0xc]
L_8ce2c4:
	asl_s r0,r0
L_8ce2c6:
	brhs r14,r0,L_8ce2e4
L_8ce2ca:
	add2 r2,r13,r14
L_8ce2ce:
	ld_s r1,[r2,0x18]
L_8ce2d0:
	mov_s r0,r15
L_8ce2d2:
	ld_s r2,[r2,0x1c]
L_8ce2d4:
	bl.d L_8d4468
L_8ce2d8:
	mov_s r3,0x6
L_8ce2da:
	brne_s r0,0,L_8ce2c0
L_8ce2dc:
	mov_s r1,0x101ac84
L_8ce2e2:
	b_s L_8ce2a6
	.global L_8ce2e4
L_8ce2e4:
	mov_s r1,0x101acb4
	.global L_8ce2ea
L_8ce2ea:
	bl.d L_8dcba8
L_8ce2ee:
	mov_s r0,0x25
L_8ce2f0:
	mov_s r14,0x1
	.global L_8ce2f2
L_8ce2f2:
	breq_s r14,0,L_8ce304
	.global L_8ce2f4
L_8ce2f4:
	bl.d L_8df444
L_8ce2f8:
	mov_s r0,r16
L_8ce2fa:
	cmp r0,-0x1
L_8ce2fe:
	mov_s r15,r0
L_8ce300:
	bne_s L_8ce24a
L_8ce302:
	b_s L_8ce312
	.global L_8ce304
L_8ce304:
	mov_s r1,0x101ace8
L_8ce30a:
	mov_s r0,0x5
L_8ce30c:
	bl.d L_8dcc10
L_8ce310:
	mov_s r2,0x0
	.global L_8ce312
L_8ce312:
	mov_s r0,r20
L_8ce314:
	bl.d L_8ce910
L_8ce318:
	mov_s r1,0x0
L_8ce31a:
	mov_s r1,0x101ad18
L_8ce320:
	mov_s r0,0x25
L_8ce322:
	bl.d L_8dcc10
L_8ce326:
	mov_s r2,r14
	.global L_8ce328
L_8ce328:
	mov_s r0,r14
L_8ce32a:
	b.d L_8c0224
L_8ce32e:
	add_s sp,sp,0x4
