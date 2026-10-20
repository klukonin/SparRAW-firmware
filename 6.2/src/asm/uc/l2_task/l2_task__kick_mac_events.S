/* l2_task__kick_mac_events @ 0x92cf60, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_handle_watchdog
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l2_task__kick_mac_events
l2_task__kick_mac_events:
	.global L_92cf60
L_92cf60:
	push_s blink
L_92cf62:
	mov_s r1,0x80
L_92cf64:
	mov_s r0,0x886e00
L_92cf6a:
	st_s r1,[r0,0x34]
L_92cf6c:
	sync
L_92cf70:
	mov_s r1,0x80
L_92cf72:
	mov_s r0,0x886e00
L_92cf78:
	st_s r1,[r0,0x24]
L_92cf7a:
	sync
L_92cf7e:
	mov_s r1,0x80
L_92cf80:
	mov_s r0,0x886e00
L_92cf86:
	st_s r1,[r0,0x38]
L_92cf88:
	sync
L_92cf8c:
	pop_s blink
L_92cf8e:
	j_s [blink]
