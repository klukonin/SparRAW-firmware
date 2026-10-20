/* rx__parse_ssw_field @ 0x927d0c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, sls__rx_ssw_frame
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__parse_ssw_field
rx__parse_ssw_field:
	.global L_927d0c
L_927d0c:
	push_s blink
L_927d0e:
	bl L_920230
L_927d12:
	mov_s r15,0x857800
L_927d18:
	ldb r13,[r15, -0xc4]
L_927d1c:
	mov_s r14,0x804010
L_927d22:
	ld_s r3,[r14,0x10]
L_927d24:
	brlt.d r13,0x2,L_927d40
L_927d28:
	bmsk_s r3,r3,0x5
L_927d2a:
	mov_s r13,0x801024
L_927d30:
	ld_s r13,[r13]
L_927d32:
	ld r15,[r15, -0x50]
L_927d36:
	lsr_s r13,r13,0x8
L_927d38:
	bmsk_s r13,r13,0xe
L_927d3a:
	add1_s r15,r15,r13
L_927d3c:
	ldb_s r13,[r15]
L_927d3e:
	add_s r3,r3,r13
	.global L_927d40
L_927d40:
	st_s r3,[r0]
L_927d42:
	ld_s r0,[r14,0x10]
L_927d44:
	lsr_s r0,r0,0x6
L_927d46:
	bmsk_s r0,r0,0x1
L_927d48:
	st_s r0,[r1]
L_927d4a:
	ldb.x r0,[r14, 0x11]
L_927d4e:
	b.d L_92029c
L_927d52:
	stb_s r0,[r2]
