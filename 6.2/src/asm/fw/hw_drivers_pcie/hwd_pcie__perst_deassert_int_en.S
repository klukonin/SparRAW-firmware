/* hwd_pcie__perst_deassert_int_en @ 0x8d1998, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__perst_deassert_int_en
hwd_pcie__perst_deassert_int_en:
	.global L_8d1998
L_8d1998:
	mov_s r1,0x20
L_8d199a:
	mov_s r0,0x882680
L_8d19a0:
	st_s r1,[r0,0x4]
L_8d19a2:
	j_s [blink]
