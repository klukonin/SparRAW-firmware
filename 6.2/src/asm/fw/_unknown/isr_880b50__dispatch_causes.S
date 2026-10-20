/* isr_880b50__dispatch_causes @ 0x8c161c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Awake TSF LED interrupt expired! TSF: 0x%08x:%08x
 * Зовут его: fw_vector_04
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, __ld_r13_to_r13_ret, fw_log_emit2, gpio__pulse_880b60_18, gpio__pulse_880b60_19, host_irq__mask_awake_tsf, isr__step_22f70_80044c__8cdbb4, mac_read_tsf64, u_schd__expire_timers_thunk, u_schd__timer_irq_pending, uc_evt__mask_irq_and_defer_drain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr_880b50__dispatch_causes
isr_880b50__dispatch_causes:
	.global L_8c161c
L_8c161c:
	push_s blink
L_8c161e:
	push_s r13
L_8c1620:
	sub_s sp,sp,0x8
L_8c1622:
	bl.d L_8c8a34
L_8c1626:
	mov_s r0,0x1
L_8c1628:
	mov_s r0,0x880b00
L_8c162e:
	ld_s r13,[r0,0x54]
L_8c1630:
	st_s r13,[r0,0x50]
L_8c1632:
	bl.d L_8e94f8
L_8c1636:
	mov_s r0,r13
L_8c1638:
	cmp_s r0,0x0
L_8c163a:
	bl.ne L_8e952c
L_8c163e:
	bbit0 r13,0x12,L_8c1652
L_8c1642:
	bl L_8cd724
L_8c1646:
	mov_s r1,0x880a3c
L_8c164c:
	ld_s r0,[r1,0x14]
L_8c164e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c1650:
	st_s r0,[r1,0x14]
	.global L_8c1652
L_8c1652:
	btst_s r13,0x13
L_8c1654:
	bl.ne L_8cd744
L_8c1658:
	btst_s r13,0x9
L_8c165a:
	bl.ne L_8cd864
L_8c165e:
	btst_s r13,0x1b
L_8c1660:
	bl.ne L_8cdbb4
L_8c1664:
	bbit0 r13,0x4,L_8c1686
L_8c1668:
	bl L_8da810
L_8c166c:
	mov_s r1,sp
L_8c166e:
	mov_s r0,0x0
L_8c1670:
	bl.d L_8e9900
L_8c1674:
	mov_s r2,r0
L_8c1676:
	ld_s r2,[sp,0x4]
L_8c1678:
	mov_s r1,0x10001ac
L_8c167e:
	mov_s r0,0x20
L_8c1680:
	bl.d L_8dcc80
L_8c1684:
	ld_s r3,[sp,0x0]
	.global L_8c1686
L_8c1686:
	b.d L_8c025c
L_8c168a:
	add_s sp,sp,0x8
