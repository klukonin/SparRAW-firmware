/* conn_main_sm__inject_bcon_rx @ 0x8c47e0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__inject_bcon_rx
conn_main_sm__inject_bcon_rx:
	.global L_8c47e0
L_8c47e0:
	push_s blink
L_8c47e2:
	bl.d L_8c01e4
L_8c47e6:
	mov_s r3,r1
L_8c47e8:
	mov_s r13,r0
L_8c47ea:
	add r13,r13,0x124
L_8c47ee:
	mov_s r2,0x0
L_8c47f0:
	stb_s r2,[r13,0x3]
L_8c47f2:
	mov_s r0,r13
L_8c47f4:
	mov_s r14,0x1
L_8c47f6:
	mov_s r1,r14
L_8c47f8:
	bl.d L_8d9b6c
L_8c47fc:
	mov_s r4,r2
L_8c47fe:
	b.d L_8c0254
L_8c4802:
	stb_s r14,[r13,0x3]
