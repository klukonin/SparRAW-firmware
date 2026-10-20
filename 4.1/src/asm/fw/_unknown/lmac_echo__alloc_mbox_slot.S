/* lmac_echo__alloc_mbox_slot @ 0x8c2b78, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_echo_evt_handler
 * Зовёт сам: basic_if__alloc_mbox_slot, mbox__debug_init_flow
 */
	.section .text.lmac_echo__alloc_mbox_slot,"ax",@progbits
	.global lmac_echo__alloc_mbox_slot
lmac_echo__alloc_mbox_slot:
	.global L_8c2b78
L_8c2b78:
	push_s blink
L_8c2b7a:
	bl L_8d6ea8
L_8c2b7e:
	bl L_8c2c38
L_8c2b82:
	pop_s blink
L_8c2b84:
	j_s [blink]
L_8c2b86:
	nop_s
