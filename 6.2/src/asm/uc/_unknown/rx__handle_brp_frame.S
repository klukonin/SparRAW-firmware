/* rx__handle_brp_frame @ 0x92e16c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report, sls__rx_ssw_frame
 * Глобалы (через gp): 0x8005b4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__handle_brp_frame
rx__handle_brp_frame:
	.global L_92e16c
L_92e16c:
	ldw.as r3,[gp,0x46]
L_92e170:
	mov r7,0x804010
L_92e178:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92e17a:
	stw.as r3,[gp,0x46]
L_92e17e:
	ldb r1,[r7, 0x18]
L_92e182:
	cmp_s r1,0x14
L_92e184:
	jne_s [blink]
L_92e186:
	ldb r6,[r7, 0x19]
L_92e18a:
	cmp r6,0x1
L_92e18e:
	jne_s [blink]
L_92e190:
	ldb r8,[r7, 0x1b]
L_92e194:
	bmsk.f 0x0,r8,0x4
L_92e198:
	beq L_92e1b8
L_92e19c:
	bmsk r8,r8,0x4
L_92e1a0:
	mov r5,0x8021e0
L_92e1a8:
	ld r4,[r5]
L_92e1ac:
	stb r8,[r5, 0xc]
L_92e1b0:
	or r4,r4,0x600
L_92e1b4:
	st r4,[r5]
	.global L_92e1b8
L_92e1b8:
	ldb r0,[r7, 0x21]
L_92e1bc:
	ldb r2,[r7, 0x20]
L_92e1c0:
	asl_s r0,r0,0x8
L_92e1c2:
	or_s r2,r2,r0
L_92e1c4:
	btst_s r2,0xa
L_92e1c6:
	jeq_s [blink]
L_92e1c8:
	mov r10,0x8021e0
L_92e1d0:
	ld r9,[r10]
L_92e1d4:
	or r9,r9,0xa00
L_92e1dc:
	j.d [blink]
L_92e1e0:
	st r9,[r10]
