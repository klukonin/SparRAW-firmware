/* link_stats_sm__on_stop @ 0x8e2d58, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, led_scheme__apply, u_schd__cancel
 */
	.section .text.link_stats_sm__on_stop,"ax",@progbits
	.global link_stats_sm__on_stop
link_stats_sm__on_stop:
L_8e2d58:
	push_s blink
L_8e2d5a:
	push_s r13
L_8e2d5c:
	mov_s r13,r0
L_8e2d5e:
	mov_s r0,0x1
L_8e2d60:
	st_s r0,[r13,0x28]
L_8e2d62:
	ld_s r0,[r13,0x2c]
L_8e2d64:
	breq_s r0,0,L_8e2d6e
L_8e2d66:
	bl L_8c7794
L_8e2d6a:
	mov_s r0,0x0
L_8e2d6c:
	st_s r0,[r13,0x2c]
	.global L_8e2d6e
L_8e2d6e:
	ld_s r0,[r13,0x30]
L_8e2d70:
	breq_s r0,0,L_8e2d7a
L_8e2d72:
	bl L_8c7794
L_8e2d76:
	mov_s r0,0x0
L_8e2d78:
	st_s r0,[r13,0x30]
	.global L_8e2d7a
L_8e2d7a:
	bl.d L_8d775c
L_8e2d7e:
	mov_s r0,0x4
L_8e2d80:
	b L_8c033c
