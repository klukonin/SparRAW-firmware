/* pm__wake_sequence @ 0x925184, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_dti__wake_and_evaluate_sleep
 * Зовёт сам: pm__event_mask_restore, set_reg_886ddc_9259fc, uc_pending__clear_bit
 */
	.section .text.pm__wake_sequence,"ax",@progbits
	.global pm__wake_sequence
pm__wake_sequence:
	.global L_925184
L_925184:
	st.a blink,[sp,-0x4]
L_925188:
	bl.d L_928f6c
L_92518c:
	mov r0,0x0
L_925190:
	mov_s r0,0x49008000
L_925196:
	mov_s r32,r0
L_925198:
	st.ab r0,[r25,0x4]
L_92519c:
	bclr r25,r25,0xa
L_9251a0:
	bl L_9259fc
L_9251a4:
	bl L_92a69c
L_9251a8:
	pop_s blink
L_9251aa:
	j_s [blink]
