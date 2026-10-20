/* hwd_pcie__read_882650 @ 0x8d1458, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__read_882650
hwd_pcie__read_882650:
	.global L_8d1458
L_8d1458:
	mov_s r0,0x882600
L_8d145e:
	ld_s r0,[r0,0x50]
L_8d1460:
	j_s [blink]
L_8d1462:
	nop_s
