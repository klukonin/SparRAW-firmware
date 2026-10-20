/* shallow_sleep_step @ 0x937304, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x05_handler
 * Зовёт сам: memset0_words_uc, perform_shallow_sleep
 */
	.section .text.shallow_sleep_step,"ax",@progbits
	.global shallow_sleep_step
shallow_sleep_step:
	.global L_937304
L_937304:
	st.a r13,[sp,-0x14]
L_937308:
	st blink,[sp, 0x4]
L_93730c:
	st_s r14,[sp,0x8]
L_93730e:
	st_s r15,[sp,0xc]
L_937310:
	st r16,[sp, 0x10]
L_937314:
	mov_s r13,r0
L_937316:
	mov_s r16,r1
L_937318:
	mov_s r15,0x0
L_93731a:
	mov_s r1,r15
L_93731c:
	mov_s r2,r15
L_93731e:
	mov_s r3,0x1
L_937320:
	bl.d L_92af4c
L_937324:
	mov r4,r3
L_937328:
	st.as r15,[r13,0x50]
L_93732c:
	st.as r15,[r13,0x51]
L_937330:
	add r14,r13,0x200
L_937338:
	stb r15,[r14, -0xb8]
L_93733c:
	add r0,r13,0x20
L_937340:
	bl.d L_92166c
L_937344:
	mov r1,0xc
L_937348:
	add r0,r13,0x2c
L_93734c:
	bl.d L_92166c
L_937350:
	mov r1,0x10
L_937354:
	asl r1,r16,0x2
L_937358:
	add1_s r1,r1,r1
L_93735a:
	add3 r0,r13,0x9
L_93735e:
	add_s r0,r0,r1
L_937360:
	bl.d L_92166c
L_937364:
	mov r1,0xc
L_937368:
	asl r5,r16,0x4
L_93736c:
	add3 r0,r13,0x15
L_937370:
	add r0,r0,r5
L_937374:
	bl.d L_92166c
L_937378:
	mov r1,0x10
L_93737c:
	ldb r3,[r14, -0xd8]
L_937380:
	asl r4,0x1,r16
L_937388:
	or r3,r3,r4
L_93738c:
	ldb r2,[r14, -0xd7]
L_937390:
	stb r3,[r14, -0xd8]
L_937394:
	or r2,r2,r4
L_937398:
	ld blink,[sp, 0x4]
L_93739c:
	stb r2,[r14, -0xd7]
L_9373a0:
	ld_s r14,[sp,0x8]
L_9373a2:
	ld_s r15,[sp,0xc]
L_9373a4:
	ld r16,[sp, 0x10]
L_9373a8:
	j.d [blink]
L_9373ac:
	ld.ab r13,[sp,0x14]
