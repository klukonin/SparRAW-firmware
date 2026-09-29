/* memset0_words_uc @ 0x920a84, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_tbtt_set_step, aw_worker__collect_awake_peers, bf__init_globals, bf__reset_sta, bf__reset_sta_slot, bf_init_sm, bf_metrics__reset_and_stamp, bi_ctx__clear_counters, bi_ctx__clear_state_words, bi_manager_step_a
 * Зовёт сам: __ld_r13_to_r13_ret, memset_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global memset0_words_uc
memset0_words_uc:
	.global L_920a84
L_920a84:
	mov.f r2,r1
L_920a88:
	push_s blink
L_920a8a:
	push_s r13
L_920a8c:
	beq_s L_920b0e
L_920a8e:
	bmsk.f 0x0,r0,0x1
L_920a92:
	bne_s L_920aa4
L_920a94:
	bmsk.f 0x0,r2,0x1
L_920a98:
	bne_s L_920aa4
L_920a9a:
	lsr_s r2,r2,0x2
L_920a9c:
	brhs r2,0x8,L_920aac
L_920aa0:
	mov_s r1,0x0
L_920aa2:
	b_s L_920ab2
	.global L_920aa4
L_920aa4:
	bl.d L_92d834
L_920aa8:
	mov_s r1,0x0
L_920aaa:
	b_s L_920b0e
	.global L_920aac
L_920aac:
	sub_s r1,r2,0x1
L_920aae:
	lsr_s r1,r1,0x3
L_920ab0:
	bmsk_s r2,r2,0x2
	.global L_920ab2
L_920ab2:
	brhs r2,0x8,L_920b0e
L_920ab6:
	ldb.x r2,[0x801be0,r2]
L_920abe:
	add r13,pcl,0xc
L_920ac2:
	add1_s r13,r13,r2
L_920ac4:
	j_s.d [r13]
L_920ac6:
	mov_s r3,0x0
L_920ac8:
	mov_s r2,r0
L_920aca:
	b_s L_920b02
L_920acc:
	mov_s r2,r0
L_920ace:
	b_s L_920afe
L_920ad0:
	mov_s r2,r0
L_920ad2:
	b_s L_920afa
L_920ad4:
	mov_s r2,r0
L_920ad6:
	b_s L_920af6
L_920ad8:
	mov_s r2,r0
L_920ada:
	b_s L_920af2
L_920adc:
	mov_s r2,r0
L_920ade:
	b_s L_920aee
L_920ae0:
	mov_s r2,r0
L_920ae2:
	b_s L_920aea
L_920ae4:
	mov_s r2,r0
	.global L_920ae6
L_920ae6:
	st.ab r3,[r2,0x4]
	.global L_920aea
L_920aea:
	st.ab r3,[r2,0x4]
	.global L_920aee
L_920aee:
	st.ab r3,[r2,0x4]
	.global L_920af2
L_920af2:
	st.ab r3,[r2,0x4]
	.global L_920af6
L_920af6:
	st.ab r3,[r2,0x4]
	.global L_920afa
L_920afa:
	st.ab r3,[r2,0x4]
	.global L_920afe
L_920afe:
	st.ab r3,[r2,0x4]
	.global L_920b02
L_920b02:
	cmp_s r1,0x0
L_920b04:
	st.ab r3,[r2,0x4]
L_920b08:
	sub.gt r1,r1,0x1
L_920b0c:
	bgt_s L_920ae6
	.global L_920b0e
L_920b0e:
	b L_9202ac
L_920b12:
	nop_s
