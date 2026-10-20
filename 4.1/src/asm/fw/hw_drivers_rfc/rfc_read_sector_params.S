/* rfc_read_sector_params @ 0x8d0580, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_get_rf_sector_params__on_radio_locked_cb
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, hwd_rfc_read_rgf
 */
	.section .text.rfc_read_sector_params,"ax",@progbits
	.global rfc_read_sector_params
rfc_read_sector_params:
	.global L_8d0580
L_8d0580:
	push_s blink
L_8d0582:
	bl L_8c02ac
L_8d0586:
	mov_s r20,r0
L_8d0588:
	mov_s r14,r3
L_8d058a:
	mov r18,r4
L_8d058e:
	mov r17,r5
L_8d0592:
	mov r16,r6
L_8d0596:
	mov r19,r7
L_8d059a:
	ld_s r15,[sp,0x24]
L_8d059c:
	asl_s r13,r1,0x6
L_8d059e:
	add1_s r13,r13,r13
L_8d05a0:
	breq r2,0x0,L_8d0622
L_8d05a4:
	add r0,r13,0x8000
L_8d05ac:
	lsr_s r0,r0,0x3
L_8d05ae:
	bic r1,r0,0x3
L_8d05b2:
	bl.d L_8d04fc
L_8d05b6:
	mov_s r0,r20
L_8d05b8:
	st_s r0,[r14]
L_8d05ba:
	add r0,r13,0x8020
L_8d05c2:
	lsr_s r0,r0,0x3
L_8d05c4:
	bic r1,r0,0x3
L_8d05c8:
	bl.d L_8d04fc
L_8d05cc:
	mov_s r0,r20
L_8d05ce:
	st r0,[r18]
L_8d05d2:
	add r0,r13,0x8060
L_8d05da:
	lsr_s r0,r0,0x3
L_8d05dc:
	bic r1,r0,0x3
L_8d05e0:
	bl.d L_8d04fc
L_8d05e4:
	mov_s r0,r20
L_8d05e6:
	st r0,[r17]
L_8d05ea:
	add r0,r13,0x8040
L_8d05f2:
	lsr_s r0,r0,0x3
L_8d05f4:
	bic r1,r0,0x3
L_8d05f8:
	bl.d L_8d04fc
L_8d05fc:
	mov_s r0,r20
L_8d05fe:
	st r0,[r16]
L_8d0602:
	add r0,r13,0x80a0
L_8d060a:
	lsr_s r0,r0,0x3
L_8d060c:
	bic r1,r0,0x3
L_8d0610:
	bl.d L_8d04fc
L_8d0614:
	mov_s r0,r20
L_8d0616:
	add_s r13,r13,0x8080
L_8d061c:
	st r0,[r19]
L_8d0620:
	b_s L_8d069e
	.global L_8d0622
L_8d0622:
	add r0,r13,0x10000
L_8d062a:
	lsr_s r0,r0,0x3
L_8d062c:
	bic r1,r0,0x3
L_8d0630:
	bl.d L_8d04fc
L_8d0634:
	mov_s r0,r20
L_8d0636:
	st_s r0,[r14]
L_8d0638:
	add r0,r13,0x10020
L_8d0640:
	lsr_s r0,r0,0x3
L_8d0642:
	bic r1,r0,0x3
L_8d0646:
	bl.d L_8d04fc
L_8d064a:
	mov_s r0,r20
L_8d064c:
	st r0,[r18]
L_8d0650:
	add r0,r13,0x10060
L_8d0658:
	lsr_s r0,r0,0x3
L_8d065a:
	bic r1,r0,0x3
L_8d065e:
	bl.d L_8d04fc
L_8d0662:
	mov_s r0,r20
L_8d0664:
	st r0,[r17]
L_8d0668:
	add r0,r13,0x10040
L_8d0670:
	lsr_s r0,r0,0x3
L_8d0672:
	bic r1,r0,0x3
L_8d0676:
	bl.d L_8d04fc
L_8d067a:
	mov_s r0,r20
L_8d067c:
	st r0,[r16]
L_8d0680:
	add r0,r13,0x100a0
L_8d0688:
	lsr_s r0,r0,0x3
L_8d068a:
	bic r1,r0,0x3
L_8d068e:
	bl.d L_8d04fc
L_8d0692:
	mov_s r0,r20
L_8d0694:
	st r0,[r19]
L_8d0698:
	add_s r13,r13,0x10080
	.global L_8d069e
L_8d069e:
	lsr_s r13,r13,0x3
L_8d06a0:
	bic r1,r13,0x3
L_8d06a4:
	bl.d L_8d04fc
L_8d06a8:
	mov_s r0,r20
L_8d06aa:
	b.d L_8c0304
L_8d06ae:
	st_s r0,[r15]
