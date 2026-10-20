/* rfc__read_calib_block @ 0x8f3610, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_read_calibrate
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rfc_divider_restart, hwd_rfc_read_rgf, rfc__read_core_result_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_calib_block
rfc__read_calib_block:
	.global L_8f3610
L_8f3610:
	push_s blink
L_8f3612:
	bl.d L_8c01d8
L_8f3616:
	mov r1,0x428
L_8f361a:
	sub_s sp,sp,0x4
L_8f361c:
	mov_s r14,r0
L_8f361e:
	mov_s r15,0x0
L_8f3620:
	bl.d L_8d3588
L_8f3624:
	mov_s r0,r15
L_8f3626:
	mov_s r16,r0
L_8f3628:
	cmp_s r0,0xdeadbeef
L_8f362e:
	mov.eq r0,0xffffffff
L_8f3636:
	beq_s L_8f3690
L_8f3638:
	mov_s r13,r15
L_8f363a:
	brlo.d r14,0x1,L_8f3682
L_8f363e:
	mov_s r17,r15
	.global L_8f3640
L_8f3640:
	bl.d L_8ceda4
L_8f3644:
	mov_s r0,0x0
L_8f3646:
	mov_s r0,0x50
L_8f3648:
	mov lp_count,r0
L_8f364c:
	nop_s
L_8f364e:
	lp L_8f3656
L_8f3652:
	nop_s
L_8f3654:
	nop_s
	.global L_8f3656
L_8f3656:
	mov_s r2,sp
L_8f3658:
	mov_s r0,0x0
L_8f365a:
	bl.d L_8d3628
L_8f365e:
	mov r1,0x428
L_8f3662:
	ld_s r1,[sp,0x0]
L_8f3664:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f3666:
	cmp_s r1,0x1
L_8f3668:
	add.ne r15,r15,0x1
L_8f366c:
	bne_s L_8f367c
L_8f366e:
	sub r1,r0,r16
L_8f3672:
	sub_s r13,r13,r1
L_8f3674:
	add r17,r17,r13
L_8f3678:
	mov_s r13,0x0
L_8f367a:
	mov_s r16,r0
	.global L_8f367c
L_8f367c:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8f367e:
	brhs r14,0x1,L_8f3640
	.global L_8f3682
L_8f3682:
	sub r0,r15,r13
L_8f3686:
	cmp_s r13,0x0
L_8f3688:
	mov.eq r0,r15
L_8f368c:
	sub r0,r0,r17
	.global L_8f3690
L_8f3690:
	b.d L_8c023c
L_8f3694:
	add_s sp,sp,0x4
L_8f3696:
	nop_s
