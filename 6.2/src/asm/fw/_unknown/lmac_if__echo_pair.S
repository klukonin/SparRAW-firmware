/* lmac_if__echo_pair @ 0x8c32e8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_echo_evt_handler
 * Зовёт сам: debug_mbox__get_or_init, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__echo_pair
lmac_if__echo_pair:
	.global L_8c32e8
L_8c32e8:
	push_s blink
L_8c32ea:
	bl L_8d9f9c
L_8c32ee:
	bl L_8c33d0
L_8c32f2:
	pop_s blink
L_8c32f4:
	j_s [blink]
L_8c32f6:
	nop_s
