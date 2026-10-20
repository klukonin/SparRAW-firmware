/* pcie__dbi_ack_done @ 0x8d11e8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie__set_882600, pcie__ack__8e026c, pcie__dbi_transfer
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_ack_done
pcie__dbi_ack_done:
	.global L_8d11e8
L_8d11e8:
	mov_s r0,0x882600
L_8d11ee:
	st 0x40000000,[r0, 0x44]
L_8d11f6:
	j_s [blink]
