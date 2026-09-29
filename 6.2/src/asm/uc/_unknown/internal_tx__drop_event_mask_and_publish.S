/* internal_tx__drop_event_mask_and_publish @ 0x92bb18, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__clear_pending_bit
 * Зовёт сам: mac__publish_masks
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__drop_event_mask_and_publish
internal_tx__drop_event_mask_and_publish:
	.global L_92bb18
L_92bb18:
	ld_s r0,[gp,-0x7c]
L_92bb1a:
	mov_s r1,0x886f00
L_92bb20:
	bclr_s r0,r0,0x7
L_92bb22:
	st.as r0,[gp,-0x1f]
L_92bb26:
	ld_s r0,[gp,-0x60]
L_92bb28:
	bmsk_s r0,r0,0x1e
L_92bb2a:
	st.as r0,[gp,-0x18]
L_92bb2e:
	st_s r0,[r1,0x5c]
L_92bb30:
	b L_93d0ac
