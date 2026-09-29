/* lmac_if_ps_shallow_sleep_ntf_handler @ 0x8d8bbc, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: ps__post_shallow_sleep_state
 */
	.section .text.lmac_if_ps_shallow_sleep_ntf_handler,"ax",@progbits
	.global lmac_if_ps_shallow_sleep_ntf_handler
lmac_if_ps_shallow_sleep_ntf_handler:
	.global L_8d8bbc
L_8d8bbc:
	push_s blink
L_8d8bbe:
	ld.as r1,[gp,-0x5c]
L_8d8bc2:
	breq_s r1,0,L_8d8bcc
L_8d8bc4:
	add_s r1,r0,0x4
L_8d8bc6:
	bl.d L_8f0d08
L_8d8bca:
	ldb_s r0,[r0,0x1]
	.global L_8d8bcc
L_8d8bcc:
	pop_s blink
L_8d8bce:
	j_s [blink]
