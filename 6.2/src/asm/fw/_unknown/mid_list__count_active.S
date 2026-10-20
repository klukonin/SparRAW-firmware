/* mid_list__count_active @ 0x8cb7a0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__validate_scan, stream_mgr__ready_step, validate_connect
 * Зовёт сам: __ld_r13_to_r13_ret, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__count_active
mid_list__count_active:
	.global L_8cb7a0
L_8cb7a0:
	push_s blink
L_8cb7a2:
	push_s r13
L_8cb7a4:
	sub_s sp,sp,0x4
L_8cb7a6:
	mov_s r13,sp
L_8cb7a8:
	mov_s r1,0x804e70
L_8cb7ae:
	bl.d L_8e5df4
L_8cb7b2:
	mov_s r0,r13
L_8cb7b4:
	b_s L_8cb7d6
	.global L_8cb7b6
L_8cb7b6:
	bl.d L_8df438
L_8cb7ba:
	mov_s r0,r13
L_8cb7bc:
	mov_s r3,r0
L_8cb7be:
	add r3,r3,0x234
L_8cb7c2:
	ld_s r2,[r3,0x8]
L_8cb7c4:
	ld_s r2,[r2,0x78]
L_8cb7c6:
	mov_s r1,0x0
L_8cb7c8:
	brne_s r2,0,L_8cb7ce
L_8cb7ca:
	ld_s r2,[r3,0x4c]
L_8cb7cc:
	breq_s r2,0,L_8cb7d0
	.global L_8cb7ce
L_8cb7ce:
	mov_s r1,0x1
	.global L_8cb7d0
L_8cb7d0:
	extb.f 0x0,r1
L_8cb7d4:
	bne_s L_8cb7e0
	.global L_8cb7d6
L_8cb7d6:
	bl.d L_8cdcb8
L_8cb7da:
	mov_s r0,r13
L_8cb7dc:
	brne_s r0,0,L_8cb7b6
L_8cb7de:
	mov_s r0,0x0
	.global L_8cb7e0
L_8cb7e0:
	b.d L_8c025c
L_8cb7e4:
	add_s sp,sp,0x4
L_8cb7e6:
	nop_s
