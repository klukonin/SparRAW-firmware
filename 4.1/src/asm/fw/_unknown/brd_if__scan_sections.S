/* brd_if__scan_sections @ 0x8c5d68, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.brd_if__scan_sections,"ax",@progbits
	.global brd_if__scan_sections
brd_if__scan_sections:
	.global L_8c5d68
L_8c5d68:
	push_s blink
L_8c5d6a:
	bl.d L_8c02c0
L_8c5d6e:
	mov_s r4,r1
L_8c5d70:
	mov_s r0,0x8
L_8c5d72:
	mov_s r5,r0
L_8c5d74:
	brlo.d r2,0x1,L_8c5db2
L_8c5d78:
	mov_s r3,0x0
	.global L_8c5d7a
L_8c5d7a:
	add3 r1,r4,r3
L_8c5d7e:
	ld r6,[r1]
L_8c5d82:
	ld_s r13,[r1,0x4]
L_8c5d84:
	mov_s r1,0x1
L_8c5d86:
	mov_s r14,0x0
L_8c5d88:
	b_s L_8c5d9e
	.global L_8c5d8a
L_8c5d8a:
	add3 r0,r4,r14
L_8c5d8e:
	ld_s r15,[r0]
L_8c5d90:
	brne r15,r6,L_8c5d9c
L_8c5d94:
	ld_s r0,[r0,0x4]
L_8c5d96:
	cmp_s r13,r0
L_8c5d98:
	mov.eq r1,0x0
	.global L_8c5d9c
L_8c5d9c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c5d9e
L_8c5d9e:
	brlo r14,r3,L_8c5d8a
L_8c5da2:
	cmp_s r1,0x0
L_8c5da4:
	add3.ne r5,r5,r13
L_8c5da8:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8c5daa:
	/* brhs.d r2,0x1,0x008c5d7a */
	.byte 0xd3,0x0a,0x75,0x80
L_8c5dae:
	/* _add_s r3,0x1 */
	.byte 0x01,0xe3
L_8c5db0:
	mov_s r0,r5
	.global L_8c5db2
L_8c5db2:
	b L_8c032c
L_8c5db6:
	nop_s
