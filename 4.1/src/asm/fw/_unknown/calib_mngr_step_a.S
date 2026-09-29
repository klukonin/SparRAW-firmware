/* calib_mngr_step_a @ 0x8d3614, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_sar__vt18, hwf_calib_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, hwd_abif__rgf_88a200_8cbf84, hwd_abif__rgf_88a200_8cc674, hwd_abif__rgf_88a200_8cca94, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_88ae60_flags, hwd_abif__set_88af10, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_883000_8cfcdc, hwd_phy__rgf_883000_8cfd48, hwd_phy__rgf_884000
 */
	.section .text.calib_mngr_step_a,"ax",@progbits
	.global calib_mngr_step_a
calib_mngr_step_a:
	.global L_8d3614
L_8d3614:
	push_s blink
L_8d3616:
	bl L_8c02bc
L_8d361a:
	mov_s r13,r1
L_8d361c:
	mov_s r15,r2
L_8d361e:
	mov_s r14,r3
L_8d3620:
	cmp_s r0,0x0
L_8d3622:
	mov r16,r4
L_8d3626:
	bl.ne L_8d3870
L_8d362a:
	breq_s r13,0,L_8d3668
L_8d362c:
	bl.d L_8cb8d8
L_8d3630:
	mov_s r0,0x0
L_8d3632:
	bl.d L_8d4c0c
L_8d3636:
	mov_s r0,0x0
L_8d3638:
	bl.d L_8d04b0
L_8d363c:
	mov_s r0,0x0
L_8d363e:
	bl.d L_8cbd8c
L_8d3642:
	mov_s r0,0x7
L_8d3644:
	bl.d L_8d4c0c
L_8d3648:
	mov_s r0,0x1
L_8d364a:
	bl.d L_8cca94
L_8d364e:
	mov_s r0,0x1
L_8d3650:
	bl L_8cca78
L_8d3654:
	bl L_8cbf84
L_8d3658:
	mov_s r0,0x0
L_8d365a:
	bl.d L_8cc674
L_8d365e:
	mov_s r1,0x3f
L_8d3660:
	mov_s r0,0x1
L_8d3662:
	bl.d L_8cc674
L_8d3666:
	mov_s r1,0x3f
	.global L_8d3668
L_8d3668:
	breq_s r15,0,L_8d3696
L_8d366a:
	bl.d L_8cf4c8
L_8d366e:
	mov_s r0,0x0
L_8d3670:
	bl.d L_8cf4fc
L_8d3674:
	mov_s r0,0x0
L_8d3676:
	bl L_8cfcdc
L_8d367a:
	bl L_8cfd48
L_8d367e:
	bl.d L_8cf588
L_8d3682:
	mov_s r0,0x1
L_8d3684:
	bl.d L_8cf958
L_8d3688:
	mov_s r0,0x0
L_8d368a:
	bl.d L_8ceed4
L_8d368e:
	mov_s r0,0x1
L_8d3690:
	bl.d L_8cf4c8
L_8d3694:
	mov_s r0,0x1
	.global L_8d3696
L_8d3696:
	breq_s r14,0,L_8d36b0
L_8d3698:
	mov r4,0x0
L_8d369c:
	bset r4,r4,r16
L_8d36a0:
	asr r5,r4,0x1f
L_8d36a4:
	mov_s r0,0x1
L_8d36a6:
	mov_s r1,0x0
L_8d36a8:
	mov_s r2,r0
L_8d36aa:
	bl.d L_8cfb94
L_8d36ae:
	mov_s r3,r1
	.global L_8d36b0
L_8d36b0:
	b L_8c0324
