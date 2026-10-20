/* aw__open_event_mask @ 0x921450, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__start_window
 * Зовёт сам: mac__ddc_mask_all_on, pm__event_mask_save_all_on
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__open_event_mask
aw__open_event_mask:
	.global L_921450
L_921450:
	st.a blink,[sp,-0x4]
L_921454:
	bl L_92732c
L_921458:
	bl L_92dc6c
L_92145c:
	pop_s blink
L_92145e:
	j_s [blink]
