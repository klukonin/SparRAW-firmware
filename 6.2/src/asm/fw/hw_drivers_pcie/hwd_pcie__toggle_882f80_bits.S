/* hwd_pcie__toggle_882f80_bits @ 0x8d1554, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_pm_host_config, stats_timer_exp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__toggle_882f80_bits
hwd_pcie__toggle_882f80_bits:
	.global L_8d1554
L_8d1554:
	mov_s r2,0x882f80
L_8d155a:
	mov_s r1,0x88b080
L_8d1560:
	brne_s r0,0,L_8d1576
L_8d1562:
	ld_s r0,[r2,0x8]
L_8d1564:
	bset_s r0,r0,0x1a
L_8d1566:
	st_s r0,[r2,0x8]
L_8d1568:
	ld_s r0,[r2,0x8]
L_8d156a:
	bset_s r0,r0,0x1d
L_8d156c:
	st_s r0,[r2,0x8]
L_8d156e:
	ld_s r0,[r1,0x30]
L_8d1570:
	bclr_s r0,r0,0x6
L_8d1572:
	st_s r0,[r1,0x30]
L_8d1574:
	b_s L_8d1588
	.global L_8d1576
L_8d1576:
	ld_s r0,[r1,0x30]
L_8d1578:
	bset_s r0,r0,0x6
L_8d157a:
	st_s r0,[r1,0x30]
L_8d157c:
	ld_s r0,[r2,0x8]
L_8d157e:
	bclr_s r0,r0,0x1d
L_8d1580:
	st_s r0,[r2,0x8]
L_8d1582:
	ld_s r0,[r2,0x8]
L_8d1584:
	bclr_s r0,r0,0x1a
L_8d1586:
	st_s r0,[r2,0x8]
	.global L_8d1588
L_8d1588:
	j_s [blink]
L_8d158a:
	nop_s
