/* find_sm__stop_discovery @ 0x8e80a4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__stop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, discovery__rx_stop, l2mgr__send_discovery_stopped, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_sm__stop_discovery
find_sm__stop_discovery:
	.global L_8e80a4
L_8e80a4:
	push_s blink
L_8e80a6:
	bl L_8c01e4
L_8e80aa:
	mov_s r13,r0
L_8e80ac:
	ld_s r0,[r0,0x18]
L_8e80ae:
	mov_s r14,0x0
L_8e80b0:
	breq_s r0,0,L_8e80b8
L_8e80b2:
	bl L_8c8de0
L_8e80b6:
	st_s r14,[r13,0x18]
	.global L_8e80b8
L_8e80b8:
	bl L_8f80ec
L_8e80bc:
	st_s r14,[r13,0x40]
L_8e80be:
	ld_s r0,[r13,0x48]
L_8e80c0:
	bl.d L_8f8904
L_8e80c4:
	ldb_s r0,[r0,0x10]
L_8e80c6:
	b L_8c0254
L_8e80ca:
	nop_s
