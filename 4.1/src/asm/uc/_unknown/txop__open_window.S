/* txop__open_window @ 0x93409c, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r13_ret_uc, mac__build_tx_common_params, mac__cmd_29000001, mac__select_all_sectors_and_wait
 */
	.section .text.txop__open_window,"ax",@progbits
	.global txop__open_window
txop__open_window:
	.global L_93409c
L_93409c:
	push_s blink
L_93409e:
	push_s r13
L_9340a0:
	ld_s r0,[gp,-0x44]
L_9340a2:
	mov_s r13,r1
L_9340a4:
	and r0,r0,0xffff0fff
L_9340ac:
	bset r1,r0,0xd
L_9340b0:
	bset_s r1,r1,0xf
L_9340b2:
	st.as r1,[gp,-0x11]
L_9340b6:
	or r0,r0,0x1d00a000
L_9340be:
	mov_s r32,r0
L_9340c0:
	st.ab r0,[r25,0x4]
L_9340c4:
	bclr r25,r25,0xa
L_9340c8:
	bl L_931980
L_9340cc:
	bl L_931640
L_9340d0:
	mov_s r1,r40
L_9340d2:
	mov_s r0,r42
L_9340d4:
	bbit1 r0,0xe,L_9340dc
L_9340d8:
	bbit1 r1,0x18,L_9340f0
	.global L_9340dc
L_9340dc:
	mov_s r0,0x29000002
L_9340e2:
	mov_s r32,r0
L_9340e4:
	st.ab r0,[r25,0x4]
L_9340e8:
	bclr r25,r25,0xa
L_9340ec:
	mov_s r0,0x0
L_9340ee:
	b_s L_934136
	.global L_9340f0
L_9340f0:
	ld_s r1,[r13,0x8]
L_9340f2:
	mov_s r0,0x5
L_9340f4:
	ld_s r2,[r13]
L_9340f6:
	bl.d L_92bb2c
L_9340fa:
	ld_s r3,[r13,0x4]
L_9340fc:
	mov_s r0,0x2008000
L_934102:
	mov_s r32,r0
L_934104:
	st.ab r0,[r25,0x4]
L_934108:
	bclr r25,r25,0xa
L_93410c:
	mov_s r0,0x19000001
L_934112:
	mov_s r32,r0
L_934114:
	st.ab r0,[r25,0x4]
L_934118:
	bclr r25,r25,0xa
L_93411c:
	lsr r0,r43,0x1a
L_934120:
	bmsk_s r0,r0,0x0
L_934122:
	asl_s r0,r0,0xb
L_934124:
	bset_s r0,r0,0xe
L_934126:
	bset_s r0,r0,0x1b
L_934128:
	bset_s r0,r0,0x1c
L_93412a:
	mov_s r32,r0
L_93412c:
	st.ab r0,[r25,0x4]
L_934130:
	bclr r25,r25,0xa
L_934134:
	mov_s r0,0x1
	.global L_934136
L_934136:
	b L_92028c
L_93413a:
	nop_s
