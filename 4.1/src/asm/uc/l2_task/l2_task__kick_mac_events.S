/* l2_task__kick_mac_events @ 0x929bcc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__run
 */
	.section .text.l2_task__kick_mac_events,"ax",@progbits
	.global l2_task__kick_mac_events
l2_task__kick_mac_events:
	.global L_929bcc
L_929bcc:
	push_s blink
L_929bce:
	mov_s r1,0x80
L_929bd0:
	mov_s r0,0x886e00
L_929bd6:
	st_s r1,[r0,0x34]
L_929bd8:
	sync
L_929bdc:
	mov_s r1,0x80
L_929bde:
	mov_s r0,0x886e00
L_929be4:
	st_s r1,[r0,0x24]
L_929be6:
	sync
L_929bea:
	mov_s r1,0x80
L_929bec:
	mov_s r0,0x886e00
L_929bf2:
	st_s r1,[r0,0x38]
L_929bf4:
	sync
L_929bf8:
	pop_s blink
L_929bfa:
	j_s [blink]
