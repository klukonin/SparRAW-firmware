/* ber_test__accumulate_counters @ 0x8f5cdc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ber_test__measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ber_test__accumulate_counters
ber_test__accumulate_counters:
	.global L_8f5cdc
L_8f5cdc:
	push_s r13
L_8f5cde:
	push_s r14
L_8f5ce0:
	ld_s r1,[r0,0x34]
L_8f5ce2:
	cmp_s r1,0x1
L_8f5ce4:
	mov.eq r0,0x0
L_8f5ce8:
	beq_s L_8f5d14
L_8f5cea:
	ld_s r2,[r0,0x28]
L_8f5cec:
	ld_s r1,[r0,0x2c]
L_8f5cee:
	ld_s r13,[r0,0x1c]
L_8f5cf0:
	add_s r1,r1,r2
L_8f5cf2:
	st_s r1,[r0,0x2c]
L_8f5cf4:
	brne r1,r13,L_8f5d04
L_8f5cf8:
	ld_s r14,[r0,0x30]
L_8f5cfa:
	ld_s r3,[r0,0x24]
L_8f5cfc:
	brne r14,r3,L_8f5d04
L_8f5d00:
	mov_s r3,0x1
L_8f5d02:
	st_s r3,[r0,0x34]
	.global L_8f5d04
L_8f5d04:
	brge r13,r1,L_8f5d12
L_8f5d08:
	ld_s r1,[r0,0x18]
L_8f5d0a:
	st_s r1,[r0,0x2c]
L_8f5d0c:
	ld_s r1,[r0,0x30]
L_8f5d0e:
	add_s r1,r1,r2
L_8f5d10:
	st_s r1,[r0,0x30]
	.global L_8f5d12
L_8f5d12:
	mov_s r0,0x1
	.global L_8f5d14
L_8f5d14:
	pop_s r14
L_8f5d16:
	j_s.d [blink]
L_8f5d18:
	pop_s r13
L_8f5d1a:
	nop_s
