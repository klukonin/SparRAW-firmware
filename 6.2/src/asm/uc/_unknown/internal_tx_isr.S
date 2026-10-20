/* internal_tx_isr @ 0x92bbfc, 308 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   internal TX pending sm = %d
 *   internal_tx_isr() Postpone TxSS for sta_id %d, not enough time in current BI (bi_counter_val=%d, txss_duration=%d
 * Зовут его: tx_initiator_flow_fixed_scheduling, tx_non_data_flow_fixed_scheduling, tx_slot__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_pending__set_bit, bf_sm__run_sta, bi_tx__check_idle_and_start_uc, internal_tx__clear_exclude_mask, internal_tx__clear_pending_bit, internal_tx__flow_sm2, internal_tx__flow_sm4, internal_tx__flow_sm6, internal_tx__noop_isr_hook, txss__sweep_duration_for_sta
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx_isr
internal_tx_isr:
	.global L_92bbfc
L_92bbfc:
	push_s blink
L_92bbfe:
	bl L_920234
L_92bc02:
	mov_s r14,r0
L_92bc04:
	mov_s r13,0x8006cc
L_92bc0a:
	ld_s r0,[r13]
L_92bc0c:
	cmp_s r0,0x0
L_92bc0e:
	mov.eq r0,blink
L_92bc12:
	mov.eq r1,0x61
L_92bc1a:
	bl.eq L_926618
L_92bc1e:
	ld_s r0,[r13]
L_92bc20:
	ld_s r1,[r13,0x8]
L_92bc22:
	bic_s r0,r0,r1
L_92bc24:
	norm r0,r0
L_92bc28:
	bl.d L_92ba48
L_92bc2c:
	rsub r13,r0,0x1e
L_92bc30:
	mov_s r1,0x10018cc
L_92bc36:
	mov_s r0,0x21
L_92bc38:
	bl.d L_92d1d0
L_92bc3c:
	mov_s r2,r13
L_92bc3e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_92bc40:
	cmp_s r13,0x5
L_92bc42:
	bhi L_92bd2c
L_92bc46:
	ldb.x r13,[0x801a94,r13]
L_92bc4e:
	add r0,pcl,0xa
L_92bc52:
	add1_s r0,r0,r13
L_92bc54:
	j_s [r0]
L_92bc56:
	mov_s r0,0x802f80
L_92bc5c:
	bl L_93d348
L_92bc60:
	b_s L_92bd2c
L_92bc62:
	bl.d L_93783c
L_92bc66:
	mov_s r0,r14
L_92bc68:
	b_s L_92bd2c
L_92bc6a:
	bl L_939100
L_92bc6e:
	b_s L_92bd2c
L_92bc70:
	bl L_926cc4
L_92bc74:
	b_s L_92bd2c
L_92bc76:
	ld_s r0,[gp,-0x44]
L_92bc78:
	and r0,r0,0xffff0fff
L_92bc80:
	bset r1,r0,0xe
L_92bc84:
	or r0,r0,0x1d004000
L_92bc8c:
	st.as r1,[gp,-0x11]
L_92bc90:
	mov_s r32,r0
L_92bc92:
	st.ab r0,[r25,0x4]
L_92bc96:
	bclr r25,r25,0xa
L_92bc9a:
	nop_s
L_92bc9c:
	nop_s
L_92bc9e:
	nop_s
L_92bca0:
	bmsk r13,r40,0x19
L_92bca4:
	bl.d L_939cfc
L_92bca8:
	ld_s r0,[gp,-0xb8]
L_92bcaa:
	mov_s r1,0x8014a4
L_92bcb0:
	ld_s r1,[r1,0x1c]
L_92bcb2:
	mov_s r14,r0
L_92bcb4:
	mov_s r0,0x1
L_92bcb6:
	brne_s r1,0,L_92bcc4
L_92bcb8:
	mov_s r1,0x80212c
L_92bcbe:
	ldb r1,[r1, 0x68]
L_92bcc2:
	breq_s r1,0,L_92bd08
	.global L_92bcc4
L_92bcc4:
	mov_s r0,0x80229c
L_92bcca:
	ld_s r0,[r0,0x8]
L_92bccc:
	breq_s r0,0,L_92bcd4
L_92bcce:
	sub_s r0,r0,r13
L_92bcd0:
	brlo r0,r14,L_92bcd8
	.global L_92bcd4
L_92bcd4:
	mov_s r0,0x1
L_92bcd6:
	b_s L_92bd08
	.global L_92bcd8
L_92bcd8:
	mov_s r1,0x10018e8
L_92bcde:
	mov_s r0,0x21
L_92bce0:
	ld.as r2,[gp,-0x2e]
L_92bce4:
	mov_s r3,r13
L_92bce6:
	bl.d L_92d338
L_92bcea:
	mov_s r4,r14
L_92bcec:
	mov_s r1,0x8006cc
L_92bcf2:
	ld_s r0,[r1,0xc]
L_92bcf4:
	brne r0,0x1,L_92bcfe
L_92bcf8:
	ld_s r0,[r1,0x10]
L_92bcfa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92bcfc:
	b_s L_92bd00
	.global L_92bcfe
L_92bcfe:
	mov_s r0,0x1
	.global L_92bd00
L_92bd00:
	st_s r0,[r1,0x10]
L_92bd02:
	mov_s r0,0x1
L_92bd04:
	st_s r0,[r1,0xc]
L_92bd06:
	mov_s r0,0x0
	.global L_92bd08
L_92bd08:
	breq_s r0,0,L_92bd26
L_92bd0a:
	bl.d L_921940
L_92bd0e:
	ld_s r0,[gp,-0xb8]
L_92bd10:
	bl.d L_92bd70
L_92bd14:
	mov_s r0,0x3
L_92bd16:
	bl.d L_9216f8
L_92bd1a:
	mov_s r0,0x1
L_92bd1c:
	mov_s r1,0x0
L_92bd1e:
	mov_s r0,0x8006cc
L_92bd24:
	st_s r1,[r0,0xc]
	.global L_92bd26
L_92bd26:
	bl.d L_93696c
L_92bd2a:
	mov_s r0,0x2
	.global L_92bd2c
L_92bd2c:
	b L_9202a4
