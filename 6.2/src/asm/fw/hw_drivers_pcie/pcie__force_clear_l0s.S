/* pcie__force_clear_l0s @ 0x8d14d4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCIE: EP under Serdes: LnkCtl: Chk L0s configuration(0x%x)!!!
 *   PCIE: EP under Serdes: LnkCtl: L0s is Enabled - ForceClear (0x%x)!!!
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r13_to_r13_ret, dbi_write, fw_log_emit1, hwd_pcie__is_ep_under_serdes, hwd_pcie_exit_l1, pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__force_clear_l0s
pcie__force_clear_l0s:
	.global L_8d14d4
L_8d14d4:
	push_s blink
L_8d14d6:
	push_s r13
L_8d14d8:
	mov_s r1,0x882000
L_8d14de:
	ld_s r0,[r1,0x28]
L_8d14e0:
	sub_s sp,sp,0x8
L_8d14e2:
	bset_s r0,r0,0x12
L_8d14e4:
	st_s r0,[r1,0x28]
L_8d14e6:
	bl.d L_8d1470
L_8d14ea:
	mov_s r13,0x0
L_8d14ec:
	breq_s r0,0,L_8d154e
L_8d14ee:
	bl.d L_8d12ac
L_8d14f2:
	mov_s r0,0x1
L_8d14f4:
	add r6,sp,0x4
L_8d14f8:
	mov_s r0,0x80
L_8d14fa:
	mov_s r1,r13
L_8d14fc:
	mov_s r2,0x1
L_8d14fe:
	mov_s r3,r13
L_8d1500:
	mov_s r4,r13
L_8d1502:
	bl.d L_8c8208
L_8d1506:
	mov r5,0x1
L_8d150a:
	mov_s r1,0x101dc4c
L_8d1510:
	mov_s r0,0x21
L_8d1512:
	bl.d L_8dcc10
L_8d1516:
	ld_s r2,[sp,0x4]
L_8d1518:
	ld_s r2,[sp,0x4]
L_8d151a:
	bbit0 r2,0x0,L_8d1548
L_8d151e:
	mov_s r1,0x101dc8c
L_8d1524:
	bl.d L_8dcc10
L_8d1528:
	mov_s r0,0x1
L_8d152a:
	ld_s r1,[sp,0x4]
L_8d152c:
	st_s r13,[sp,0x0]
L_8d152e:
	bclr_s r1,r1,0x0
L_8d1530:
	st_s r1,[sp,0x4]
L_8d1532:
	mov_s r0,0x80
L_8d1534:
	mov_s r2,r13
L_8d1536:
	mov_s r3,0x1
L_8d1538:
	mov_s r4,r13
L_8d153a:
	mov_s r5,r13
L_8d153c:
	mov r6,0x1
L_8d1540:
	bl.d L_8c8338
L_8d1544:
	mov r7,0x1
	.global L_8d1548
L_8d1548:
	bl.d L_8d12ac
L_8d154c:
	mov_s r0,0x0
	.global L_8d154e
L_8d154e:
	b.d L_8c025c
L_8d1552:
	add_s sp,sp,0x8
