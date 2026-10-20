/* ucode_cmd_24__check @ 0x93d31c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x24_handler
 * Зовёт сам: ps__hold_awake_for_sta
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_24__check
ucode_cmd_24__check:
	.global L_93d31c
L_93d31c:
	st.a r13,[sp,-0x4]
L_93d320:
	add r2,r0,0x200
L_93d328:
	ldb r3,[r2, -0x9c]
L_93d32c:
	breq.d r3,0x0,L_93d340
L_93d330:
	mov_s r13,blink
L_93d332:
	stb r3,[r2, -0x9b]
L_93d336:
	mov_s r1,0x0
L_93d338:
	bl.d L_93d914
L_93d33c:
	stb r1,[r2, -0x9c]
	.global L_93d340
L_93d340:
	mov_s blink,r13
L_93d342:
	j_s.d [blink]
L_93d344:
	pop_s r13
L_93d346:
	nop_s
