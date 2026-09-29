/* set_reg_886ddc_9259fc @ 0x9259fc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pm__wake_sequence, uc_send_evt__ucode_ready
 */
	.section .text.set_reg_886ddc_9259fc,"ax",@progbits
	.global set_reg_886ddc_9259fc
set_reg_886ddc_9259fc:
	.global L_9259fc
L_9259fc:
	mov_s r1,0x8
L_9259fe:
	mov_s r0,0x886d80
L_925a04:
	st_s r1,[r0,0x5c]
L_925a06:
	j_s [blink]
