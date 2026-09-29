/* mid_list__remove_entry @ 0x8daa8c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mid_list__find_by_kind, obj__set_field4_one, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__remove_entry
mid_list__remove_entry:
	.global L_8daa8c
L_8daa8c:
	push_s blink
L_8daa8e:
	bl L_8c01e4
L_8daa92:
	mov_s r14,r0
L_8daa94:
	mov_s r13,r1
L_8daa96:
	ld_s r1,[r1,0x4]
L_8daa98:
	add_s r0,r0,0x18
L_8daa9a:
	cmp_s r0,r1
L_8daa9c:
	mov_s r1,0x1
L_8daa9e:
	sub_s.ne r1,r1,r1
L_8daaa0:
	extb.f 0x0,r1
L_8daaa4:
	beq_s L_8daaba
L_8daaa6:
	bl.d L_8e2884
L_8daaaa:
	mov_s r1,r13
L_8daaac:
	ldb_s r1,[r13,0x8]
L_8daaae:
	ldb r0,[r14, 0x24]
L_8daab2:
	bclr r0,r0,r1
L_8daab6:
	stb r0,[r14, 0x24]
	.global L_8daaba
L_8daaba:
	mov_s r0,r14
L_8daabc:
	bl.d L_8cc424
L_8daac0:
	mov_s r1,0x1
L_8daac2:
	brne_s r0,0,L_8daae2
L_8daac4:
	ld_s r1,[r13,0x18]
L_8daac6:
	ld_s r1,[r1,0x50]
L_8daac8:
	mov_s r0,0x0
L_8daaca:
	cmp_s r1,0x2
L_8daacc:
	cmp.ne r1,0x3
L_8daad0:
	mov.eq r0,0x1
L_8daad4:
	extb.f 0x0,r0
L_8daad8:
	bne_s L_8daae2
L_8daada:
	bl.d L_8c4ee4
L_8daade:
	add3 r0,r14,0x9
	.global L_8daae2
L_8daae2:
	b L_8c0254
L_8daae6:
	nop_s
