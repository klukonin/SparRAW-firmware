/* l2mgr__reset_oob_rings @ 0x8df490, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.l2mgr__reset_oob_rings,"ax",@progbits
	.global l2mgr__reset_oob_rings
l2mgr__reset_oob_rings:
	.global L_8df490
L_8df490:
	push_s blink
L_8df492:
	bl L_8c02bc
L_8df496:
	mov_s r15,0x0
L_8df498:
	mov_s r13,0x5
L_8df49a:
	mov_s r14,r15
	.global L_8df49c
L_8df49c:
	mul64 r14,0xd4
L_8df4a0:
	add r16,mlo,0x842aa0
L_8df4a8:
	add r0,r16,0x8
L_8df4ac:
	bl.d L_8c1a78
L_8df4b0:
	mov_s r1,0xd4
L_8df4b2:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8df4b4:
	st r15,[r16, 0x8]
L_8df4b8:
	/* brhs.d r13,0x1,0x008df49c */
	.byte 0xe5,0x0d,0x75,0x90
L_8df4bc:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8df4be:
	mov_s r0,0x842ea0
L_8df4c4:
	st_s r15,[r0,0x30]
L_8df4c6:
	b.d L_8c0324
L_8df4ca:
	st_s r15,[r0,0x2c]
