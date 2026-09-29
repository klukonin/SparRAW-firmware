/* hwd_pcie__perst_deassert_int_clear @ 0x8d198c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__perst_deassert_int_clear
hwd_pcie__perst_deassert_int_clear:
	.global L_8d198c
L_8d198c:
	mov_s r1,0x20
L_8d198e:
	mov_s r0,0x882600
L_8d1994:
	st_s r1,[r0,0x70]
L_8d1996:
	j_s [blink]
