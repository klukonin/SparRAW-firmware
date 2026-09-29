/* stats__delta_since_baseline @ 0x8f64f4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stats__log_counters
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_rx_cnt__get_crc_err, mac_rx_cnt__get_crc_total, mac_rx_cnt__get_u64_bc, mac_tx_cnt__get_fail, mac_tx_cnt__get_ok, mac_tx_cnt__get_u64_14, stats__read_counter_by_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stats__delta_since_baseline
stats__delta_since_baseline:
	.global L_8f64f4
L_8f64f4:
	push_s blink
L_8f64f6:
	bl L_8c01dc
L_8f64fa:
	mov_s r16,r0
L_8f64fc:
	mov_s r14,r1
L_8f64fe:
	mov_s r0,0x0
L_8f6500:
	bl.d L_8dd7a4
L_8f6504:
	push_s r0
L_8f6506:
	mov_s r15,0x805170
L_8f650c:
	ld r3,[r15, 0x94]
L_8f6510:
	mov_s r13,0x8051f0
L_8f6516:
	sub.f r0,r0,r3
L_8f651a:
	ld r2,[r15, 0x98]
L_8f651e:
	st_s r0,[r14]
L_8f6520:
	sbc r1,r1,r2
L_8f6524:
	bl.d L_8dd798
L_8f6528:
	st_s r1,[r14,0x4]
L_8f652a:
	ld r2,[r15, 0x9c]
L_8f652e:
	sub.f r0,r0,r2
L_8f6532:
	ld r3,[r15, 0xa0]
L_8f6536:
	st_s r0,[r14,0x8]
L_8f6538:
	sbc r1,r1,r3
L_8f653c:
	bl.d L_8dd758
L_8f6540:
	st_s r1,[r14,0xc]
L_8f6542:
	ld_s r1,[r13,0x24]
L_8f6544:
	sub_s r0,r0,r1
L_8f6546:
	bl.d L_8dd760
L_8f654a:
	st_s r0,[r14,0x10]
L_8f654c:
	ld_s r1,[r13,0x28]
L_8f654e:
	sub_s r0,r0,r1
L_8f6550:
	bl.d L_8dd7ac
L_8f6554:
	st_s r0,[r14,0x14]
L_8f6556:
	ld_s r1,[r13,0x2c]
L_8f6558:
	sub_s r0,r0,r1
L_8f655a:
	bl.d L_8dd8a8
L_8f655e:
	st_s r0,[r14,0x18]
L_8f6560:
	ld_s r1,[r13,0x30]
L_8f6562:
	sub_s r0,r0,r1
L_8f6564:
	st_s r0,[r14,0x1c]
L_8f6566:
	mov_s r1,sp
L_8f6568:
	bl.d L_8dd7b8
L_8f656c:
	ldb r0,[r16, 0x14]
L_8f6570:
	ld_s r1,[r13,0x34]
L_8f6572:
	sub_s r0,r0,r1
L_8f6574:
	st_s r0,[r14,0x20]
L_8f6576:
	ld_s r0,[sp,0x0]
L_8f6578:
	ld_s r1,[r13,0x38]
L_8f657a:
	sub_s r0,r0,r1
L_8f657c:
	st_s r0,[r14,0x24]
L_8f657e:
	b.d L_8c0244
L_8f6582:
	add_s sp,sp,0x4
