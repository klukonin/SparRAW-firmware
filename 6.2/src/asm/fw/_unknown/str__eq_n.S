/* str__eq_n @ 0x8ddf30, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__ssid_matches
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global str__eq_n
str__eq_n:
	.global L_8ddf30
L_8ddf30:
	extb_s r1,r1
L_8ddf32:
	b_s L_8ddf36
	.global L_8ddf34
L_8ddf34:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8ddf36
L_8ddf36:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8ddf38:
	cmp r2,-0x1
L_8ddf3c:
	beq_s L_8ddf46
L_8ddf3e:
	ldb_s r3,[r0]
L_8ddf40:
	brne r1,r3,L_8ddf34
L_8ddf44:
	b_s L_8ddf48
	.global L_8ddf46
L_8ddf46:
	mov_s r0,0x0
	.global L_8ddf48
L_8ddf48:
	j_s [blink]
L_8ddf4a:
	nop_s
