/* rf_chain_dist_config @ 0x8f2784, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_w_s0_w12, bf_w_s0_w4, bf_w_s12_w12, bf_w_s16_w12, bf_w_s4_w12, mac_indirect__write_entry, rf_chain__program_sector_desc, rf_chain__zero_and_program, tx_queue__config_by_mode, tx_queue__config_by_mode_b
 */
	.section .text.rf_chain_dist_config,"ax",@progbits
	.global rf_chain_dist_config
rf_chain_dist_config:
	.global L_8f2784
L_8f2784:
	push_s blink
L_8f2786:
	bl.d L_8c02c0
L_8f278a:
	mov_s r1,0xa
L_8f278c:
	sub_s sp,sp,0x60
L_8f278e:
	mov_s r14,0x0
L_8f2790:
	mov_s r13,sp
L_8f2792:
	mov_s r0,r13
L_8f2794:
	mov_s r2,r14
L_8f2796:
	mov_s r3,r14
L_8f2798:
	mov_s r4,r1
L_8f279a:
	bl.d L_8f2474
L_8f279e:
	mov_s r5,r14
L_8f27a0:
	mov_s r0,r13
L_8f27a2:
	mov_s r1,0x1f
L_8f27a4:
	mov_s r13,0x2
L_8f27a6:
	mov_s r2,r13
L_8f27a8:
	mov_s r3,r14
L_8f27aa:
	mov_s r4,r14
L_8f27ac:
	mov_s r5,r14
L_8f27ae:
	mov r6,0x1
L_8f27b2:
	bl.d L_8c46a4
L_8f27b6:
	mov r7,r6
L_8f27ba:
	add_s r15,sp,0x10
L_8f27bc:
	mov_s r0,r15
L_8f27be:
	bl.d L_8f2074
L_8f27c2:
	mov_s r1,0xa
L_8f27c4:
	mov_s r0,r15
L_8f27c6:
	mov_s r1,0x1f
L_8f27c8:
	mov_s r2,r13
L_8f27ca:
	mov_s r3,r14
L_8f27cc:
	mov_s r4,r14
L_8f27ce:
	mov_s r5,r14
L_8f27d0:
	mov_s r6,r13
L_8f27d2:
	bl.d L_8c46a4
L_8f27d6:
	mov r7,0x1
L_8f27da:
	add_s r15,sp,0x20
L_8f27dc:
	mov_s r0,r15
L_8f27de:
	mov_s r1,0xa
L_8f27e0:
	mov_s r2,r14
L_8f27e2:
	mov_s r3,0x6
L_8f27e4:
	mov_s r4,r14
L_8f27e6:
	bl.d L_8f22fc
L_8f27ea:
	mov_s r5,r14
L_8f27ec:
	mov_s r0,r15
L_8f27ee:
	mov_s r1,0x1f
L_8f27f0:
	mov_s r2,r13
L_8f27f2:
	mov_s r3,0x3
L_8f27f4:
	mov_s r4,r14
L_8f27f6:
	mov_s r5,r14
L_8f27f8:
	mov_s r6,r14
L_8f27fa:
	bl.d L_8c46a4
L_8f27fe:
	mov_s r7,r3
L_8f2800:
	stw r14,[sp, 0x50]
L_8f2804:
	stw r14,[sp, 0x52]
L_8f2808:
	stw r14,[sp, 0x56]
L_8f280c:
	add_s r0,sp,0x58
L_8f280e:
	mov_s r1,r13
L_8f2810:
	bl.d L_8e8318
L_8f2814:
	stw r14,[sp, 0x54]
L_8f2818:
	mov r1,0x1ff
L_8f281c:
	bl.d L_8e8378
L_8f2820:
	mov_s r2,r13
L_8f2822:
	mov_s r0,0xff
L_8f2824:
	stb r0,[sp, 0x5b]
L_8f2828:
	add_s r0,sp,0x5c
L_8f282a:
	mov_s r1,0x1
L_8f282c:
	bl.d L_8e8348
L_8f2830:
	mov_s r3,r14
L_8f2832:
	mov r1,0x1ff
L_8f2836:
	bl.d L_8e83c0
L_8f283a:
	mov_s r4,r14
L_8f283c:
	mov_s r1,0x1
L_8f283e:
	bl.d L_8e84c8
L_8f2842:
	mov_s r5,r14
L_8f2844:
	add_s r0,sp,0x50
L_8f2846:
	mov_s r1,0x1f
L_8f2848:
	mov_s r6,r14
L_8f284a:
	bl.d L_8c46a4
L_8f284e:
	mov r7,0x1
L_8f2852:
	bl.d L_8e5000
L_8f2856:
	mov r0,0x1ff
L_8f285a:
	b.d L_8c032c
L_8f285e:
	add_s sp,sp,0x60
