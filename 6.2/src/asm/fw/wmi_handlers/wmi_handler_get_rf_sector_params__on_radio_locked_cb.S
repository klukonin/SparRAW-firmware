/* wmi_handler_get_rf_sector_params__on_radio_locked_cb @ 0x8cd2dc, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::on_radio_locked_cb(): Reading RF Sector: rfc_idx=%d, sector_idx=%d, sector_type=%d,
 *   [NNL] psh_hi=0x%X, psh_lo=0x%X, etype0=0x%X,
 *   [NNL] etype1=0x%X, etype2=0x%X, dtype_swch_off=0x%X,
 * Зовут его: dma__set_881b24_bit1
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit3, fw_sysassert_fatal, hwd_abif__dvs_rfca_cmd_enable, mac_read_tsf64, mem_pool__alloc_locked, memcpy_fw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_handler_get_rf_sector_params__on_radio_locked_cb
wmi_handler_get_rf_sector_params__on_radio_locked_cb:
	.global L_8cd2dc
L_8cd2dc:
	push_s blink
L_8cd2de:
	bl L_8c01d4
L_8cd2e2:
	sub_s sp,sp,0x24
L_8cd2e4:
	mov_s r14,r0
L_8cd2e6:
	bl.d L_8c33d0
L_8cd2ea:
	ld_s r0,[r0,0x4]
L_8cd2ec:
	mov_s r15,r0
L_8cd2ee:
	bl.d L_8c1cd8
L_8cd2f2:
	mov_s r1,0xd0
L_8cd2f4:
	mov_s r0,0x0
L_8cd2f6:
	mov_s r17,r0
L_8cd2f8:
	stb_s r0,[sp,0x4]
L_8cd2fa:
	mov_s r0,0x8042c8
L_8cd300:
	bl.d L_8ccb3c
L_8cd304:
	add r18,sp,0x4
L_8cd308:
	mov_s r2,r0
L_8cd30a:
	ldb_s r1,[r14,0x3]
L_8cd30c:
	add_s r0,sp,0x8
L_8cd30e:
	mov_s r16,r0
L_8cd310:
	bl.d L_8e5dfc
L_8cd314:
	and_s r1,r1,r2
L_8cd316:
	b_s L_8cd3c4
	.global L_8cd318
L_8cd318:
	bl.d L_8df444
L_8cd31c:
	mov_s r0,r16
L_8cd31e:
	mov_s r13,r0
L_8cd320:
	cmp_s r0,0x8
L_8cd322:
	mov.cc r0,blink
L_8cd326:
	mov.cc r1,0x146e
L_8cd32e:
	bl.cc L_8c9b28
L_8cd332:
	mov_s r0,0x0
L_8cd334:
	bset r0,r0,r13
L_8cd338:
	extb_s r0,r0
L_8cd33a:
	bl.d L_8ce910
L_8cd33e:
	mov_s r1,r18
L_8cd340:
	mov r18,0x0
L_8cd344:
	add_s r0,sp,0xc
L_8cd346:
	mov_s r1,0x8021b0
L_8cd34c:
	bl.d L_8c0380
L_8cd350:
	mov_s r2,0x18
L_8cd352:
	ldb_s r1,[r14,0x2]
L_8cd354:
	extb_s r0,r13
L_8cd356:
	cmp_s r1,0x1
L_8cd358:
	mov_s r2,0x1
L_8cd35a:
	sub_s.ne r2,r2,r2
L_8cd35c:
	add_s r3,sp,0xc
L_8cd35e:
	add r4,sp,0x10
L_8cd362:
	add r5,sp,0x14
L_8cd366:
	add r6,sp,0x18
L_8cd36a:
	add r7,sp,0x1c
L_8cd36e:
	add_s r1,sp,0x20
L_8cd370:
	st_s r1,[sp,0x0]
L_8cd372:
	bl.d L_8d3678
L_8cd376:
	ldw_s r1,[r14]
L_8cd378:
	asl_s r0,r13,0x3
L_8cd37a:
	add1_s r0,r0,r0
L_8cd37c:
	add_s r0,r0,r15
L_8cd37e:
	add_s r0,r0,0x10
L_8cd380:
	add_s r1,sp,0xc
L_8cd382:
	bl.d L_8c0380
L_8cd386:
	mov_s r2,0x18
L_8cd388:
	mov_s r1,0x1008080
L_8cd38e:
	ldb r4,[r14, 0x2]
L_8cd392:
	mov_s r0,0x20
L_8cd394:
	mov_s r2,r13
L_8cd396:
	bl.d L_8dcd00
L_8cd39a:
	ldw_s r3,[r14]
L_8cd39c:
	mov_s r1,0x10080f8
L_8cd3a2:
	ld r4,[sp, 0x14]
L_8cd3a6:
	mov_s r0,0x20
L_8cd3a8:
	ld_s r2,[sp,0xc]
L_8cd3aa:
	bl.d L_8dcd00
L_8cd3ae:
	ld_s r3,[sp,0x10]
L_8cd3b0:
	mov_s r1,0x1008128
L_8cd3b6:
	ld r4,[sp, 0x20]
L_8cd3ba:
	mov_s r0,0x20
L_8cd3bc:
	ld_s r2,[sp,0x18]
L_8cd3be:
	bl.d L_8dcd00
L_8cd3c2:
	ld_s r3,[sp,0x1c]
	.global L_8cd3c4
L_8cd3c4:
	bl.d L_8cdcc4
L_8cd3c8:
	mov_s r0,r16
L_8cd3ca:
	brne r0,0x0,L_8cd318
L_8cd3ce:
	ldb_s r0,[sp,0x4]
L_8cd3d0:
	bl.d L_8ce910
L_8cd3d4:
	mov_s r1,0x0
L_8cd3d6:
	add r1,r15,0x8
L_8cd3da:
	mov_s r0,0x0
L_8cd3dc:
	bl.d L_8e9900
L_8cd3e0:
	mov_s r2,0x0
L_8cd3e2:
	stb r17,[r15]
L_8cd3e6:
	st r17,[sp]
L_8cd3ea:
	ld_s r0,[r14,0x4]
L_8cd3ec:
	mov_s r1,r15
L_8cd3ee:
	mov_s r2,0x0
L_8cd3f0:
	mov_s r3,0xcd
L_8cd3f2:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8cd3f4:
	mov r4,0xd0
L_8cd3f8:
	mov r5,0x0
L_8cd3fc:
	mov r6,0x0
L_8cd400:
	bl.d L_8e4fc4
L_8cd404:
	mov r7,0x0
L_8cd408:
	b.d L_8c0234
L_8cd40c:
	add_s sp,sp,0x24
L_8cd40e:
	nop_s
