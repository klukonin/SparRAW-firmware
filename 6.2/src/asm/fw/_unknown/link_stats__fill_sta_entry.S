/* link_stats__fill_sta_entry @ 0x8ca554, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__periodic_notif_handler, wmi__bump_cmd_counter
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, link_stats__calc_throughput_mbps, link_stats__get_sta_word58, link_stats__get_sta_word64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__fill_sta_entry
link_stats__fill_sta_entry:
	.global L_8ca554
L_8ca554:
	push_s blink
L_8ca556:
	bl L_8c01e4
L_8ca55a:
	mov_s r14,r0
L_8ca55c:
	ld_s r0,[r0,0x38]
L_8ca55e:
	mov_s r13,r1
L_8ca560:
	st_s r0,[r1]
L_8ca562:
	mov_s r1,0x886e80
L_8ca568:
	ld_s r0,[r1,0x3c]
L_8ca56a:
	st_s r0,[r13,0x8]
L_8ca56c:
	ld_s r0,[r1,0x38]
L_8ca56e:
	st_s r0,[r13,0x4]
L_8ca570:
	mov_s r0,0x0
L_8ca572:
	stw_s r0,[r13,0x26]
L_8ca574:
	ld_s r1,[r14,0x38]
L_8ca576:
	cmp_s r1,0x0
L_8ca578:
	cmp.ne r1,0x2
L_8ca57c:
	bne_s L_8ca592
L_8ca57e:
	stb_s r0,[r13,0xc]
L_8ca580:
	st_s r0,[r13,0x10]
L_8ca582:
	st_s r0,[r13,0x14]
L_8ca584:
	st_s r0,[r13,0x18]
L_8ca586:
	stw_s r0,[r13,0x1c]
L_8ca588:
	mov_s r0,0xff
L_8ca58a:
	stw_s r0,[r13,0x1e]
L_8ca58c:
	stw_s r0,[r13,0x20]
L_8ca58e:
	stw_s r0,[r13,0x22]
L_8ca590:
	b_s L_8ca5d4
	.global L_8ca592
L_8ca592:
	ld_s r0,[r14,0xc]
L_8ca594:
	sub r0,r0,0x48
L_8ca598:
	stb_s r0,[r13,0xc]
L_8ca59a:
	ldb r2,[r14, 0x6e]
L_8ca59e:
	add3 r0,r14,0x8
L_8ca5a2:
	add_s r3,r0,r2
L_8ca5a4:
	add_s r0,r0,r2
L_8ca5a6:
	ldb_s r1,[r0,0x1d]
L_8ca5a8:
	bl.d L_8c5554
L_8ca5ac:
	ldb_s r0,[r3,0x10]
L_8ca5ae:
	st_s r0,[r13,0x10]
L_8ca5b0:
	bl.d L_8ccf64
L_8ca5b4:
	ld_s r0,[r14]
L_8ca5b6:
	st_s r0,[r13,0x14]
L_8ca5b8:
	bl.d L_8ccb50
L_8ca5bc:
	ld_s r0,[r14]
L_8ca5be:
	st_s r0,[r13,0x18]
L_8ca5c0:
	ldb r0,[r14, 0x6e]
L_8ca5c4:
	stw_s r0,[r13,0x1c]
L_8ca5c6:
	ldb_s r0,[r14,0x11]
L_8ca5c8:
	stw_s r0,[r13,0x1e]
L_8ca5ca:
	ldb_s r0,[r14,0x12]
L_8ca5cc:
	stw_s r0,[r13,0x20]
L_8ca5ce:
	ldb_s r0,[r14,0x13]
L_8ca5d0:
	stw_s r0,[r13,0x22]
L_8ca5d2:
	ldb_s r0,[r14,0x14]
	.global L_8ca5d4
L_8ca5d4:
	stw_s r0,[r13,0x24]
L_8ca5d6:
	ld_s r0,[r14,0x4]
L_8ca5d8:
	ldb r0,[r0,0x18d]
L_8ca5e0:
	b.d L_8c0254
L_8ca5e4:
	stb r0,[r13, 0x28]
