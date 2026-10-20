/* bit_scan_msb @ 0x92d034, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bit_scan_msb
bit_scan_msb:
	.global L_92d034
L_92d034:
	push_s r13
L_92d036:
	cmp_s r0,0x0
L_92d038:
	mov_s r1,0x0
L_92d03a:
	mov.eq r0,r1
L_92d03e:
	beq_s L_92d09a
L_92d040:
	extw_s r1,r0
L_92d042:
	lsr r2,r0,0x10
L_92d046:
	cmp_s r1,0x0
L_92d048:
	mov_s r1,0x10
L_92d04a:
	sub_s.ne r1,r1,r1
L_92d04c:
	mov.ne r2,r0
L_92d050:
	extb_s r13,r2
L_92d052:
	add r0,r1,0x8
L_92d056:
	lsr r3,r2,0x8
L_92d05a:
	cmp_s r13,0x0
L_92d05c:
	mov.ne r0,r1
L_92d060:
	mov.eq r1,r3
L_92d064:
	mov.ne r1,r2
L_92d068:
	bmsk r13,r1,0x3
L_92d06c:
	add_s r3,r0,0x4
L_92d06e:
	lsr r2,r1,0x4
L_92d072:
	cmp_s r13,0x0
L_92d074:
	mov.ne r3,r0
L_92d078:
	mov.eq r13,r2
L_92d07c:
	mov.ne r13,r1
L_92d080:
	bmsk r2,r13,0x1
L_92d084:
	add_s r0,r3,0x2
L_92d086:
	lsr r1,r13,0x2
L_92d08a:
	cmp_s r2,0x0
L_92d08c:
	mov.ne r0,r3
L_92d090:
	mov.ne r1,r13
L_92d094:
	btst_s r1,0x0
L_92d096:
	add.eq r0,r0,0x1
	.global L_92d09a
L_92d09a:
	j_s.d [blink]
L_92d09c:
	pop_s r13
L_92d09e:
	nop_s
