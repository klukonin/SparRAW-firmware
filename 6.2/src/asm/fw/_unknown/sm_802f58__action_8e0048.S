/* sm_802f58__action_8e0048 @ 0x8e0048, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, link_stats__report, sm_802f58__on_evt_latency_timer_in_active, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_802f58__action_8e0048
sm_802f58__action_8e0048:
	.global L_8e0048
L_8e0048:
	push_s blink
L_8e004a:
	push_s r13
L_8e004c:
	mov_s r13,r0
L_8e004e:
	ld_s r0,[r0,0x8]
L_8e0050:
	breq_s r0,0,L_8e005a
L_8e0052:
	bl L_8c8de0
L_8e0056:
	mov_s r0,0x0
L_8e0058:
	st_s r0,[r13,0x8]
	.global L_8e005a
L_8e005a:
	ld_s r0,[r13,0xc]
L_8e005c:
	breq_s r0,0,L_8e0066
L_8e005e:
	bl L_8c8de0
L_8e0062:
	mov_s r0,0x0
L_8e0064:
	st_s r0,[r13,0xc]
	.global L_8e0066
L_8e0066:
	mov_s r0,r13
L_8e0068:
	bl.d L_8da73c
L_8e006c:
	mov_s r1,0x1
L_8e006e:
	mov_s r0,r13
L_8e0070:
	bl.d L_8e7cf8
L_8e0074:
	mov_s r1,0x1
L_8e0076:
	b L_8c025c
L_8e007a:
	nop_s
