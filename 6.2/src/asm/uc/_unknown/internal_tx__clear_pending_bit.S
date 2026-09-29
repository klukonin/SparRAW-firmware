/* internal_tx__clear_pending_bit @ 0x92bd70, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__clear_pending_and_notify, bf__flow_exit, bf__reset_sta_slot, bi_rx__slot_handler, internal_tx__clear_pending, internal_tx__flow_sm6, internal_tx__update_state_locked, internal_tx_isr, pm__wake_sequence, ps__release_awake_for_sta
 * Зовёт сам: internal_tx__drop_event_mask_and_publish
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__clear_pending_bit
internal_tx__clear_pending_bit:
	.global L_92bd70
L_92bd70:
	push_s blink
L_92bd72:
	lr r3,[0xa]
L_92bd76:
	bclr r1,r3,0x1
L_92bd7a:
	flag r1
L_92bd7e:
	mov_s r2,0x8006cc
L_92bd84:
	ld_s r1,[r2]
L_92bd86:
	bclr.f r1,r1,r0
L_92bd8a:
	st_s r1,[r2]
L_92bd8c:
	bl.eq L_92bb18
L_92bd90:
	lr r0,[0xa]
L_92bd94:
	bic r3,r3,-0x3
L_92bd98:
	or_s r3,r3,r0
L_92bd9a:
	flag r3
L_92bd9e:
	pop_s blink
L_92bda0:
	j_s [blink]
L_92bda2:
	nop_s
