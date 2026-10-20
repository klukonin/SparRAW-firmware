/* rx__enter_listen_mode @ 0x93c818, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qset1_mask__any_pending_uc
 * Зовёт сам: grant_detect_step, mac__set_mode_0000, rx_listen__set_flag_and_stamp_tsf, rx_mode__configure, uc_sysassert, uc_wait_two_events
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__enter_listen_mode
rx__enter_listen_mode:
	.global L_93c818
L_93c818:
	push_s blink
L_93c81a:
	bl L_93e0dc
L_93c81e:
	mov_s r0,0x3
L_93c820:
	bl.d L_92f4bc
L_93c824:
	mov_s r1,0xff
L_93c826:
	mov_s r0,0x0
L_93c828:
	mov_s r1,0x1
L_93c82a:
	bl.d L_92db88
L_93c82e:
	mov_s r2,r1
L_93c830:
	bl L_93c864
L_93c834:
	mov_s r1,0x8014c8
L_93c83a:
	ld_s r0,[r1,0x4]
L_93c83c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93c83e:
	st_s r0,[r1,0x4]
L_93c840:
	mov_s r0,0x5
L_93c842:
	mov_s r1,r0
L_93c844:
	bl.d L_936594
L_93c848:
	mov_s r2,0xa
L_93c84a:
	nop_s
L_93c84c:
	nop_s
L_93c84e:
	nop_s
L_93c850:
	mov_s r0,r42
L_93c852:
	btst_s r0,0xe
L_93c854:
	mov.eq r0,blink
L_93c858:
	bl.eq.d L_926618
L_93c85c:
	mov.eq r1,0x10
L_93c860:
	pop_s blink
L_93c862:
	j_s [blink]
