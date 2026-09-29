/* mid__reset_ie_area @ 0x8c44c0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_h_s0_w2, memset0_words
 */
	.section .text.mid__reset_ie_area,"ax",@progbits
	.global mid__reset_ie_area
mid__reset_ie_area:
	.global L_8c44c0
L_8c44c0:
	push_s blink
L_8c44c2:
	bl L_8c02c4
L_8c44c6:
	mov_s r13,r0
L_8c44c8:
	mov_s r14,r1
L_8c44ca:
	add r0,r0,0x102
L_8c44ce:
	bl.d L_8c1a78
L_8c44d2:
	mov_s r1,0x1
L_8c44d4:
	bmsk r1,r14,0x1
L_8c44d8:
	add r13,r13,0x100
L_8c44dc:
	add_s r0,r13,0x2
L_8c44de:
	bl L_8e82a0
L_8c44e2:
	ldw_s r0,[r13,0x2]
L_8c44e4:
	bset_s r0,r0,0x2
L_8c44e6:
	b.d L_8c0334
L_8c44ea:
	stw_s r0,[r13,0x2]
