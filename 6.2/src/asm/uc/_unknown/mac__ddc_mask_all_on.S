/* mac__ddc_mask_all_on @ 0x92732c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__open_event_mask
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__ddc_mask_all_on
mac__ddc_mask_all_on:
	.global L_92732c
L_92732c:
	mov_s r1,0xf
L_92732e:
	mov_s r0,0x886d80
L_927334:
	st_s r1,[r0,0x5c]
L_927336:
	j_s [blink]
