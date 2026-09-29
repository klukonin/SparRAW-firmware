/* mid_list__remove_entry @ 0x8d7970, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, llist__remove, mid_list__find_by_kind, obj__set_field4_one
 */
	.section .text.mid_list__remove_entry,"ax",@progbits
	.global mid_list__remove_entry
mid_list__remove_entry:
	.global L_8d7970
L_8d7970:
	push_s blink
L_8d7972:
	bl L_8c02c4
L_8d7976:
	mov_s r14,r0
L_8d7978:
	mov_s r13,r1
L_8d797a:
	ld_s r1,[r1,0x4]
L_8d797c:
	add_s r0,r0,0x18
L_8d797e:
	cmp_s r0,r1
L_8d7980:
	mov_s r1,0x1
L_8d7982:
	sub_s.ne r1,r1,r1
L_8d7984:
	extb.f 0x0,r1
L_8d7988:
	beq_s L_8d799e
L_8d798a:
	bl.d L_8de4ec
L_8d798e:
	mov_s r1,r13
L_8d7990:
	ldb_s r1,[r13,0x8]
L_8d7992:
	ldb r0,[r14, 0x24]
L_8d7996:
	bclr r0,r0,r1
L_8d799a:
	stb r0,[r14, 0x24]
	.global L_8d799e
L_8d799e:
	mov_s r0,r14
L_8d79a0:
	bl.d L_8ca1f8
L_8d79a4:
	mov_s r1,0x1
L_8d79a6:
	brne_s r0,0,L_8d79c6
L_8d79a8:
	ld_s r1,[r13,0xc]
L_8d79aa:
	ld_s r1,[r1,0x50]
L_8d79ac:
	mov_s r0,0x0
L_8d79ae:
	cmp_s r1,0x2
L_8d79b0:
	cmp.ne r1,0x3
L_8d79b4:
	mov.eq r0,0x1
L_8d79b8:
	extb.f 0x0,r0
L_8d79bc:
	bne_s L_8d79c6
L_8d79be:
	bl.d L_8c458c
L_8d79c2:
	add3 r0,r14,0x9
	.global L_8d79c6
L_8d79c6:
	b L_8c0334
L_8d79ca:
	nop_s
