/* list__find_entry_c @ 0x8c25b0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: list__find_entry
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__find_entry_c
list__find_entry_c:
	.global L_8c25b0
L_8c25b0:
	push_s blink
L_8c25b2:
	bl L_8c01e4
L_8c25b6:
	mov.f r13,r1
L_8c25ba:
	mov_s r14,r0
L_8c25bc:
	beq_s L_8c25ca
	.global L_8c25be
L_8c25be:
	ld_s r0,[r13,0x4]
L_8c25c0:
	brne_s r0,0,L_8c25d4
	.global L_8c25c2
L_8c25c2:
	ld_s r0,[r14]
L_8c25c4:
	breq_s r0,0,L_8c25de
L_8c25c6:
	ld_s r0,[r14,0x4]
L_8c25c8:
	b_s L_8c25e2
	.global L_8c25ca
L_8c25ca:
	mov_s r0,blink
L_8c25cc:
	bl.d L_8c9b28
L_8c25d0:
	mov_s r1,0xd1
L_8c25d2:
	b_s L_8c25be
	.global L_8c25d4
L_8c25d4:
	mov_s r0,blink
L_8c25d6:
	bl.d L_8c9b28
L_8c25da:
	mov_s r1,0xd2
L_8c25dc:
	b_s L_8c25c2
	.global L_8c25de
L_8c25de:
	st_s r13,[r14,0x8]
L_8c25e0:
	mov_s r0,0x0
	.global L_8c25e2
L_8c25e2:
	st_s r0,[r13]
L_8c25e4:
	ld_s r0,[r14]
L_8c25e6:
	st_s r13,[r14,0x4]
L_8c25e8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c25ea:
	st_s r0,[r14]
L_8c25ec:
	b.d L_8c0254
L_8c25f0:
	st_s r14,[r13,0x4]
L_8c25f2:
	nop_s
