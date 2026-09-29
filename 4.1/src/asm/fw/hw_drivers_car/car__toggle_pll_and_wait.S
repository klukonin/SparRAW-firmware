/* car__toggle_pll_and_wait @ 0x8cd3e0, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_car.c
 * Зовут его: hwd__wait_pll_lock, ut_hw_drivers_cmd_0x203
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.car__toggle_pll_and_wait,"ax",@progbits
	.global car__toggle_pll_and_wait
car__toggle_pll_and_wait:
	.global L_8cd3e0
L_8cd3e0:
	push_s blink
L_8cd3e2:
	push_s r13
L_8cd3e4:
	mov_s r13,0x880c00
L_8cd3ea:
	ld_s r1,[r13,0x60]
L_8cd3ec:
	cmp_s r0,0x0
L_8cd3ee:
	bset_s r1,r1,0x2
L_8cd3f0:
	st_s r1,[r13,0x60]
L_8cd3f2:
	ld_s r0,[r13,0x50]
L_8cd3f4:
	beq_s L_8cd430
L_8cd3f6:
	bclr_s r0,r0,0x2
L_8cd3f8:
	st_s r0,[r13,0x50]
L_8cd3fa:
	mov lp_count,0x3e8
L_8cd3fe:
	nop_s
L_8cd400:
	lp L_8cd40c
L_8cd404:
	ld_s r0,[r13,0x60]
L_8cd406:
	btst_s r0,0x2
L_8cd408:
	bne_s L_8cd40c
L_8cd40a:
	nop_s
	.global L_8cd40c
L_8cd40c:
	bbit1 r0,0x2,L_8cd46c
L_8cd410:
	mov_s r2,0x1019edc
L_8cd416:
	mov_s r0,0x0
L_8cd418:
	bl.d L_8edfb0
L_8cd41c:
	mov_s r1,r0
L_8cd41e:
	mov_s r0,blink
L_8cd420:
	mov_s r2,0x1019efc
L_8cd426:
	mov_s r1,0x1329
L_8cd42c:
	mov_s r3,0x28
L_8cd42e:
	b_s L_8cd468
	.global L_8cd430
L_8cd430:
	bset_s r0,r0,0x2
L_8cd432:
	st_s r0,[r13,0x50]
L_8cd434:
	mov lp_count,0x3e8
L_8cd438:
	nop_s
L_8cd43a:
	lp L_8cd446
L_8cd43e:
	ld_s r1,[r13,0x60]
L_8cd440:
	btst_s r1,0x2
L_8cd442:
	bne_s L_8cd446
L_8cd444:
	nop_s
	.global L_8cd446
L_8cd446:
	bbit1 r1,0x2,L_8cd46c
L_8cd44a:
	mov_s r2,0x1019edc
L_8cd450:
	mov_s r0,0x0
L_8cd452:
	bl.d L_8edfb0
L_8cd456:
	mov_s r1,r0
L_8cd458:
	mov_s r0,blink
L_8cd45a:
	mov_s r2,0x1019efc
L_8cd460:
	mov_s r1,0x132a
L_8cd466:
	mov_s r3,0x36
	.global L_8cd468
L_8cd468:
	bl L_8c82c0
	.global L_8cd46c
L_8cd46c:
	ld_s r0,[r13,0x60]
L_8cd46e:
	bset_s r0,r0,0x2
L_8cd470:
	st_s r0,[r13,0x60]
L_8cd472:
	b L_8c033c
L_8cd476:
	nop_s
