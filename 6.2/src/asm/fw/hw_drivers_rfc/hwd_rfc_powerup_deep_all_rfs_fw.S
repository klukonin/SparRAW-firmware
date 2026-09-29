/* hwd_rfc_powerup_deep_all_rfs_fw @ 0x8d34c0, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_powerup_deep_all_rfs - rfs: 0x%x
 *   hwd_rfc_powerup_deep_all_rfs - res: %d. timeout %d
 *   hwd_rfc_powerup_deep_all_rfs - FAILED TO READ FROM RF !!!
 * Зовут его: hwm_analog_channel_switch, power_halt_seq
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit1, fw_log_emit2, hwd_abif__dvs_rfca_cmd_enable, rf_cfg__get_rf_mask_45e, rfc__read_core_result_fw, rfc__restore_txrx_sets_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_powerup_deep_all_rfs_fw
hwd_rfc_powerup_deep_all_rfs_fw:
	.global L_8d34c0
L_8d34c0:
	push_s blink
L_8d34c2:
	bl.d L_8c01dc
L_8d34c6:
	mov_s r0,0x0
L_8d34c8:
	sub_s sp,sp,0xc
L_8d34ca:
	st_s r0,[sp,0x4]
L_8d34cc:
	mov_s r15,0xa
L_8d34ce:
	mov_s r0,0x8042c8
L_8d34d4:
	bl.d L_8ccb3c
L_8d34d8:
	stb r15,[gp, 0xc0]
L_8d34dc:
	mov_s r16,r0
L_8d34de:
	mov_s r1,0x101e324
L_8d34e4:
	mov_s r0,0x21
L_8d34e6:
	bl.d L_8dcc10
L_8d34ea:
	mov_s r2,r16
L_8d34ec:
	add_s r14,sp,0x8
L_8d34ee:
	mov_s r13,r15
	.global L_8d34f0
L_8d34f0:
	mov_s r1,sp
L_8d34f2:
	bl.d L_8ce910
L_8d34f6:
	mov_s r0,0xff
L_8d34f8:
	bl L_8d3460
L_8d34fc:
	ldb_s r0,[sp,0x0]
L_8d34fe:
	bl.d L_8ce910
L_8d3502:
	mov_s r1,0x0
L_8d3504:
	mov_s r0,r14
L_8d3506:
	bl.d L_8e5dfc
L_8d350a:
	mov_s r1,r16
L_8d350c:
	b_s L_8d353a
	.global L_8d350e
L_8d350e:
	bl.d L_8df444
L_8d3512:
	mov_s r0,r14
L_8d3514:
	mov_s r1,0x0
L_8d3516:
	bset r1,r1,r0
L_8d351a:
	extb_s r0,r1
L_8d351c:
	bl.d L_8ce910
L_8d3520:
	mov_s r1,0x0
L_8d3522:
	add_s r2,sp,0x4
L_8d3524:
	mov_s r0,0x0
L_8d3526:
	bl.d L_8d3628
L_8d352a:
	mov r1,0x428
L_8d352e:
	ldb_s r0,[sp,0x0]
L_8d3530:
	bl.d L_8ce910
L_8d3534:
	mov_s r1,0x0
L_8d3536:
	ld_s r2,[sp,0x4]
L_8d3538:
	breq_s r2,0,L_8d3546
	.global L_8d353a
L_8d353a:
	bl.d L_8cdcc4
L_8d353e:
	mov_s r0,r14
L_8d3540:
	brne_s r0,0,L_8d350e
L_8d3542:
	ld_s r2,[sp,0x4]
L_8d3544:
	b_s L_8d354e
	.global L_8d3546
L_8d3546:
	stb r15,[gp, 0xc0]
L_8d354a:
	add_s r13,r13,0xa
L_8d354c:
	extb_s r13,r13
	.global L_8d354e
L_8d354e:
	cmp r13,0xc8
L_8d3552:
	bgt_s L_8d3556
L_8d3554:
	breq_s r2,0,L_8d34f0
	.global L_8d3556
L_8d3556:
	mov_s r1,0x101e350
L_8d355c:
	mov_s r0,0x21
L_8d355e:
	bl.d L_8dcc80
L_8d3562:
	mov_s r3,r13
L_8d3564:
	ld_s r0,[sp,0x4]
L_8d3566:
	brne_s r0,0,L_8d3574
L_8d3568:
	mov_s r1,0x101e384
L_8d356e:
	bl.d L_8dcba8
L_8d3572:
	mov_s r0,0x1
	.global L_8d3574
L_8d3574:
	ldb_s r0,[sp,0x0]
L_8d3576:
	bl.d L_8ce910
L_8d357a:
	mov_s r1,0x0
L_8d357c:
	stb r13,[gp, 0xc0]
L_8d3580:
	b.d L_8c0244
L_8d3584:
	add_s sp,sp,0xc
L_8d3586:
	nop_s
