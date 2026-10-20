/* link_stats_sm__on_pause @ 0x8dbf34, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, link_stats__report, link_stats_sm__on_latency_timer, u_schd__cancel
 */
	.section .text.link_stats_sm__on_pause,"ax",@progbits
	.global link_stats_sm__on_pause
link_stats_sm__on_pause:
L_8dbf34:
	push_s blink
L_8dbf36:
	push_s r13
L_8dbf38:
	mov_s r13,r0
L_8dbf3a:
	ld_s r0,[r0,0x2c]
L_8dbf3c:
	breq_s r0,0,L_8dbf46
L_8dbf3e:
	bl L_8c7794
L_8dbf42:
	mov_s r0,0x0
L_8dbf44:
	st_s r0,[r13,0x2c]
	.global L_8dbf46
L_8dbf46:
	ld_s r0,[r13,0x30]
L_8dbf48:
	breq_s r0,0,L_8dbf52
L_8dbf4a:
	bl L_8c7794
L_8dbf4e:
	mov_s r0,0x0
L_8dbf50:
	st_s r0,[r13,0x30]
	.global L_8dbf52
L_8dbf52:
	mov_s r0,r13
L_8dbf54:
	bl.d L_8d7638
L_8dbf58:
	mov_s r1,0x1
L_8dbf5a:
	mov_s r0,r13
L_8dbf5c:
	bl.d L_8e2ae8
L_8dbf60:
	mov_s r1,0x1
L_8dbf62:
	.byte 0xdd,0x03
