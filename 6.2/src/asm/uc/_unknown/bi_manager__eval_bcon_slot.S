/* bi_manager__eval_bcon_slot @ 0x927de0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__slot_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_manager__eval_bcon_slot
bi_manager__eval_bcon_slot:
	.global L_927de0
L_927de0:
	ldb r3,[r0, 0x5]
L_927de4:
	brge.d r3,0x5,L_927e4c
L_927de8:
	mov r8,0x0
L_927dec:
	ldb r7,[r0, 0x4]
	.global L_927df0
L_927df0:
	ld r6,[r0]
L_927df4:
	bbit0 r6,r7,L_927e1c
L_927df8:
	bmsk r7,r7,0x2
L_927dfc:
	stb r7,[r1]
L_927e00:
	ldb r8,[r0, 0x4]
L_927e04:
	mov r9,0x1
L_927e08:
	cmp r8,0x8
L_927e0c:
	sub.ge r9,r9,r9
L_927e10:
	st r9,[r2]
L_927e14:
	ldb r7,[r0, 0x4]
L_927e18:
	mov r8,0x1
	.global L_927e1c
L_927e1c:
	add r7,r7,0x1
L_927e20:
	extb r7,r7
L_927e24:
	brne.d r7,0x10,L_927e40
L_927e28:
	stb r7,[r0, 0x4]
L_927e2c:
	mov r7,0x0
L_927e30:
	ldb r4,[r0, 0x5]
L_927e34:
	stb r7,[r0, 0x4]
L_927e38:
	add r4,r4,0x1
L_927e3c:
	stb r4,[r0, 0x5]
	.global L_927e40
L_927e40:
	brne r8,0x0,L_927e4c
L_927e44:
	ldb r5,[r0, 0x5]
L_927e48:
	brlt r5,0x5,L_927df0
	.global L_927e4c
L_927e4c:
	j.d [blink]
L_927e50:
	mov_s r0,r8
L_927e52:
	nop_s
