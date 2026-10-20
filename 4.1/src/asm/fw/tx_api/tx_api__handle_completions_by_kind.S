/* tx_api__handle_completions_by_kind @ 0x8e4ba0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_api.cpp
 * Зовёт сам: TX_API__handle_completed_packets, fw_sysassert_fatal
 */
	.section .text.tx_api__handle_completions_by_kind,"ax",@progbits
	.global tx_api__handle_completions_by_kind
tx_api__handle_completions_by_kind:
L_8e4ba0:
	push_s blink
L_8e4ba2:
	breq r0,0x3,L_8e4bd6
L_8e4ba6:
	breq r0,0x5,L_8e4bce
L_8e4baa:
	breq r0,0x6,L_8e4bc6
L_8e4bae:
	mov_s r0,blink
L_8e4bb0:
	mov_s r2,0x1014cd4
L_8e4bb6:
	mov_s r1,0x1222
L_8e4bbc:
	bl.d L_8c82c0
L_8e4bc0:
	mov r3,0x279
L_8e4bc4:
	b_s L_8e4be0
	.global L_8e4bc6
L_8e4bc6:
	mov_s r0,0x842410
L_8e4bcc:
	b_s L_8e4bdc
	.global L_8e4bce
L_8e4bce:
	mov_s r0,0x842530
L_8e4bd4:
	b_s L_8e4bdc
	.global L_8e4bd6
L_8e4bd6:
	mov_s r0,0x8424a0
	.global L_8e4bdc
L_8e4bdc:
	bl L_8cb2c0
	.global L_8e4be0
L_8e4be0:
	pop_s blink
L_8e4be2:
	j_s [blink]
