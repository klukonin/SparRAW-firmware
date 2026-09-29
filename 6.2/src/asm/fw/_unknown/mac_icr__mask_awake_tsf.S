/* mac_icr__mask_awake_tsf @ 0x8e9a90, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_06
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_icr__mask_awake_tsf
mac_icr__mask_awake_tsf:
	.global L_8e9a90
L_8e9a90:
	mov_s r0,0x886e00
L_8e9a96:
	st 0x8000,[r0, 0x50]
L_8e9a9e:
	j_s [blink]
