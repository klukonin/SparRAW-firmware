/* bi_mode_init_sequence @ 0x93171c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BCON
 * Зовут его: uc_main_init
 * Зовёт сам: bi_ctx__reset, bi_mode__build_schedule, bi_mode__load_qset_table, bi_mode__program_mac_timing, bi_mode__reset_bf_state, bi_mode_init_substep, mac_sxd__program_886d88_and_cmd_1e, rw_g_801b08, set_g_800994, set_g_801b64_x2, set_reg_886d20_x2, tail_bi_ap_mon__init
 */
	.section .text.bi_mode_init_sequence,"ax",@progbits
	.global bi_mode_init_sequence
bi_mode_init_sequence:
	.global L_93171c
L_93171c:
	push_s blink
L_93171e:
	bl L_93160c
L_931722:
	mov_s r1,0xfa
L_931724:
	mov_s r0,0x887000
L_93172a:
	st.as r1,[r0,-0x90]
L_93172e:
	mov_s r1,0x0
L_931730:
	st.as r1,[r0,-0x95]
L_931734:
	mov r2,0x7d0
L_931738:
	st.as r2,[r0,-0xac]
L_93173c:
	st r1,[r0, -0x88]
L_931740:
	st r1,[r0, -0x84]
L_931744:
	bl L_931b98
L_931748:
	bl L_9222a0
L_93174c:
	bl L_935a00
L_931750:
	bl.d L_933414
L_931754:
	mov_s r0,0x1
L_931756:
	bl L_9314b8
L_93175a:
	bl L_935ec4
L_93175e:
	ldb_s r0,[gp,-0xf3]
L_931760:
	brne_s r0,0,L_93177e
L_931762:
	ldb_s r0,[gp,-0xf9]
L_931764:
	bmsk_s r0,r0,0x0
L_931766:
	bset_s r0,r0,0x19
L_931768:
	bset_s r0,r0,0x1c
L_93176a:
	bset_s r0,r0,0x1d
L_93176c:
	mov_s r32,r0
L_93176e:
	st.ab r0,[r25,0x4]
L_931772:
	bclr r25,r25,0xa
L_931776:
	ldb_s r0,[gp,-0xf9]
L_931778:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93177a:
	stb r0,[gp, -0xf9]
	.global L_93177e
L_93177e:
	mov_s r0,0x800000
L_931784:
	bl.d L_92ce90
L_931788:
	mov_s r25,r0
L_93178a:
	bl.d L_92a680
L_93178e:
	mov_s r0,0x1
L_931790:
	mov_s r1,0x64
L_931792:
	mov_s r0,0x886d00
L_931798:
	st_s r1,[r0,0x64]
L_93179a:
	mov_s r0,0x1388
L_9317a0:
	bl.d L_9304bc
L_9317a4:
	mov_s r1,0x1
L_9317a6:
	mov_s r1,0x886200
L_9317ac:
	ld_s r0,[r1,0x50]
L_9317ae:
	bclr_s r0,r0,0x10
L_9317b0:
	st_s r0,[r1,0x50]
L_9317b2:
	mov_s r0,0x280000e1
L_9317b8:
	mov_s r32,r0
L_9317ba:
	st.ab r0,[r25,0x4]
L_9317be:
	bclr r25,r25,0xa
L_9317c2:
	bl L_927ec0
L_9317c6:
	mov_s r0,0x801e94
L_9317cc:
	bl L_927ecc
L_9317d0:
	mov_s r0,0x801ed0
L_9317d6:
	bl L_9280c4
L_9317da:
	mov_s r0,0x3000030
L_9317e0:
	mov_s r32,r0
L_9317e2:
	st.ab r0,[r25,0x4]
L_9317e6:
	bclr r25,r25,0xa
L_9317ea:
	pop_s blink
L_9317ec:
	j_s [blink]
L_9317ee:
	nop_s
