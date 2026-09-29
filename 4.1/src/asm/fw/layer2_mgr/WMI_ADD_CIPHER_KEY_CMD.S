/* WMI_ADD_CIPHER_KEY_CMD @ 0x8f3568, 424 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_ADD_CIPHER_KEY_CMD: CID[%d]ADDR-%04X%08X
 *   Add TX GTK
 *   Add RX GTK. CID: %d
 *   GLOBAL WMI_ADD_CIPHER_KEY_CMD MID[%d]ADDR-%04X%08X
 *   rejected RX GTK WMI COMMAND, No connection
 *   WMI_ADD_CIPHER_KEY_CMD rejected no CID for ADDR-%04X%08X
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, mid_list__by_mid, mid_list__find_by, set_gtk, set_tk, u_schd__schedule, wmi_add_key__pick_mid
 * Глобалы (через gp): 0x8003e8
 */
	.section .text.WMI_ADD_CIPHER_KEY_CMD,"ax",@progbits
	.global WMI_ADD_CIPHER_KEY_CMD
WMI_ADD_CIPHER_KEY_CMD:
	.global L_8f3568
L_8f3568:
	push_s blink
L_8f356a:
	bl L_8c02b8
L_8f356e:
	mov_s r13,r0
L_8f3570:
	mov_s r17,r1
L_8f3572:
	bl.d L_8ca1b0
L_8f3576:
	mov_s r0,r1
L_8f3578:
	mov_s r14,r0
L_8f357a:
	ldb_s r0,[r13,0x2]
L_8f357c:
	brne r0,0x0,L_8f3604
L_8f3580:
	add r16,r13,0x2d
L_8f3584:
	mov_s r0,r14
L_8f3586:
	bl.d L_8c9e74
L_8f358a:
	mov_s r1,r16
L_8f358c:
	mov.f r15,r0
L_8f3590:
	beq_s L_8f36ce
L_8f3592:
	mov_s r0,r14
L_8f3594:
	bl.d L_8c9e74
L_8f3598:
	mov_s r1,r16
L_8f359a:
	add r1,r13,0xc
L_8f359e:
	mov_s r0,r15
L_8f35a0:
	bl.d L_8e2134
L_8f35a4:
	ldb_s r2,[r13]
L_8f35a6:
	ldb r0,[r13, 0x32]
L_8f35aa:
	ldb r4,[r13, 0x31]
L_8f35ae:
	asl_s r0,r0,0x8
L_8f35b0:
	or r4,r4,r0
L_8f35b4:
	ldb r0,[r13, 0x2e]
L_8f35b8:
	ldb r5,[r13, 0x2d]
L_8f35bc:
	asl_s r0,r0,0x8
L_8f35be:
	or r5,r5,r0
L_8f35c2:
	ldb r0,[r13, 0x2f]
L_8f35c6:
	mov_s r2,0x1009fcc
L_8f35cc:
	asl_s r0,r0,0x10
L_8f35ce:
	or r5,r5,r0
L_8f35d2:
	ldb r0,[r13, 0x30]
L_8f35d6:
	mov_s r1,0x2
L_8f35d8:
	asl_s r0,r0,0x18
L_8f35da:
	or r5,r5,r0
L_8f35de:
	mov_s r0,0x0
L_8f35e0:
	bl.d L_8ee034
L_8f35e4:
	ldb_s r3,[r15,0x8]
L_8f35e6:
	mov_s r0,0x2d778
L_8f35ec:
	ld.as r4,[gp,0x9e]
L_8f35f0:
	mov_s r1,r17
L_8f35f2:
	ldb_s r2,[r15,0x8]
L_8f35f4:
	mov_s r3,0x2
L_8f35f6:
	mov r5,0x0
L_8f35fa:
	bl.d L_8dc92c
L_8f35fe:
	mov r6,0x0
L_8f3602:
	b_s L_8f370a
	.global L_8f3604
L_8f3604:
	mov_s r15,0xff
L_8f3606:
	brne r0,0x2,L_8f3638
L_8f360a:
	mov_s r2,0x1009ffc
L_8f3610:
	mov_s r0,0x0
L_8f3612:
	bl.d L_8edfb0
L_8f3616:
	mov_s r1,0x2
L_8f3618:
	mov_s r0,0x2d740
L_8f361e:
	ld.as r4,[gp,0x9e]
L_8f3622:
	mov_s r1,r17
L_8f3624:
	mov_s r2,0x0
L_8f3626:
	mov_s r3,0x2
L_8f3628:
	mov r5,0x0
L_8f362c:
	bl.d L_8dc92c
L_8f3630:
	mov r6,0x0
L_8f3634:
	mov_s r16,r15
L_8f3636:
	b_s L_8f366a
	.global L_8f3638
L_8f3638:
	ld_s r0,[r14,0x14]
L_8f363a:
	cmp_s r0,0x1
L_8f363c:
	cmp.ne r0,0x20
L_8f3640:
	bne_s L_8f364a
L_8f3642:
	bl.d L_8c9ab8
L_8f3646:
	mov_s r0,r14
L_8f3648:
	b_s L_8f3654
	.global L_8f364a
L_8f364a:
	add r1,r13,0x2d
L_8f364e:
	bl.d L_8c9e74
L_8f3652:
	mov_s r0,r14
	.global L_8f3654
L_8f3654:
	breq_s r0,0,L_8f36be
L_8f3656:
	ldb r16,[r0, 0x8]
L_8f365a:
	mov_s r2,0x100a008
L_8f3660:
	mov_s r0,0x0
L_8f3662:
	mov_s r1,0x2
L_8f3664:
	bl.d L_8edfcc
L_8f3668:
	mov_s r3,r16
	.global L_8f366a
L_8f366a:
	ldb r0,[r13, 0x32]
L_8f366e:
	ldb r4,[r13, 0x31]
L_8f3672:
	asl_s r0,r0,0x8
L_8f3674:
	or r4,r4,r0
L_8f3678:
	ldb r0,[r13, 0x2e]
L_8f367c:
	ldb r5,[r13, 0x2d]
L_8f3680:
	asl_s r0,r0,0x8
L_8f3682:
	or r5,r5,r0
L_8f3686:
	ldb r0,[r13, 0x2f]
L_8f368a:
	mov_s r2,0x100a01c
L_8f3690:
	asl_s r0,r0,0x10
L_8f3692:
	or r5,r5,r0
L_8f3696:
	ldb r0,[r13, 0x30]
L_8f369a:
	mov_s r1,0x2
L_8f369c:
	asl_s r0,r0,0x18
L_8f369e:
	or r5,r5,r0
L_8f36a2:
	mov_s r0,0x0
L_8f36a4:
	bl.d L_8ee034
L_8f36a8:
	mov_s r3,r17
L_8f36aa:
	ldb_s r2,[r13]
L_8f36ac:
	add r1,r13,0xc
L_8f36b0:
	ldb_s r3,[r13,0x2]
L_8f36b2:
	mov_s r0,r14
L_8f36b4:
	bl.d L_8e1898
L_8f36b8:
	mov r4,r16
L_8f36bc:
	b_s L_8f370a
	.global L_8f36be
L_8f36be:
	mov_s r2,0x100a050
L_8f36c4:
	mov_s r0,0x0
L_8f36c6:
	bl.d L_8edfb0
L_8f36ca:
	mov_s r1,0x2
L_8f36cc:
	b_s L_8f370a
	.global L_8f36ce
L_8f36ce:
	ldb r0,[r13, 0x32]
L_8f36d2:
	ldb r3,[r13, 0x31]
L_8f36d6:
	asl_s r0,r0,0x8
L_8f36d8:
	or_s r3,r3,r0
L_8f36da:
	ldb r0,[r13, 0x2e]
L_8f36de:
	ldb r4,[r13, 0x2d]
L_8f36e2:
	asl_s r0,r0,0x8
L_8f36e4:
	or r4,r4,r0
L_8f36e8:
	ldb r0,[r13, 0x2f]
L_8f36ec:
	mov_s r2,0x100a07c
L_8f36f2:
	asl_s r0,r0,0x10
L_8f36f4:
	or r4,r4,r0
L_8f36f8:
	ldb r0,[r13, 0x30]
L_8f36fc:
	asl_s r0,r0,0x18
L_8f36fe:
	or r4,r4,r0
L_8f3702:
	mov_s r0,0x0
L_8f3704:
	bl.d L_8edff8
L_8f3708:
	mov_s r1,0x1
	.global L_8f370a
L_8f370a:
	b L_8c031c
L_8f370e:
	nop_s
