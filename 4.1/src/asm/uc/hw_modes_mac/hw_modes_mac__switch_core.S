/* hw_modes_mac__switch_core @ 0x927944, 540 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_modes_mac.c
 * Зовут его: abft_responder_worker, mac__switch_core_and_setup_dma, mac_mode__enter_idle_seq, mac_mode__switch_after_ppdu, mac_mode__switch_core_and_rf, mac_mode_program_a, mac_mode_program_b, mac_mode_program_c, rx__switch_to_rx_mode, rx_funcs__handle_ppdu_report
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x80057c, 0x800594, 0x800598
 */
	.section .text.hw_modes_mac__switch_core,"ax",@progbits
	.global hw_modes_mac__switch_core
hw_modes_mac__switch_core:
	.global L_927944
L_927944:
	st.a r13,[sp,-0x8]
L_927948:
	st_s r14,[sp,0x4]
L_92794a:
	mov_s r14,blink
L_92794c:
	mov r5,0x0
L_927950:
	ld_s r0,[gp,-0x44]
L_927952:
	st.as r5,[gp,-0x1f]
L_927956:
	and r0,r0,0xffff0fff
L_92795e:
	or r4,r0,0xa000
L_927966:
	st.as r4,[gp,-0x11]
L_92796a:
	or r0,r0,0x1d00a000
L_927972:
	mov_s r32,r0
L_927974:
	st.ab r0,[r25,0x4]
L_927978:
	bclr r25,r25,0xa
L_92797c:
	nop_s
L_92797e:
	nop_s
L_927980:
	nop_s
L_927982:
	lsr r2,r49,0x10
L_927986:
	bmsk_s r2,r2,0x3
L_927988:
	cmp r2,0x6
L_92798c:
	bcc L_927a78
	.global L_927990
L_927990:
	mov_s r3,r40
L_927992:
	bbit0 r3,0x18,L_927990
L_927996:
	nop_s
L_927998:
	mov r13,r40
	.global L_92799c
L_92799c:
	mov r7,r40
L_9279a0:
	bbit1 r7,0x3,L_92799c
L_9279a4:
	mov 0x0,0x0
L_9279a8:
	mov r9,0x3d000004
L_9279b0:
	mov r32,r9
L_9279b4:
	st.ab r9,[r25,0x4]
L_9279b8:
	bclr r25,r25,0xa
L_9279bc:
	nop_s
L_9279be:
	nop_s
L_9279c0:
	mov 0x0,0x0
L_9279c4:
	st.as r49,[gp,-0x20]
L_9279c8:
	mov r9,r40
L_9279cc:
	bbit1 r9,0x3,L_927a60
	.global L_9279d0
L_9279d0:
	mov r10,r40
L_9279d4:
	bbit1 r10,0x18,L_9279ec
L_9279d8:
	mov_s r0,blink
L_9279da:
	mov_s r2,0x1003438
L_9279e0:
	mov r1,0x94
L_9279e4:
	bl.d L_925548
L_9279e8:
	mov r3,0x3d
	.global L_9279ec
L_9279ec:
	mov r8,0x2080000
L_9279f4:
	mov r32,r8
L_9279f8:
	st.ab r8,[r25,0x4]
L_9279fc:
	bclr r25,r25,0xa
L_927a00:
	mov r2,0x1
L_927a04:
	ld.as r8,[gp,-0x11]
L_927a08:
	stb r2,[gp, -0xf6]
L_927a0c:
	and r8,r8,0xffff0fff
L_927a14:
	or r11,r8,0xa000
L_927a1c:
	st.as r11,[gp,-0x11]
L_927a20:
	or r8,r8,0x1d00a000
L_927a28:
	mov r32,r8
L_927a2c:
	st.ab r8,[r25,0x4]
L_927a30:
	bclr r25,r25,0xa
L_927a34:
	nop_s
L_927a36:
	nop_s
L_927a38:
	mov 0x0,0x0
L_927a3c:
	lsr r9,r40,0x8
L_927a40:
	bmsk r9,r9,0x5
L_927a44:
	bbit0.d r13,0x3,L_927a58
L_927a48:
	st.as r9,[gp,0x15]
L_927a4c:
	ld.as r4,[gp,0x1b]
L_927a50:
	add r4,r4,0x1
L_927a54:
	st.as r4,[gp,0x1b]
	.global L_927a58
L_927a58:
	b.d L_927b54
L_927a5c:
	mov r0,0x1
	.global L_927a60
L_927a60:
	mov_s r0,blink
L_927a62:
	mov_s r2,0x1003438
L_927a68:
	mov r1,0x93
L_927a6c:
	bl.d L_925548
L_927a70:
	mov r3,0x3b
L_927a74:
	b L_9279d0
	.global L_927a78
L_927a78:
	mov r1,0x1
L_927a7c:
	st.as r1,[gp,-0x1f]
	.global L_927a80
L_927a80:
	lsr r6,r49,0x10
L_927a84:
	bmsk r6,r6,0x3
L_927a88:
	brlo r6,0x6,L_927a98
L_927a8c:
	lsr r7,r49,0x10
L_927a90:
	bmsk r7,r7,0x3
L_927a94:
	brlo r7,0xe,L_927a80
	.global L_927a98
L_927a98:
	mov_s r3,r40
L_927a9a:
	bbit0 r3,0x18,L_927a98
L_927a9e:
	nop_s
	.global L_927aa0
L_927aa0:
	mov_s r0,r40
L_927aa2:
	bbit1 r0,0x3,L_927aa0
L_927aa6:
	nop_s
L_927aa8:
	nop_s
L_927aaa:
	nop_s
L_927aac:
	mov r7,0x3d000004
L_927ab4:
	mov r32,r7
L_927ab8:
	st.ab r7,[r25,0x4]
L_927abc:
	bclr r25,r25,0xa
L_927ac0:
	nop_s
L_927ac2:
	nop_s
L_927ac4:
	mov 0x0,0x0
L_927ac8:
	mov r6,r40
L_927acc:
	bbit0 r6,0x18,L_927ad8
L_927ad0:
	mov r5,r40
L_927ad4:
	bbit0 r5,0x3,L_927aec
	.global L_927ad8
L_927ad8:
	mov_s r0,blink
L_927ada:
	mov_s r2,0x1003438
L_927ae0:
	mov r1,0x8d
L_927ae4:
	bl.d L_925548
L_927ae8:
	mov r3,0x61
	.global L_927aec
L_927aec:
	mov r6,0x2080000
L_927af4:
	mov r32,r6
L_927af8:
	st.ab r6,[r25,0x4]
L_927afc:
	bclr r25,r25,0xa
L_927b00:
	mov r4,0x0
L_927b04:
	ld.as r1,[gp,-0x11]
L_927b08:
	stb r4,[gp, -0xf6]
L_927b0c:
	and r1,r1,0xffff0fff
L_927b14:
	or r2,r1,0xa000
L_927b1c:
	st.as r2,[gp,-0x11]
L_927b20:
	or r1,r1,0x1d00a000
L_927b28:
	mov r32,r1
L_927b2c:
	st.ab r1,[r25,0x4]
L_927b30:
	bclr r25,r25,0xa
L_927b34:
	nop_s
L_927b36:
	nop_s
L_927b38:
	nop_s
L_927b3a:
	lsr r3,r40,0x8
L_927b3e:
	bmsk_s r3,r3,0x5
L_927b40:
	ld.as r5,[gp,0x1c]
L_927b44:
	st.as r3,[gp,0x15]
L_927b48:
	add r5,r5,0x1
L_927b4c:
	st.as r5,[gp,0x1c]
L_927b50:
	mov r0,0x0
	.global L_927b54
L_927b54:
	mov_s blink,r14
L_927b56:
	ld_s r14,[sp,0x4]
L_927b58:
	j.d [blink]
L_927b5c:
	ld.ab r13,[sp,0x8]
