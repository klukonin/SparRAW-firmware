/* mid_list__count_active @ 0x8c9798, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8f1908, l2_mgr__validate_scan, validate_connect
 * Зовёт сам: __ld_r13_ret, iter__has_more, iter__init, iter__next
 */
	.section .text.mid_list__count_active,"ax",@progbits
	.global mid_list__count_active
mid_list__count_active:
	.global L_8c9798
L_8c9798:
	push_s blink
L_8c979a:
	push_s r13
L_8c979c:
	sub_s sp,sp,0x4
L_8c979e:
	mov_s r13,sp
L_8c97a0:
	mov_s r1,0x8058d0
L_8c97a6:
	bl.d L_8e1138
L_8c97aa:
	mov_s r0,r13
L_8c97ac:
	b_s L_8c97ce
	.global L_8c97ae
L_8c97ae:
	bl.d L_8db188
L_8c97b2:
	mov_s r0,r13
L_8c97b4:
	mov_s r3,r0
L_8c97b6:
	add r3,r3,0x234
L_8c97ba:
	ld_s r2,[r3,0x8]
L_8c97bc:
	ld_s r2,[r2,0x78]
L_8c97be:
	mov_s r1,0x0
L_8c97c0:
	brne_s r2,0,L_8c97c6
L_8c97c2:
	ld_s r2,[r3,0x70]
L_8c97c4:
	breq_s r2,0,L_8c97c8
	.global L_8c97c6
L_8c97c6:
	mov_s r1,0x1
	.global L_8c97c8
L_8c97c8:
	extb.f 0x0,r1
L_8c97cc:
	bne_s L_8c97d8
	.global L_8c97ce
L_8c97ce:
	bl.d L_8cb674
L_8c97d2:
	mov_s r0,r13
L_8c97d4:
	brne_s r0,0,L_8c97ae
L_8c97d6:
	mov_s r0,0x0
	.global L_8c97d8
L_8c97d8:
	b.d L_8c033c
L_8c97dc:
	add_s sp,sp,0x4
L_8c97de:
	nop_s
