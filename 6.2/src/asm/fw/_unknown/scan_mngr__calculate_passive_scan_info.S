/* scan_mngr__calculate_passive_scan_info @ 0x8f16ec, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::calculate_passive_scan_info
 * Зовут его: channels_switch_sm__action_dwelling_stopped
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_divmod_unsigned, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__calculate_passive_scan_info
scan_mngr__calculate_passive_scan_info:
	.global L_8f16ec
L_8f16ec:
	push_s blink
L_8f16ee:
	bl L_8c01e0
L_8f16f2:
	mov_s r13,r0
L_8f16f4:
	mov_s r15,r1
L_8f16f6:
	mov_s r1,0x1016474
L_8f16fc:
	bl.d L_8dcba8
L_8f1700:
	mov_s r0,0x29
L_8f1702:
	asl_s r14,r15,0x2
L_8f1704:
	mov_s r0,0x853900
L_8f170a:
	add1_s r14,r14,r14
L_8f170c:
	ld_s r0,[r0,0x14]
L_8f170e:
	add_s r13,r13,r14
L_8f1710:
	ld_s r14,[r13,0x2c]
L_8f1712:
	bl.d L_8c02d4
L_8f1716:
	mov r1,0x3e8
L_8f171a:
	sub_s r0,r0,r14
L_8f171c:
	st_s r0,[r13,0x2c]
L_8f171e:
	mov_s r0,0x8054ec
L_8f1724:
	ldw_s r0,[r0,0x2c]
L_8f1726:
	ld_s r1,[r13,0x30]
L_8f1728:
	cmp_s r1,r0
L_8f172a:
	mov_s r0,0x1
L_8f172c:
	sub.ge r0,r0,r0
L_8f1730:
	st_s r0,[r13,0x30]
L_8f1732:
	mov_s r0,0x1
L_8f1734:
	b.d L_8c024c
L_8f1738:
	st_s r0,[r13,0x28]
L_8f173a:
	nop_s
