/* bit_scan_msb @ 0x929ee8, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd__queue_delete
 */
	.section .text.bit_scan_msb,"ax",@progbits
	.global bit_scan_msb
bit_scan_msb:
	.global L_929ee8
L_929ee8:
	push_s r13
L_929eea:
	cmp_s r0,0x0
L_929eec:
	mov_s r1,0x0
L_929eee:
	mov.eq r0,r1
L_929ef2:
	beq_s L_929f4e
L_929ef4:
	extw_s r1,r0
L_929ef6:
	lsr r2,r0,0x10
L_929efa:
	cmp_s r1,0x0
L_929efc:
	mov_s r1,0x10
L_929efe:
	sub_s.ne r1,r1,r1
L_929f00:
	mov.ne r2,r0
L_929f04:
	extb_s r13,r2
L_929f06:
	add r0,r1,0x8
L_929f0a:
	lsr r3,r2,0x8
L_929f0e:
	cmp_s r13,0x0
L_929f10:
	mov.ne r0,r1
L_929f14:
	mov.eq r1,r3
L_929f18:
	mov.ne r1,r2
L_929f1c:
	bmsk r13,r1,0x3
L_929f20:
	add_s r3,r0,0x4
L_929f22:
	lsr r2,r1,0x4
L_929f26:
	cmp_s r13,0x0
L_929f28:
	mov.ne r3,r0
L_929f2c:
	mov.eq r13,r2
L_929f30:
	mov.ne r13,r1
L_929f34:
	bmsk r2,r13,0x1
L_929f38:
	add_s r0,r3,0x2
L_929f3a:
	lsr r1,r13,0x2
L_929f3e:
	cmp_s r2,0x0
L_929f40:
	mov.ne r0,r3
L_929f44:
	mov.ne r1,r13
L_929f48:
	btst_s r1,0x0
L_929f4a:
	add.eq r0,r0,0x1
	.global L_929f4e
L_929f4e:
	j_s.d [blink]
L_929f50:
	pop_s r13
L_929f52:
	nop_s
