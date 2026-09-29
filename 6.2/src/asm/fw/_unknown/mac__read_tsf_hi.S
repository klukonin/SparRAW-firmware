/* mac__read_tsf_hi @ 0x8e9aa0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__start_33khz_measure
 * Зовёт сам: mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_tsf_hi
mac__read_tsf_hi:
	.global L_8e9aa0
L_8e9aa0:
	push_s blink
L_8e9aa2:
	sub_s sp,sp,0x8
L_8e9aa4:
	mov_s r1,sp
L_8e9aa6:
	bl.d L_8e9900
L_8e9aaa:
	mov_s r2,0x0
L_8e9aac:
	add_s sp,sp,0x8
L_8e9aae:
	pop_s blink
L_8e9ab0:
	j_s [blink]
L_8e9ab2:
	nop_s
