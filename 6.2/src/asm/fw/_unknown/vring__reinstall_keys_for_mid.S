/* vring__reinstall_keys_for_mid @ 0x8ea7ac, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: install_key_handle, l2mgr__apply_key_to_prings
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__handle_event, ut_hw_cmd_0x008
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reinstall_keys_for_mid
vring__reinstall_keys_for_mid:
	.global L_8ea7ac
L_8ea7ac:
	push_s blink
L_8ea7ae:
	bl L_8c01e0
L_8ea7b2:
	mov_s r13,r0
L_8ea7b4:
	mov_s r15,r1
L_8ea7b6:
	mov_s r14,0x0
L_8ea7b8:
	b_s L_8ea7e8
	.global L_8ea7ba
L_8ea7ba:
	mov_s r0,0x847f34
L_8ea7c0:
	sub r0,r0,0x400
L_8ea7c4:
	add2_s r0,r0,r14
L_8ea7c6:
	ld r0,[r0,0x44c]
L_8ea7ce:
	breq_s r0,0,L_8ea7e6
L_8ea7d0:
	ld_s r1,[r0]
L_8ea7d2:
	brne r13,r1,L_8ea7e6
L_8ea7d6:
	ldb_s r1,[r0,0x7]
L_8ea7d8:
	breq r1,0x9,L_8ea7e6
L_8ea7dc:
	mov_s r1,r15
L_8ea7de:
	bl.d L_8eacb0
L_8ea7e2:
	ldb r2,[r13, 0x40]
	.global L_8ea7e6
L_8ea7e6:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8ea7e8
L_8ea7e8:
	brlo r14,0xa,L_8ea7ba
L_8ea7ec:
	b L_8c024c
L_8ea7f0:
	mov_s r2,r1
L_8ea7f2:
	add_s r0,r0,0x28
L_8ea7f4:
	mov_s r1,0x7
L_8ea7f6:
	mov_s r3,0x0
L_8ea7f8:
	b.d L_8d9b6c
L_8ea7fc:
	mov_s r4,r3
L_8ea7fe:
	nop_s
