/* hwd_phy__set_mode @ 0x8cf588, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_lo_leakage_substep, calib_lo_power_step, calib_mngr_step_a, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, hwf_calib__prepare_hw, hwf_calib__release_hw, hwm__apply_channel_config
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 * Глобалы (через gp): 0x800218, 0x800219, 0x80021a, 0x80021b
 */
	.section .text.hwd_phy__set_mode,"ax",@progbits
	.global hwd_phy__set_mode
hwd_phy__set_mode:
	.global L_8cf588
L_8cf588:
	push_s blink
L_8cf58a:
	bl L_8c02c4
L_8cf58e:
	brne r0,0x1,L_8cf5b2
L_8cf592:
	mov_s r1,0x883180
L_8cf598:
	ld_s r0,[r1,0x40]
L_8cf59a:
	bic r0,r0,0x3f
L_8cf59e:
	or r0,r0,0x21
L_8cf5a2:
	st_s r0,[r1,0x40]
L_8cf5a4:
	ld_s r0,[r1,0x44]
L_8cf5a6:
	bic r0,r0,0x3f
L_8cf5aa:
	or r0,r0,0x21
L_8cf5ae:
	st_s r0,[r1,0x44]
L_8cf5b0:
	b_s L_8cf60e
	.global L_8cf5b2
L_8cf5b2:
	ldb_s r0,[gp,0xa8]
L_8cf5b4:
	bic.f r0,r0,0x3f
L_8cf5b8:
	bne_s L_8cf612
	.global L_8cf5ba
L_8cf5ba:
	mov_s r13,0x883180
L_8cf5c0:
	ld_s r0,[r13,0x40]
L_8cf5c2:
	bic r1,r0,0x3f
L_8cf5c6:
	ldb_s r0,[gp,0xa8]
L_8cf5c8:
	or_s r0,r0,r1
L_8cf5ca:
	st_s r0,[r13,0x40]
L_8cf5cc:
	ldb_s r0,[gp,0xaa]
L_8cf5ce:
	bic.f r0,r0,0x3f
L_8cf5d2:
	bne_s L_8cf626
	.global L_8cf5d4
L_8cf5d4:
	ld_s r0,[r13,0x44]
L_8cf5d6:
	bic r1,r0,0x3f
L_8cf5da:
	ldb_s r0,[gp,0xaa]
L_8cf5dc:
	or_s r0,r0,r1
L_8cf5de:
	st_s r0,[r13,0x44]
L_8cf5e0:
	ldb_s r0,[gp,0xa9]
L_8cf5e2:
	bic.f r0,r0,0x3f
L_8cf5e6:
	bne_s L_8cf63a
	.global L_8cf5e8
L_8cf5e8:
	ld_s r1,[r13,0x40]
L_8cf5ea:
	mov_s r14,0xfffff03f
L_8cf5f0:
	ldb_s r0,[gp,0xa9]
L_8cf5f2:
	and_s r1,r1,r14
L_8cf5f4:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8cf5f6:
	or_s r0,r0,r1
L_8cf5f8:
	st_s r0,[r13,0x40]
L_8cf5fa:
	ldb_s r0,[gp,0xab]
L_8cf5fc:
	bic.f r0,r0,0x3f
L_8cf600:
	bne_s L_8cf64e
	.global L_8cf602
L_8cf602:
	ld_s r1,[r13,0x44]
L_8cf604:
	ldb_s r0,[gp,0xab]
L_8cf606:
	and_s r1,r1,r14
L_8cf608:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8cf60a:
	or_s r0,r0,r1
L_8cf60c:
	st_s r0,[r13,0x44]
	.global L_8cf60e
L_8cf60e:
	b L_8c0334
	.global L_8cf612
L_8cf612:
	mov_s r0,blink
L_8cf614:
	mov_s r2,0x1018690
L_8cf61a:
	mov_s r1,0xac
L_8cf61c:
	bl.d L_8c82c0
L_8cf620:
	mov r3,0x204
L_8cf624:
	b_s L_8cf5ba
	.global L_8cf626
L_8cf626:
	mov_s r0,blink
L_8cf628:
	mov_s r2,0x1018690
L_8cf62e:
	mov_s r1,0xac
L_8cf630:
	bl.d L_8c82c0
L_8cf634:
	mov r3,0x205
L_8cf638:
	b_s L_8cf5d4
	.global L_8cf63a
L_8cf63a:
	mov_s r0,blink
L_8cf63c:
	mov_s r2,0x1018690
L_8cf642:
	mov_s r1,0xac
L_8cf644:
	bl.d L_8c82c0
L_8cf648:
	mov r3,0x206
L_8cf64c:
	b_s L_8cf5e8
	.global L_8cf64e
L_8cf64e:
	mov_s r0,blink
L_8cf650:
	mov_s r2,0x1018690
L_8cf656:
	mov_s r1,0xac
L_8cf658:
	bl.d L_8c82c0
L_8cf65c:
	mov r3,0x207
L_8cf660:
	b_s L_8cf602
L_8cf662:
	nop_s
