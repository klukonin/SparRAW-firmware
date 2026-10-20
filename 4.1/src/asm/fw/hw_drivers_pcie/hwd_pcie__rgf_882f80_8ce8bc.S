/* hwd_pcie__rgf_882f80_8ce8bc @ 0x8ce8bc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ready_for_deep_sleep
 */
	.section .text.hwd_pcie__rgf_882f80_8ce8bc,"ax",@progbits
	.global hwd_pcie__rgf_882f80_8ce8bc
hwd_pcie__rgf_882f80_8ce8bc:
	.global L_8ce8bc
L_8ce8bc:
	mov_s r0,0x882f80
L_8ce8c2:
	ld_s r1,[r0,0x5c]
L_8ce8c4:
	st 0x4000,[r0, 0x50]
L_8ce8cc:
	st 0x4000,[r0, 0x64]
L_8ce8d4:
	j_s [blink]
L_8ce8d6:
	nop_s
