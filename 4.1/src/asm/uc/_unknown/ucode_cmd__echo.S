/* ucode_cmd__echo @ 0x9259d8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, uc_send_event
 */
	.section .text.ucode_cmd__echo,"ax",@progbits
	.global ucode_cmd__echo
ucode_cmd__echo:
	.global L_9259d8
L_9259d8:
	push_s blink
L_9259da:
	push_s r13
L_9259dc:
	mov_s r13,r0
L_9259de:
	mov_s r0,0x801618
L_9259e4:
	bl L_921930
L_9259e8:
	ld_s r1,[r13]
L_9259ea:
	mov_s r2,0x4
L_9259ec:
	st_s r1,[r0]
L_9259ee:
	mov_s r1,0x2
L_9259f0:
	bl.d L_925dd8
L_9259f4:
	mov_s r3,0x0
L_9259f6:
	b L_92028c
L_9259fa:
	nop_s
