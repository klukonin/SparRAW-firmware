/* str__eq_n @ 0x8d9ff8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__ssid_matches
 */
	.section .text.str__eq_n,"ax",@progbits
	.global str__eq_n
str__eq_n:
	.global L_8d9ff8
L_8d9ff8:
	extb_s r1,r1
L_8d9ffa:
	b_s L_8d9ffe
	.global L_8d9ffc
L_8d9ffc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d9ffe
L_8d9ffe:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8da000:
	cmp r2,-0x1
L_8da004:
	beq_s L_8da00e
L_8da006:
	ldb_s r3,[r0]
L_8da008:
	brne r1,r3,L_8d9ffc
L_8da00c:
	b_s L_8da010
	.global L_8da00e
L_8da00e:
	mov_s r0,0x0
	.global L_8da010
L_8da010:
	j_s [blink]
L_8da012:
	nop_s
