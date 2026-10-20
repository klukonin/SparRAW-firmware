/* mac__ddc_mask_bit3 @ 0x92735c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pm__wake_sequence, uc_send_evt__ucode_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__ddc_mask_bit3
mac__ddc_mask_bit3:
	.global L_92735c
L_92735c:
	mov_s r1,0x8
L_92735e:
	mov_s r0,0x886d80
L_927364:
	st_s r1,[r0,0x5c]
L_927366:
	j_s [blink]
