/* rfc_read_sector_params @ 0x8d3678, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, wmi_handler_get_rf_sector_params__on_radio_locked_cb
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc_read_sector_params
rfc_read_sector_params:
	.global L_8d3678
L_8d3678:
	push_s blink
L_8d367a:
	bl L_8c01cc
L_8d367e:
	mov_s r20,r0
L_8d3680:
	mov_s r14,r3
L_8d3682:
	mov r18,r4
L_8d3686:
	mov r17,r5
L_8d368a:
	mov r16,r6
L_8d368e:
	mov r19,r7
L_8d3692:
	ld_s r15,[sp,0x24]
L_8d3694:
	asl_s r13,r1,0x6
L_8d3696:
	add1_s r13,r13,r13
L_8d3698:
	breq r2,0x0,L_8d371a
L_8d369c:
	add r0,r13,0x8000
L_8d36a4:
	lsr_s r0,r0,0x3
L_8d36a6:
	bic r1,r0,0x3
L_8d36aa:
	bl.d L_8d3588
L_8d36ae:
	mov_s r0,r20
L_8d36b0:
	st_s r0,[r14]
L_8d36b2:
	add r0,r13,0x8020
L_8d36ba:
	lsr_s r0,r0,0x3
L_8d36bc:
	bic r1,r0,0x3
L_8d36c0:
	bl.d L_8d3588
L_8d36c4:
	mov_s r0,r20
L_8d36c6:
	st r0,[r18]
L_8d36ca:
	add r0,r13,0x8060
L_8d36d2:
	lsr_s r0,r0,0x3
L_8d36d4:
	bic r1,r0,0x3
L_8d36d8:
	bl.d L_8d3588
L_8d36dc:
	mov_s r0,r20
L_8d36de:
	st r0,[r17]
L_8d36e2:
	add r0,r13,0x8040
L_8d36ea:
	lsr_s r0,r0,0x3
L_8d36ec:
	bic r1,r0,0x3
L_8d36f0:
	bl.d L_8d3588
L_8d36f4:
	mov_s r0,r20
L_8d36f6:
	st r0,[r16]
L_8d36fa:
	add r0,r13,0x80a0
L_8d3702:
	lsr_s r0,r0,0x3
L_8d3704:
	bic r1,r0,0x3
L_8d3708:
	bl.d L_8d3588
L_8d370c:
	mov_s r0,r20
L_8d370e:
	add_s r13,r13,0x8080
L_8d3714:
	st r0,[r19]
L_8d3718:
	b_s L_8d3796
	.global L_8d371a
L_8d371a:
	add r0,r13,0x10000
L_8d3722:
	lsr_s r0,r0,0x3
L_8d3724:
	bic r1,r0,0x3
L_8d3728:
	bl.d L_8d3588
L_8d372c:
	mov_s r0,r20
L_8d372e:
	st_s r0,[r14]
L_8d3730:
	add r0,r13,0x10020
L_8d3738:
	lsr_s r0,r0,0x3
L_8d373a:
	bic r1,r0,0x3
L_8d373e:
	bl.d L_8d3588
L_8d3742:
	mov_s r0,r20
L_8d3744:
	st r0,[r18]
L_8d3748:
	add r0,r13,0x10060
L_8d3750:
	lsr_s r0,r0,0x3
L_8d3752:
	bic r1,r0,0x3
L_8d3756:
	bl.d L_8d3588
L_8d375a:
	mov_s r0,r20
L_8d375c:
	st r0,[r17]
L_8d3760:
	add r0,r13,0x10040
L_8d3768:
	lsr_s r0,r0,0x3
L_8d376a:
	bic r1,r0,0x3
L_8d376e:
	bl.d L_8d3588
L_8d3772:
	mov_s r0,r20
L_8d3774:
	st r0,[r16]
L_8d3778:
	add r0,r13,0x100a0
L_8d3780:
	lsr_s r0,r0,0x3
L_8d3782:
	bic r1,r0,0x3
L_8d3786:
	bl.d L_8d3588
L_8d378a:
	mov_s r0,r20
L_8d378c:
	st r0,[r19]
L_8d3790:
	add_s r13,r13,0x10080
	.global L_8d3796
L_8d3796:
	lsr_s r13,r13,0x3
L_8d3798:
	bic r1,r13,0x3
L_8d379c:
	bl.d L_8d3588
L_8d37a0:
	mov_s r0,r20
L_8d37a2:
	b.d L_8c0224
L_8d37a6:
	st_s r0,[r15]
