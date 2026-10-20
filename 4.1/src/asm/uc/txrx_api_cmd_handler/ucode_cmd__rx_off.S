/* ucode_cmd__rx_off @ 0x93504c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: rx_funcs__set_rx_off, uc_send_evt_typed
 * Глобалы (через gp): 0x8005d6
 */
	.section .text.ucode_cmd__rx_off,"ax",@progbits
	.global ucode_cmd__rx_off
ucode_cmd__rx_off:
	.global L_93504c
L_93504c:
	push_s blink
L_93504e:
	ldw.as r1,[gp,0x57]
L_935052:
	breq_s r1,0,L_93505a
L_935054:
	bl.d L_928bd4
L_935058:
	ld_s r0,[r0]
	.global L_93505a
L_93505a:
	mov_s r0,0x3
L_93505c:
	bl.d L_925da8
L_935060:
	mov_s r1,0x0
L_935062:
	pop_s blink
L_935064:
	j_s [blink]
L_935066:
	nop_s
