/* aw__open_event_mask @ 0x921c2c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__begin_window
 * Зовёт сам: pm__event_mask_save_all_on, set_reg_886ddc
 */
	.section .text.aw__open_event_mask,"ax",@progbits
	.global aw__open_event_mask
aw__open_event_mask:
	.global L_921c2c
L_921c2c:
	st.a blink,[sp,-0x4]
L_921c30:
	bl L_9259cc
L_921c34:
	bl L_92a630
L_921c38:
	pop_s blink
L_921c3a:
	j_s [blink]
