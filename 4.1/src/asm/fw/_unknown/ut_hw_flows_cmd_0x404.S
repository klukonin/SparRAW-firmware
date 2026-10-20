/* ut_hw_flows_cmd_0x404 @ 0x8d35c4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, power_mngr_on_unassoc_start
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__get_88af10, hwd_abif__write_checked
 */
	.section .text.ut_hw_flows_cmd_0x404,"ax",@progbits
	.global ut_hw_flows_cmd_0x404
ut_hw_flows_cmd_0x404:
	.global L_8d35c4
L_8d35c4:
	push_s blink
L_8d35c6:
	bl L_8c02b8
L_8d35ca:
	mov_s r17,r0
L_8d35cc:
	mov_s r0,0x0
L_8d35ce:
	b_s L_8d35d6
	.global L_8d35d0
L_8d35d0:
	add r0,r16,0x1
L_8d35d4:
	extb_s r0,r0
	.global L_8d35d6
L_8d35d6:
	brge.d r0,0x2,L_8d3610
L_8d35da:
	mov_s r16,r0
L_8d35dc:
	mov_s r14,0x0
L_8d35de:
	b_s L_8d35e4
	.global L_8d35e0
L_8d35e0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d35e2:
	extb_s r14,r14
	.global L_8d35e4
L_8d35e4:
	brge r14,0x2,L_8d35d0
L_8d35e8:
	mov_s r13,0x0
L_8d35ea:
	mov_s r15,0x8
	.global L_8d35ec
L_8d35ec:
	mov_s r0,r13
L_8d35ee:
	mov_s r1,r14
L_8d35f0:
	bl.d L_8cbf5c
L_8d35f4:
	mov_s r2,r16
L_8d35f6:
	mov_s r4,r0
L_8d35f8:
	mov_s r0,r17
L_8d35fa:
	mov_s r1,r13
L_8d35fc:
	mov_s r2,r14
L_8d35fe:
	bl.d L_8cc188
L_8d3602:
	mov_s r3,r16
L_8d3604:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d3606:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d3608:
	brhs.d r15,0x1,L_8d35ec
L_8d360c:
	extb_s r13,r13
L_8d360e:
	b_s L_8d35e0
	.global L_8d3610
L_8d3610:
	b L_8c031c
