/* link_lost_diag__dump_rf @ 0x8c86b4, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG RF: RF tx_gain_config_val=%d    atten_config_val=%d
 *   DEBUG RF: CURRENT_STATUS.RF_INFO1: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC3: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC4: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC5: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC6: 0x%08x
 *   DEBUG RF: MODEM_STAT.RFC_MODEM_STAT_18(mdm_stt_rx_crc_err): 0x%08x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_log_emit2, hwd_rfc_read_rgf, rf__type_is_sparrow_r
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_rf
link_lost_diag__dump_rf:
	.global L_8c86b4
L_8c86b4:
	push_s blink
L_8c86b6:
	push_s r13
L_8c86b8:
	bl.d L_8da584
L_8c86bc:
	mov_s r13,r0
L_8c86be:
	breq r0,0x0,L_8c8770
L_8c86c2:
	ldb_s r0,[r13]
L_8c86c4:
	bl.d L_8d3588
L_8c86c8:
	mov r1,0x504
L_8c86cc:
	mov_s r3,r0
L_8c86ce:
	mov_s r1,0x100589c
L_8c86d4:
	mov_s r0,0x20
L_8c86d6:
	bmsk r2,r3,0x3
L_8c86da:
	bl.d L_8dcc80
L_8c86de:
	lsr_s r3,r3,0x4
L_8c86e0:
	ldb_s r0,[r13]
L_8c86e2:
	bl.d L_8d3588
L_8c86e6:
	mov r1,0x6c8
L_8c86ea:
	mov_s r2,r0
L_8c86ec:
	mov_s r1,0x10058d8
L_8c86f2:
	bl.d L_8dcc10
L_8c86f6:
	mov_s r0,0x20
L_8c86f8:
	ldb_s r0,[r13]
L_8c86fa:
	bl.d L_8d3588
L_8c86fe:
	mov r1,0x6d4
L_8c8702:
	mov_s r2,r0
L_8c8704:
	mov_s r1,0x1005904
L_8c870a:
	bl.d L_8dcc10
L_8c870e:
	mov_s r0,0x20
L_8c8710:
	ldb_s r0,[r13]
L_8c8712:
	bl.d L_8d3588
L_8c8716:
	mov r1,0x6d8
L_8c871a:
	mov_s r2,r0
L_8c871c:
	mov_s r1,0x1005930
L_8c8722:
	bl.d L_8dcc10
L_8c8726:
	mov_s r0,0x20
L_8c8728:
	ldb_s r0,[r13]
L_8c872a:
	bl.d L_8d3588
L_8c872e:
	mov r1,0x6dc
L_8c8732:
	mov_s r2,r0
L_8c8734:
	mov_s r1,0x100595c
L_8c873a:
	bl.d L_8dcc10
L_8c873e:
	mov_s r0,0x20
L_8c8740:
	ldb_s r0,[r13]
L_8c8742:
	bl.d L_8d3588
L_8c8746:
	mov r1,0x6e0
L_8c874a:
	mov_s r2,r0
L_8c874c:
	mov_s r1,0x1005988
L_8c8752:
	bl.d L_8dcc10
L_8c8756:
	mov_s r0,0x20
L_8c8758:
	ldb_s r0,[r13]
L_8c875a:
	bl.d L_8d3588
L_8c875e:
	mov r1,0x42c
L_8c8762:
	mov_s r2,r0
L_8c8764:
	mov_s r1,0x10059b4
L_8c876a:
	bl.d L_8dcc10
L_8c876e:
	mov_s r0,0x20
	.global L_8c8770
L_8c8770:
	b L_8c025c
