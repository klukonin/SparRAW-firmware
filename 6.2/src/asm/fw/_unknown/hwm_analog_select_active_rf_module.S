/* hwm_analog_select_active_rf_module @ 0x8d7584, 360 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwm_analog_select_active_rf_module()::  requested to enable RFs(rfc_enable_vec=0x%8x) aren't connected (rfc_connected_indx_vec=0x%8x)
 *   hwm_analog_select_active_rf_module()::  requested to enable RFs(rfc_enable_vec=0x%8x) were already enabled(current_rfc_enabled=0x%8x)
 *   hwm_analog_select_active_rf_module()::  rfc_enable_vec=0x%8x, rfc_connected_indx_vec=0x%8x, current_rfc_enabled=0x%8x
 *   hwm_analog_select_active_rf_module(): Skipping configuration of RFC module for non-attached XIF port #%d
 *   hwm_analog_select_active_rf_module(): Deactivated RF module %d, new_rfc_enabled=0x%8x
 *   hwm_analog_select_active_rf_module(): Activated RF module %d, new_rfc_enabled=0x%8x
 *   hwm_analog_select_active_rf_module(): Completed. new_rfc_enabled=0x%8x, attached_xif_ports_vec=0x%8x, rfc_enable_vec=0x%8x
 *   hwm_analog_select_active_rf_module(): enable_cnt=%d, disable_cnt=%d
 * Зовут его: rfc__collect_rx_crc_stats, rfc__probe_modules
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, field_set_0x00__8e6f2c, fw_log_emit1, fw_log_emit2, fw_log_emit3, hwd__setup_pair, hwd_abif__dvs_if_splitter_enable, hwd_abif__dvs_lo_splitter_enable, hwd_abif__dvs_rf_activate, hwd_abif__dvs_rfca_cmd_enable, hwf_rf_config
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_analog_select_active_rf_module
hwm_analog_select_active_rf_module:
	.global L_8d7584
L_8d7584:
	push_s blink
L_8d7586:
	bl L_8c01c8
L_8d758a:
	mov_s r19,r0
L_8d758c:
	mov_s r0,0x8042c8
L_8d7592:
	bl.d L_8ccb38
L_8d7596:
	mov_s r16,r0
L_8d7598:
	tst r0,r19
L_8d759c:
	mov r17,0x0
L_8d75a0:
	mov_s r21,r0
L_8d75a2:
	bne_s L_8d75b6
L_8d75a4:
	mov_s r1,0x101d0a4
L_8d75aa:
	mov_s r0,0x0
L_8d75ac:
	mov_s r2,r19
L_8d75ae:
	bl.d L_8dcc80
L_8d75b2:
	mov_s r3,r21
L_8d75b4:
	b_s L_8d76e6
	.global L_8d75b6
L_8d75b6:
	bl.d L_8ccb3c
L_8d75ba:
	mov_s r0,r16
L_8d75bc:
	mov_s r20,r0
L_8d75be:
	brne r0,r19,L_8d75d4
L_8d75c2:
	mov_s r1,0x101d12c
L_8d75c8:
	mov_s r0,0x20
L_8d75ca:
	mov_s r2,r19
L_8d75cc:
	bl.d L_8dcc80
L_8d75d0:
	mov_s r3,r20
L_8d75d2:
	b_s L_8d76e6
	.global L_8d75d4
L_8d75d4:
	mov_s r1,0x101d1b4
L_8d75da:
	mov_s r0,0x20
L_8d75dc:
	mov_s r2,r19
L_8d75de:
	mov_s r3,r21
L_8d75e0:
	mov r4,r20
L_8d75e4:
	bl.d L_8dcd00
L_8d75e8:
	mov_s r14,r20
L_8d75ea:
	mov_s r15,r17
L_8d75ec:
	mov r18,r17
L_8d75f0:
	b_s L_8d7606
	.global L_8d75f2
L_8d75f2:
	breq_s r1,0,L_8d7602
L_8d75f4:
	mov_s r1,0x101d22c
L_8d75fa:
	mov_s r0,0x20
L_8d75fc:
	bl.d L_8dcc10
L_8d7600:
	mov_s r2,r15
	.global L_8d7602
L_8d7602:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d7604:
	extb_s r15,r15
	.global L_8d7606
L_8d7606:
	brge r15,0x8,L_8d76a4
L_8d760a:
	mov_s r13,0x0
L_8d760c:
	bset r13,r13,r15
L_8d7610:
	extb_s r13,r13
L_8d7612:
	tst r21,r13
L_8d7616:
	and r1,r13,r19
L_8d761a:
	beq_s L_8d75f2
L_8d761c:
	and.f r0,r20,r13
L_8d7620:
	beq_s L_8d7660
L_8d7622:
	brne_s r1,0,L_8d7660
L_8d7624:
	mov_s r0,r13
L_8d7626:
	bl.d L_8ce910
L_8d762a:
	mov_s r1,0x0
L_8d762c:
	bl.d L_8d33f8
L_8d7630:
	mov_s r0,0x0
L_8d7632:
	bic_s r14,r14,r13
L_8d7634:
	extb_s r14,r14
L_8d7636:
	bl.d L_8ce6b8
L_8d763a:
	mov_s r0,r14
L_8d763c:
	bl.d L_8ce794
L_8d7640:
	mov_s r0,r14
L_8d7642:
	mov_s r0,r14
L_8d7644:
	bl.d L_8ce910
L_8d7648:
	mov_s r1,0x0
L_8d764a:
	bl.d L_8ce838
L_8d764e:
	mov_s r0,r14
L_8d7650:
	add r18,r18,0x1
L_8d7654:
	mov_s r1,0x101d298
L_8d765a:
	extb r18,r18
L_8d765e:
	b_s L_8d7698
	.global L_8d7660
L_8d7660:
	brne_s r0,0,L_8d7602
L_8d7662:
	breq_s r1,0,L_8d7602
L_8d7664:
	or_s r14,r14,r13
L_8d7666:
	extb_s r14,r14
L_8d7668:
	bl.d L_8ce6b8
L_8d766c:
	mov_s r0,r14
L_8d766e:
	bl.d L_8ce794
L_8d7672:
	mov_s r0,r14
L_8d7674:
	bl.d L_8ce838
L_8d7678:
	mov_s r0,r14
L_8d767a:
	mov_s r0,r13
L_8d767c:
	bl.d L_8ce910
L_8d7680:
	mov_s r1,0x0
L_8d7682:
	bl.d L_8d3460
L_8d7686:
	add r17,r17,0x1
L_8d768a:
	bl.d L_8d414c
L_8d768e:
	extb r17,r17
L_8d7692:
	mov_s r1,0x101d2f0
	.global L_8d7698
L_8d7698:
	mov_s r0,0x20
L_8d769a:
	mov_s r2,r15
L_8d769c:
	bl.d L_8dcc80
L_8d76a0:
	mov_s r3,r14
L_8d76a2:
	b_s L_8d7602
	.global L_8d76a4
L_8d76a4:
	mov_s r0,r16
L_8d76a6:
	bl.d L_8e6f2c
L_8d76aa:
	mov_s r1,r14
L_8d76ac:
	mov_s r0,r16
L_8d76ae:
	bl.d L_8e6f24
L_8d76b2:
	mov_s r1,r14
L_8d76b4:
	mov_s r1,0x101d344
L_8d76ba:
	mov_s r0,0x20
L_8d76bc:
	mov_s r2,r14
L_8d76be:
	mov_s r3,r21
L_8d76c0:
	bl.d L_8dcd00
L_8d76c4:
	mov r4,r19
L_8d76c8:
	mov_s r1,0x101d3c0
L_8d76ce:
	mov_s r0,0x20
L_8d76d0:
	mov_s r2,r17
L_8d76d2:
	bl.d L_8dcc80
L_8d76d6:
	mov_s r3,r18
L_8d76d8:
	brlt r17,0x1,L_8d76e6
L_8d76dc:
	bl.d L_8cc13c
L_8d76e0:
	mov_s r0,r16
L_8d76e2:
	bl L_8d6f30
	.global L_8d76e6
L_8d76e6:
	b L_8c021c
L_8d76ea:
	nop_s
