/* pcie__toggle_880c50_bit2 @ 0x8d029c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: hwd__wait_pll_lock, ut_hw_drivers_cmd_0x203
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__toggle_880c50_bit2
pcie__toggle_880c50_bit2:
	.global L_8d029c
L_8d029c:
	push_s blink
L_8d029e:
	push_s r13
L_8d02a0:
	mov_s r13,0x880c00
L_8d02a6:
	ld_s r1,[r13,0x60]
L_8d02a8:
	cmp_s r0,0x0
L_8d02aa:
	bset_s r1,r1,0x2
L_8d02ac:
	st_s r1,[r13,0x60]
L_8d02ae:
	ld_s r0,[r13,0x50]
L_8d02b0:
	beq_s L_8d02e2
L_8d02b2:
	bclr_s r0,r0,0x2
L_8d02b4:
	st_s r0,[r13,0x50]
L_8d02b6:
	mov lp_count,0x3e8
L_8d02ba:
	nop_s
L_8d02bc:
	lp L_8d02c8
L_8d02c0:
	ld_s r0,[r13,0x60]
L_8d02c2:
	btst_s r0,0x2
L_8d02c4:
	bne_s L_8d02c8
L_8d02c6:
	nop_s
	.global L_8d02c8
L_8d02c8:
	bbit1 r0,0x2,L_8d0314
L_8d02cc:
	mov_s r1,0x101f7a4
L_8d02d2:
	bl.d L_8dcba8
L_8d02d6:
	mov_s r0,0x0
L_8d02d8:
	mov_s r1,0x1329
L_8d02de:
	mov_s r0,blink
L_8d02e0:
	b_s L_8d0310
	.global L_8d02e2
L_8d02e2:
	bset_s r0,r0,0x2
L_8d02e4:
	st_s r0,[r13,0x50]
L_8d02e6:
	mov lp_count,0x3e8
L_8d02ea:
	nop_s
L_8d02ec:
	lp L_8d02f8
L_8d02f0:
	ld_s r0,[r13,0x60]
L_8d02f2:
	btst_s r0,0x2
L_8d02f4:
	bne_s L_8d02f8
L_8d02f6:
	nop_s
	.global L_8d02f8
L_8d02f8:
	bbit1 r0,0x2,L_8d0314
L_8d02fc:
	mov_s r1,0x101f7a4
L_8d0302:
	bl.d L_8dcba8
L_8d0306:
	mov_s r0,0x0
L_8d0308:
	mov_s r0,blink
L_8d030a:
	mov_s r1,0x132a
	.global L_8d0310
L_8d0310:
	bl L_8c9b28
	.global L_8d0314
L_8d0314:
	ld_s r0,[r13,0x60]
L_8d0316:
	bset_s r0,r0,0x2
L_8d0318:
	st_s r0,[r13,0x60]
L_8d031a:
	b L_8c025c
L_8d031e:
	nop_s
