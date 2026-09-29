/* seq__in_window @ 0x8da120, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sta_psc_sm__IDLE
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global seq__in_window
seq__in_window:
	.global L_8da120
L_8da120:
	push_s r13
L_8da122:
	ldb_s r3,[r0,0x11]
L_8da124:
	mov_s r2,0x0
L_8da126:
	ldb_s r0,[r0,0x10]
L_8da128:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8da12a:
	sub r13,r0,r3
L_8da12e:
	sub r3,r1,r13
L_8da132:
	extb_s r3,r3
L_8da134:
	sub_s r0,r0,r1
L_8da136:
	extb_s r0,r0
L_8da138:
	cmp r3,0x80
L_8da13c:
	mov_s r12,0x80
L_8da13e:
	cmp.lt r0,r12
L_8da142:
	mov.ge r0,r2
L_8da146:
	mov.lt r0,0x1
L_8da14a:
	j_s.d [blink]
L_8da14c:
	pop_s r13
L_8da14e:
	nop_s
