/* hwd_pcie__set_882600 @ 0x8d1444, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__clear_dbi_gateway
 * Зовёт сам: pcie__dbi_ack_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__set_882600
hwd_pcie__set_882600:
	.global L_8d1444
L_8d1444:
	mov_s r0,0x882600
L_8d144a:
	st 0x4000000,[r0, 0x48]
L_8d1452:
	b L_8d11e8
L_8d1456:
	nop_s
