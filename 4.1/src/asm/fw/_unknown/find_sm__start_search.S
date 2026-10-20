/* find_sm__start_search @ 0x8f1648, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: Start search
 *   FIND_SM:: free dband info when start SRCH
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, find_mng__add_bcon, find_sm__report_search_started, free_dband_info, fw_log__emit0, llist__pop_front
 */
	.section .text.find_sm__start_search,"ax",@progbits
	.global find_sm__start_search
find_sm__start_search:
L_8f1648:
	push_s blink
L_8f164a:
	bl.d L_8c02c4
L_8f164e:
	mov_s r1,0x2
L_8f1650:
	mov_s r14,r0
L_8f1652:
	mov_s r2,0x101467c
L_8f1658:
	bl.d L_8edfb0
L_8f165c:
	mov_s r0,0xc
L_8f165e:
	b_s L_8f1678
	.global L_8f1660
L_8f1660:
	mov_s r2,0x1014694
L_8f1666:
	mov_s r0,0xc
L_8f1668:
	bl.d L_8edfb0
L_8f166c:
	mov_s r1,0x1
L_8f166e:
	bl.d L_8de2d4
L_8f1672:
	mov_s r0,r13
L_8f1674:
	bl L_8ebb88
	.global L_8f1678
L_8f1678:
	add r13,r14,0x3c
L_8f167c:
	ld_s r0,[r13]
L_8f167e:
	sub.f r0,r0,0x0
L_8f1682:
	mov.ne r0,0x1
L_8f1686:
	extb.f 0x0,r0
L_8f168a:
	bne_s L_8f1660
L_8f168c:
	bl.d L_8c225c
L_8f1690:
	ld_s r0,[r14,0x34]
L_8f1692:
	bl.d L_8e00d8
L_8f1696:
	ld_s r0,[r14,0x34]
L_8f1698:
	b L_8c0334
