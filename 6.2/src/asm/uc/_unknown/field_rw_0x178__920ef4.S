/* field_rw_0x178__920ef4 @ 0x920ef4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_get_required_response
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x178__920ef4
field_rw_0x178__920ef4:
	.global L_920ef4
L_920ef4:
	add r0,r0,0x200
L_920ef8:
	breq.d r1,0x0,L_920f08
L_920efc:
	ldb r3,[r0, -0x88]
L_920f00:
	or_s r2,r2,r3
L_920f02:
	j_s.d [blink]
L_920f04:
	stb r2,[r0, -0x88]
	.global L_920f08
L_920f08:
	bic_s r3,r3,r2
L_920f0a:
	j_s.d [blink]
L_920f0c:
	stb r3,[r0, -0x88]
