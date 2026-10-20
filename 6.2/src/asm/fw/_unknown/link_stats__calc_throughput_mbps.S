/* link_stats__calc_throughput_mbps @ 0x8c5554, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__fill_sta_entry
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_unsigned, link_stats__mcs_to_rate_mbps
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__calc_throughput_mbps
link_stats__calc_throughput_mbps:
	.global L_8c5554
L_8c5554:
	push_s blink
L_8c5556:
	bl L_8c01e4
L_8c555a:
	mov_s r13,r0
L_8c555c:
	mov_s r14,r1
L_8c555e:
	brlt.d r2,0x1,L_8c5574
L_8c5562:
	mov_s r0,r2
L_8c5564:
	brge r0,0xd,L_8c5574
L_8c5568:
	cmp_s r0,0x5
L_8c556a:
	cmp.ne r0,0x9
L_8c556e:
	beq_s L_8c5574
L_8c5570:
	brge r13,0x1,L_8c5578
	.global L_8c5574
L_8c5574:
	mov_s r0,0x0
L_8c5576:
	b_s L_8c558e
	.global L_8c5578
L_8c5578:
	bl L_8ddd50
L_8c557c:
	sub r1,r13,r14
L_8c5580:
	extb_s r1,r1
L_8c5582:
	mulu64 r1,r0
L_8c5586:
	mov_s r0,mlo
L_8c5588:
	bl.d L_8c02d4
L_8c558c:
	mov_s r1,r13
	.global L_8c558e
L_8c558e:
	b L_8c0254
L_8c5592:
	nop_s
