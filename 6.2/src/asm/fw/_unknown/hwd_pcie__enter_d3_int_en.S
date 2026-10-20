/* hwd_pcie__enter_d3_int_en @ 0x8d1240, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__enter_d3_int_en
hwd_pcie__enter_d3_int_en:
	.global L_8d1240
L_8d1240:
	mov_s r0,0x882680
L_8d1246:
	st 0x20000000,[r0, 0x4]
L_8d124e:
	j_s [blink]
