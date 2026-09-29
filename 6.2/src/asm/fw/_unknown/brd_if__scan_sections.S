/* brd_if__scan_sections @ 0x8c6afc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__scan_sections
brd_if__scan_sections:
	.global L_8c6afc
L_8c6afc:
	push_s blink
L_8c6afe:
	bl.d L_8c01e0
L_8c6b02:
	mov_s r4,r1
L_8c6b04:
	mov_s r0,0x8
L_8c6b06:
	mov_s r5,r0
L_8c6b08:
	brlo.d r2,0x1,L_8c6b46
L_8c6b0c:
	mov_s r3,0x0
	.global L_8c6b0e
L_8c6b0e:
	add3 r1,r4,r3
L_8c6b12:
	ld r6,[r1]
L_8c6b16:
	ld_s r13,[r1,0x4]
L_8c6b18:
	mov_s r1,0x1
L_8c6b1a:
	mov_s r14,0x0
L_8c6b1c:
	b_s L_8c6b32
	.global L_8c6b1e
L_8c6b1e:
	add3 r0,r4,r14
L_8c6b22:
	ld_s r15,[r0]
L_8c6b24:
	brne r15,r6,L_8c6b30
L_8c6b28:
	ld_s r0,[r0,0x4]
L_8c6b2a:
	cmp_s r13,r0
L_8c6b2c:
	mov.eq r1,0x0
	.global L_8c6b30
L_8c6b30:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c6b32
L_8c6b32:
	brlo r14,r3,L_8c6b1e
L_8c6b36:
	cmp_s r1,0x0
L_8c6b38:
	add3.ne r5,r5,r13
L_8c6b3c:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8c6b3e:
	brhs.d r2,0x1,L_8c6b0e
L_8c6b42:
	/* _add_s r3,0x1 */
	.byte 0x01,0xe3
L_8c6b44:
	mov_s r0,r5
	.global L_8c6b46
L_8c6b46:
	b L_8c024c
L_8c6b4a:
	nop_s
