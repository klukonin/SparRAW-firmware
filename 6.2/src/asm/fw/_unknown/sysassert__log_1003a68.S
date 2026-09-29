/* sysassert__log_1003a68 @ 0x8e866c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   send interrupt to host
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: fw_log_emit0, host_irq__raise_fw_error, pcie__set_event_bit_19_sysassert
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sysassert__log_1003a68
sysassert__log_1003a68:
	.global L_8e866c
L_8e866c:
	push_s blink
L_8e866e:
	mov_s r1,0x1003a68
L_8e8674:
	bl.d L_8dcba8
L_8e8678:
	mov_s r0,0x20
L_8e867a:
	bl L_8d0cfc
L_8e867e:
	bl L_8d1b00
L_8e8682:
	pop_s blink
L_8e8684:
	j_s [blink]
L_8e8686:
	nop_s
