/* ucode_cmd__reset_queue_state @ 0x9283b8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 */
	.section .text.ucode_cmd__reset_queue_state,"ax",@progbits
	.global ucode_cmd__reset_queue_state
ucode_cmd__reset_queue_state:
	.global L_9283b8
L_9283b8:
	mov_s r1,0x1
L_9283ba:
	st_s r1,[r0,0x20]
L_9283bc:
	stw_s r1,[r0,0x2a]
L_9283be:
	stw_s r1,[r0,0x28]
L_9283c0:
	mov_s r2,0x0
L_9283c2:
	j_s.d [blink]
L_9283c4:
	st_s r2,[r0,0x24]
L_9283c6:
	nop_s
