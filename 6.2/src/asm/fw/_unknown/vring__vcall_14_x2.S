/* vring__vcall_14_x2 @ 0x8e0e28, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, vring__active_ring_table
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__vcall_14_x2
vring__vcall_14_x2:
	.global L_8e0e28
L_8e0e28:
	push_s blink
L_8e0e2a:
	push_s r13
L_8e0e2c:
	bl.d L_8cd080
L_8e0e30:
	mov_s r13,r0
L_8e0e32:
	ld_s r1,[r0]
L_8e0e34:
	ld_s r2,[r1,0x14]
L_8e0e36:
	jl_s.d [r2]
L_8e0e38:
	ldb_s r1,[r13,0x7]
L_8e0e3a:
	b L_8c025c
L_8e0e3e:
	nop_s
L_8e0e40:
	push_s blink
L_8e0e42:
	push_s r13
L_8e0e44:
	bl.d L_8cd080
L_8e0e48:
	mov_s r13,r0
L_8e0e4a:
	ld_s r1,[r0]
L_8e0e4c:
	ld_s r2,[r1,0x14]
L_8e0e4e:
	jl_s.d [r2]
L_8e0e50:
	ldb_s r1,[r13,0x7]
L_8e0e52:
	b L_8c025c
L_8e0e56:
	nop_s
