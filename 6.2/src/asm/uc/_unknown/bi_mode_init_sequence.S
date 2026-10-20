/* bi_mode_init_sequence @ 0x9365fc, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BCON
 * Зовут его: boot_uc__init_g800610
 * Зовёт сам: bf__init_globals, bi_ctx__clear_counters, bi_ctx__set_active, bi_init__set_mac_arg_pair, bi_mode__init_sta_table, bi_mode__load_cmd1e_operand, bi_mode__program_mac_timing, bi_mode_init_substep, bi_sm__init, bti__clear_sweep_counters, mac__set_slot_timing_886f60, rx_nav__set_flag_b1_if_enabled
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_mode_init_sequence
bi_mode_init_sequence:
	.global L_9365fc
L_9365fc:
	push_s blink
L_9365fe:
	bl L_9364ec
L_936602:
	mov_s r1,0xfa
L_936604:
	mov_s r0,0x887000
L_93660a:
	st.as r1,[r0,-0x90]
L_93660e:
	mov_s r1,0x0
L_936610:
	st.as r1,[r0,-0x95]
L_936614:
	mov r2,0x7d0
L_936618:
	st.as r2,[r0,-0xac]
L_93661c:
	st r1,[r0, -0x88]
L_936620:
	st r1,[r0, -0x84]
L_936624:
	bl L_936a94
L_936628:
	bl L_9219c8
L_93662c:
	bl L_93b40c
L_936630:
	bl.d L_9384d4
L_936634:
	mov_s r0,0x1
L_936636:
	bl L_936398
L_93663a:
	bl L_93b908
L_93663e:
	ldb_s r0,[gp,-0xf2]
L_936640:
	brne_s r0,0,L_93665e
L_936642:
	ldb_s r0,[gp,-0xf9]
L_936644:
	bmsk_s r0,r0,0x0
L_936646:
	bset_s r0,r0,0x19
L_936648:
	bset_s r0,r0,0x1c
L_93664a:
	bset_s r0,r0,0x1d
L_93664c:
	mov_s r32,r0
L_93664e:
	st.ab r0,[r25,0x4]
L_936652:
	bclr r25,r25,0xa
L_936656:
	ldb_s r0,[gp,-0xf9]
L_936658:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93665a:
	stb r0,[gp, -0xf9]
	.global L_93665e
L_93665e:
	mov_s r0,0x800000
L_936664:
	bl.d L_930dc8
L_936668:
	mov_s r25,r0
L_93666a:
	bl.d L_92dcbc
L_93666e:
	mov_s r0,0x1
L_936670:
	mov_s r1,0x64
L_936672:
	mov_s r0,0x886d00
L_936678:
	st_s r1,[r0,0x64]
L_93667a:
	mov_s r0,0x1388
L_936680:
	bl.d L_934e0c
L_936684:
	mov_s r1,0x1
L_936686:
	mov_s r1,0x886200
L_93668c:
	ld_s r0,[r1,0x50]
L_93668e:
	bclr_s r0,r0,0x10
L_936690:
	st_s r0,[r1,0x50]
L_936692:
	mov_s r0,0x280000e1
L_936698:
	mov_s r32,r0
L_93669a:
	st.ab r0,[r25,0x4]
L_93669e:
	bclr r25,r25,0xa
L_9366a2:
	bl L_92acf8
L_9366a6:
	mov_s r0,0x802f44
L_9366ac:
	bl L_92ad00
L_9366b0:
	mov_s r0,0x802f80
L_9366b6:
	bl L_92ae1c
L_9366ba:
	mov_s r0,0x3000030
L_9366c0:
	mov_s r32,r0
L_9366c2:
	st.ab r0,[r25,0x4]
L_9366c6:
	bclr r25,r25,0xa
L_9366ca:
	pop_s blink
L_9366cc:
	j_s [blink]
L_9366ce:
	nop_s
