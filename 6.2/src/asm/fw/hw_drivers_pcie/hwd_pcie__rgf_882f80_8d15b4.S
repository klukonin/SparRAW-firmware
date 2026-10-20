/* hwd_pcie__rgf_882f80_8d15b4 @ 0x8d15b4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ready_for_deep_sleep
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__rgf_882f80_8d15b4
hwd_pcie__rgf_882f80_8d15b4:
	.global L_8d15b4
L_8d15b4:
	mov_s r0,0x882f80
L_8d15ba:
	ld_s r1,[r0,0x5c]
L_8d15bc:
	st 0x4000,[r0, 0x50]
L_8d15c4:
	st 0x4000,[r0, 0x64]
L_8d15cc:
	j_s [blink]
L_8d15ce:
	nop_s
