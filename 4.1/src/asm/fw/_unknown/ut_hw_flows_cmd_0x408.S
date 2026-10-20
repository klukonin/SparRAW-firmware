/* ut_hw_flows_cmd_0x408 @ 0x8d34f8, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_abif__adjust_5bit_pair, hwd_phy__get_885110, hwd_phy__rgf_885000_8cf184, hwd_phy__rgf_885000_8cf198
 */
	.section .text.ut_hw_flows_cmd_0x408,"ax",@progbits
	.global ut_hw_flows_cmd_0x408
ut_hw_flows_cmd_0x408:
	.global L_8d34f8
L_8d34f8:
	push_s blink
L_8d34fa:
	bl L_8c02c4
L_8d34fe:
	sub_s sp,sp,0x4
L_8d3500:
	bl.d L_8cf198
L_8d3504:
	mov_s r14,r0
L_8d3506:
	mov_s r13,0x0
L_8d3508:
	b_s L_8d353a
	.global L_8d350a
L_8d350a:
	rsub r0,r1,0x8
L_8d350e:
	/* asr_s r0,r0,0x4 */
	.byte 0x44,0xb8
L_8d3510:
	neg_s r0,r0
	.global L_8d3512
L_8d3512:
	sexw_s r0,r0
L_8d3514:
	cmp_s r0,0x40
L_8d3516:
	ble_s L_8d351e
L_8d3518:
	sub r0,r0,0x80
L_8d351c:
	sexw_s r0,r0
	.global L_8d351e
L_8d351e:
	abs_s r1,r0
L_8d3520:
	brlt r1,0x2,L_8d3536
L_8d3524:
	neg_s r2,r0
L_8d3526:
	sexb_s r2,r2
L_8d3528:
	mov_s r0,r13
L_8d352a:
	bl.d L_8cbf98
L_8d352e:
	mov_s r1,0x1
L_8d3530:
	ld_s r0,[r14]
L_8d3532:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d3534:
	st_s r0,[r14]
	.global L_8d3536
L_8d3536:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d3538:
	extb_s r13,r13
	.global L_8d353a
L_8d353a:
	brge r13,0x8,L_8d3592
L_8d353e:
	mov_s r1,sp
L_8d3540:
	bl.d L_8cf0e4
L_8d3544:
	mov_s r0,r13
L_8d3546:
	ldw.x r1,[sp]
L_8d354a:
	brlt r1,0x0,L_8d3556
L_8d354e:
	add r0,r1,0x8
L_8d3552:
	/* asr_s r0,r0,0x4 */
	.byte 0x44,0xb8
L_8d3554:
	b_s L_8d355e
	.global L_8d3556
L_8d3556:
	rsub r0,r1,0x8
L_8d355a:
	/* asr_s r0,r0,0x4 */
	.byte 0x44,0xb8
L_8d355c:
	neg_s r0,r0
	.global L_8d355e
L_8d355e:
	sexw_s r0,r0
L_8d3560:
	cmp_s r0,0x40
L_8d3562:
	ble_s L_8d356a
L_8d3564:
	sub r0,r0,0x80
L_8d3568:
	sexw_s r0,r0
	.global L_8d356a
L_8d356a:
	abs_s r1,r0
L_8d356c:
	brlt r1,0x2,L_8d3582
L_8d3570:
	neg_s r2,r0
L_8d3572:
	sexb_s r2,r2
L_8d3574:
	mov_s r0,r13
L_8d3576:
	bl.d L_8cbf98
L_8d357a:
	mov_s r1,0x0
L_8d357c:
	ld_s r0,[r14]
L_8d357e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d3580:
	st_s r0,[r14]
	.global L_8d3582
L_8d3582:
	ldw.x r1,[sp, 0x2]
L_8d3586:
	brlt r1,0x0,L_8d350a
L_8d358a:
	add r0,r1,0x8
L_8d358e:
	/* asr_s r0,r0,0x4 */
	.byte 0x44,0xb8
L_8d3590:
	b_s L_8d3512
	.global L_8d3592
L_8d3592:
	bl L_8cf184
L_8d3596:
	b.d L_8c0334
L_8d359a:
	add_s sp,sp,0x4
