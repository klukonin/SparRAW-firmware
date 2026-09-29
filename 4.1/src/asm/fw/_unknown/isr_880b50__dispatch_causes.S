/* isr_880b50__dispatch_causes @ 0x8c15e8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Awake TSF LED interrupt expired! TSF: 0x%08x:%08x
 * Зовут его: isr_awake_tsf_led
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, __ld_r13_ret, fw_log__emit2, hw_880b60__set_and_schedule, irq_880b60__ack_b18_post_mbox_oper, irq_880b60__ack_b19_post_mbox_dbg, irq_880b60__ack_b27_post_rf_kill, irq_cause__bit2, mac_read_tsf64, set_reg_880b60_8d7718, tail_u_schd__tick
 */
	.section .text.isr_880b50__dispatch_causes,"ax",@progbits
	.global isr_880b50__dispatch_causes
isr_880b50__dispatch_causes:
	.global L_8c15e8
L_8c15e8:
	push_s blink
L_8c15ea:
	push_s r13
L_8c15ec:
	sub_s sp,sp,0x8
L_8c15ee:
	bl.d L_8c7460
L_8c15f2:
	mov_s r0,0x1
L_8c15f4:
	mov_s r0,0x880b00
L_8c15fa:
	ld_s r13,[r0,0x54]
L_8c15fc:
	st_s r13,[r0,0x50]
L_8c15fe:
	bl.d L_8e4668
L_8c1602:
	mov_s r0,r13
L_8c1604:
	cmp_s r0,0x0
L_8c1606:
	bl.ne L_8e469c
L_8c160a:
	bbit0 r13,0x12,L_8c161e
L_8c160e:
	bl L_8cb440
L_8c1612:
	mov_s r1,0x880a3c
L_8c1618:
	ld_s r0,[r1,0x14]
L_8c161a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c161c:
	st_s r0,[r1,0x14]
	.global L_8c161e
L_8c161e:
	btst_s r13,0x13
L_8c1620:
	bl.ne L_8cb460
L_8c1624:
	btst_s r13,0x9
L_8c1626:
	bl.ne L_8cb488
L_8c162a:
	btst_s r13,0x1b
L_8c162c:
	bl.ne L_8cb590
L_8c1630:
	bbit0 r13,0x4,L_8c1656
L_8c1634:
	bl L_8d7718
L_8c1638:
	mov_s r1,sp
L_8c163a:
	mov_s r0,0x0
L_8c163c:
	bl.d L_8e4840
L_8c1640:
	mov_s r2,r0
L_8c1642:
	mov_s r2,0x1000198
L_8c1648:
	ld r4,[sp]
L_8c164c:
	mov_s r0,0x0
L_8c164e:
	mov_s r1,0x2
L_8c1650:
	bl.d L_8edff8
L_8c1654:
	ld_s r3,[sp,0x4]
	.global L_8c1656
L_8c1656:
	b.d L_8c033c
L_8c165a:
	add_s sp,sp,0x8
