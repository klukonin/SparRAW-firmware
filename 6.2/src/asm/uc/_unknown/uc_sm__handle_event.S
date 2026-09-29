/* uc_sm__handle_event @ 0x92b6fc, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sm__handle_event
uc_sm__handle_event:
	.global L_92b6fc
L_92b6fc:
	ld r8,[r0, 0x4]
L_92b700:
	ldb_s r3,[r0]
L_92b702:
	ldb r5,[r8, 0x1]
L_92b706:
	ld r4,[r8, 0x4]
L_92b70a:
	mulu64 r5,r1
L_92b70e:
	add r4,r4,0x4
L_92b712:
	add_s r3,r3,mlo
L_92b714:
	add2_s r3,r3,r3
L_92b716:
	ldb r6,[r4,r3]
L_92b71a:
	mov_s r1,r2
L_92b71c:
	stb r6,[r0]
L_92b720:
	ld r9,[r8, 0x4]
L_92b724:
	mov r2,0x0
L_92b728:
	add r10,r9,r3
L_92b72c:
	ldb r7,[r10, 0x1]
L_92b730:
	ldb r11,[r9,r3]
L_92b734:
	asl r7,r7,0x8
L_92b738:
	or r11,r11,r7
L_92b73c:
	ldb r7,[r10, 0x2]
L_92b740:
	asl r7,r7,0x10
L_92b744:
	or r11,r11,r7
L_92b748:
	ldb r7,[r10, 0x3]
L_92b74c:
	asl r7,r7,0x18
L_92b750:
	or r11,r11,r7
L_92b754:
	j.d [r11]
L_92b758:
	mov_s r3,r2
L_92b75a:
	nop_s
