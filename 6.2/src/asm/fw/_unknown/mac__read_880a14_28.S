/* mac__read_880a14_28 @ 0x8f3354, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_fw_ver
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_880a14_28
mac__read_880a14_28:
	.global L_8f3354
L_8f3354:
	push_s blink
L_8f3356:
	bl L_8c01e0
L_8f335a:
	mov_s r14,r4
L_8f335c:
	mov_s r13,r5
L_8f335e:
	breq_s r2,0,L_8f336a
L_8f3360:
	mov_s r15,0x880a00
L_8f3366:
	ld_s r15,[r15,0x14]
L_8f3368:
	stb_s r15,[r2]
	.global L_8f336a
L_8f336a:
	breq_s r1,0,L_8f3376
L_8f336c:
	mov_s r2,0x880a00
L_8f3372:
	ld_s r2,[r2,0x18]
L_8f3374:
	stb_s r2,[r1]
	.global L_8f3376
L_8f3376:
	breq_s r0,0,L_8f3382
L_8f3378:
	mov_s r1,0x880a00
L_8f337e:
	ld_s r1,[r1,0x1c]
L_8f3380:
	stb_s r1,[r0]
	.global L_8f3382
L_8f3382:
	breq_s r3,0,L_8f338e
L_8f3384:
	mov_s r0,0x880a00
L_8f338a:
	ld_s r0,[r0,0x20]
L_8f338c:
	stb_s r0,[r3]
	.global L_8f338e
L_8f338e:
	breq_s r14,0,L_8f339a
L_8f3390:
	mov_s r0,0x880a00
L_8f3396:
	ld_s r0,[r0,0x24]
L_8f3398:
	stb_s r0,[r14]
	.global L_8f339a
L_8f339a:
	breq_s r13,0,L_8f33a6
L_8f339c:
	mov_s r0,0x880a00
L_8f33a2:
	ld_s r0,[r0,0x28]
L_8f33a4:
	stb_s r0,[r13]
	.global L_8f33a6
L_8f33a6:
	b L_8c024c
L_8f33aa:
	nop_s
