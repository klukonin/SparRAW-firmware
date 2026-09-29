/* hw_sysapi_rfc_read_write_rgf @ 0x8ce330, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    -->> hw_sysapi_rfc_read_write_rgf, rf mask 0x%X
 *   hw_sysapi_rfc_read_write_rgf: radio lock failure
 *   hw_sysapi_rfc_read_write_rgf: radio request handle is 0x%X
 *   hw_sysapi_rfc_read_write_rgf: previously scheduled read/write still didn't occur.
 *   -->> hw_sysapi_rfc_read_write_rgf_cb
 *   <<-- hw_sysapi_rfc_read_write_rgf_cb
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r15_to_r13_ret, __st_r14_to_r13, __st_r15_to_r13, fw_log_emit0, fw_log_emit1, hw_sysapi_rfc_fetch_rgf_util, memcpy_fw, radio_mgr__call_method_10, radio_mgr__request, rf_cfg__get_rf_mask_45e, wmi_evt__send_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_rfc_read_write_rgf
hw_sysapi_rfc_read_write_rgf:
	.global L_8ce330
L_8ce330:
	push_s blink
L_8ce332:
	bl L_8c01e4
L_8ce336:
	mov_s r14,r0
L_8ce338:
	mov_s r0,0x8042c8
L_8ce33e:
	bl L_8ccb3c
L_8ce342:
	mov_s r1,0x101a5f8
L_8ce348:
	mov_s r0,0x20
L_8ce34a:
	bl.d L_8dcc10
L_8ce34e:
	ld_s r2,[r14,0x8]
L_8ce350:
	mov_s r13,0x8004f8
L_8ce356:
	ld_s r0,[r13]
L_8ce358:
	brne_s r0,0,L_8ce394
L_8ce35a:
	mov_s r0,0xe3a8
L_8ce360:
	mov_s r1,r14
L_8ce362:
	mov_s r2,0x0
L_8ce364:
	mov_s r3,0xffff
L_8ce36a:
	bl.d L_8dcaf4
L_8ce36e:
	mov_s r4,r2
L_8ce370:
	mov.f r2,r0
L_8ce374:
	st_s r0,[r13]
L_8ce376:
	bne_s L_8ce382
L_8ce378:
	mov_s r1,0x101a62c
L_8ce37e:
	mov_s r0,0x5
L_8ce380:
	b_s L_8ce39c
	.global L_8ce382
L_8ce382:
	mov_s r13,0x5
L_8ce384:
	mov_s r1,0x101a660
L_8ce38a:
	bl.d L_8dcc10
L_8ce38e:
	mov_s r0,0x25
L_8ce390:
	mov_s r0,r13
L_8ce392:
	b_s L_8ce3a2
	.global L_8ce394
L_8ce394:
	mov_s r1,0x101a69c
L_8ce39a:
	mov_s r0,0x15
	.global L_8ce39c
L_8ce39c:
	bl L_8dcba8
L_8ce3a0:
	mov_s r0,0x4
	.global L_8ce3a2
L_8ce3a2:
	b L_8c0254
L_8ce3a6:
	nop_s
L_8ce3a8:
	push_s blink
L_8ce3aa:
	bl L_8c01e0
L_8ce3ae:
	mov_s r15,r0
L_8ce3b0:
	mov_s r13,r1
L_8ce3b2:
	mov_s r1,0x101ad48
L_8ce3b8:
	bl.d L_8dcba8
L_8ce3bc:
	mov_s r0,0x25
L_8ce3be:
	ld_s r14,[r13,0x4]
L_8ce3c0:
	bl.d L_8ce1b4
L_8ce3c4:
	mov_s r0,r13
L_8ce3c6:
	st_s r0,[r14,0x4]
L_8ce3c8:
	ld_s r0,[r13,0x14]
L_8ce3ca:
	mov_s r2,0x8
L_8ce3cc:
	breq_s r0,0,L_8ce3de
L_8ce3ce:
	add r0,r14,0x8
L_8ce3d2:
	add2 r1,r13,0x1d
L_8ce3d6:
	bl.d L_8c0380
L_8ce3da:
	mov_s r2,0x5c
L_8ce3dc:
	mov_s r2,0x64
	.global L_8ce3de
L_8ce3de:
	ld_s r0,[r13]
L_8ce3e0:
	extw_s r2,r2
L_8ce3e2:
	bl.d L_8eae78
L_8ce3e6:
	mov_s r1,r14
L_8ce3e8:
	bl.d L_8ea800
L_8ce3ec:
	mov_s r0,r15
L_8ce3ee:
	mov_s r1,0x0
L_8ce3f0:
	mov_s r0,0x8004f8
L_8ce3f6:
	st_s r1,[r0]
L_8ce3f8:
	mov_s r1,0x101ad70
L_8ce3fe:
	bl.d L_8dcba8
L_8ce402:
	mov_s r0,0x25
L_8ce404:
	b L_8c024c
