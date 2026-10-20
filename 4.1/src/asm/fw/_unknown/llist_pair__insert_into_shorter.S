/* llist_pair__insert_into_shorter @ 0x8ebd20, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, llist__insert, llist__pop_front
 */
	.section .text.llist_pair__insert_into_shorter,"ax",@progbits
	.global llist_pair__insert_into_shorter
llist_pair__insert_into_shorter:
L_8ebd20:
	push_s blink
L_8ebd22:
	bl L_8c02b8
L_8ebd26:
	mov_s r14,r0
L_8ebd28:
	mov_s r17,r1
L_8ebd2a:
	ld_s r1,[r0,0x4]
L_8ebd2c:
	ld_s r0,[r0,0x8]
L_8ebd2e:
	cmp_s r0,r1
L_8ebd30:
	mov.cc r13,r1
L_8ebd34:
	mov.cs r13,r0
L_8ebd38:
	brlo.d r13,0x1,L_8ebd72
L_8ebd3c:
	mov_s r16,r2
L_8ebd3e:
	mov_s r15,r13
	.global L_8ebd40
L_8ebd40:
	bl.d L_8de2d4
L_8ebd44:
	mov_s r0,r16
L_8ebd46:
	mov_s r1,r0
L_8ebd48:
	ldw_s r0,[r14,0xe]
L_8ebd4a:
	cmp_s r0,0x0
L_8ebd4c:
	mov.le r0,0x0
L_8ebd50:
	ble_s L_8ebd58
L_8ebd52:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ebd54:
	stw_s r0,[r14,0xe]
L_8ebd56:
	mov_s r0,0x1
	.global L_8ebd58
L_8ebd58:
	stb_s r0,[r1,0x11]
L_8ebd5a:
	bl.d L_8c1fc4
L_8ebd5e:
	mov_s r0,r17
L_8ebd60:
	ld_s r0,[r14,0x4]
L_8ebd62:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8ebd64:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ebd66:
	st_s r0,[r14,0x4]
L_8ebd68:
	ld_s r0,[r14,0x8]
L_8ebd6a:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ebd6c:
	brhs.d r15,0x1,L_8ebd40
L_8ebd70:
	st_s r0,[r14,0x8]
	.global L_8ebd72
L_8ebd72:
	ld_s r0,[r14,0x1c]
L_8ebd74:
	add_s r0,r0,r13
L_8ebd76:
	b.d L_8c031c
L_8ebd7a:
	st_s r0,[r14,0x1c]
