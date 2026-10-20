/* pcie__clear_dbi_gateway @ 0x8f1b6c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Clearing DBI gateway
 * Зовут его: fw_vector_16
 * Зовёт сам: fw_log_emit0, hwd_pcie__set_882600
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__clear_dbi_gateway
pcie__clear_dbi_gateway:
	.global L_8f1b6c
L_8f1b6c:
	push_s blink
L_8f1b6e:
	mov_s r1,0x1001650
L_8f1b74:
	bl.d L_8dcba8
L_8f1b78:
	mov_s r0,0x20
L_8f1b7a:
	bl L_8d1444
L_8f1b7e:
	pop_s blink
L_8f1b80:
	j_s [blink]
L_8f1b82:
	nop_s
