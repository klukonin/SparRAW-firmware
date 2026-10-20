/* mac__read_tsf_hi @ 0x8e49e4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__start_33khz_measure
 * Зовёт сам: mac_read_tsf64
 */
	.section .text.mac__read_tsf_hi,"ax",@progbits
	.global mac__read_tsf_hi
mac__read_tsf_hi:
	.global L_8e49e4
L_8e49e4:
	push_s blink
L_8e49e6:
	sub_s sp,sp,0x8
L_8e49e8:
	mov_s r1,sp
L_8e49ea:
	bl.d L_8e4840
L_8e49ee:
	mov_s r2,0x0
L_8e49f0:
	add_s sp,sp,0x8
L_8e49f2:
	pop_s blink
L_8e49f4:
	j_s [blink]
L_8e49f6:
	nop_s
