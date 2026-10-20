/* pm__wake_sequence @ 0x9262c0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__dti_step
 * Зовёт сам: internal_tx__clear_pending_bit, mac__ddc_mask_bit3, pm__event_mask_restore
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global pm__wake_sequence
pm__wake_sequence:
	.global L_9262c0
L_9262c0:
	st.a blink,[sp,-0x4]
L_9262c4:
	bl.d L_92bd70
L_9262c8:
	mov r0,0x0
L_9262cc:
	mov_s r0,0x49008000
L_9262d2:
	mov_s r32,r0
L_9262d4:
	st.ab r0,[r25,0x4]
L_9262d8:
	bclr r25,r25,0xa
L_9262dc:
	bl L_92735c
L_9262e0:
	bl L_92dcd8
L_9262e4:
	pop_s blink
L_9262e6:
	j_s [blink]
