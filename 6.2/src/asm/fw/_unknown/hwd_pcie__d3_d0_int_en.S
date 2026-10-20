/* hwd_pcie__d3_d0_int_en @ 0x8d11a8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__d3_d0_int_en
hwd_pcie__d3_d0_int_en:
	.global L_8d11a8
L_8d11a8:
	mov_s r0,0x882680
L_8d11ae:
	st 0x1000000,[r0, 0x4]
L_8d11b6:
	j_s [blink]
