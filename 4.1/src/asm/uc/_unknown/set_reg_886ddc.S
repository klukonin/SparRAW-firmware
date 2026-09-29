/* set_reg_886ddc @ 0x9259cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__open_event_mask
 */
	.section .text.set_reg_886ddc,"ax",@progbits
	.global set_reg_886ddc
set_reg_886ddc:
	.global L_9259cc
L_9259cc:
	mov_s r1,0xf
L_9259ce:
	mov_s r0,0x886d80
L_9259d4:
	st_s r1,[r0,0x5c]
L_9259d6:
	j_s [blink]
