/* tx__program_vector_rf @ 0x9302d8, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__program_vector_rf
tx__program_vector_rf:
	.global L_9302d8
L_9302d8:
	st.a r13,[sp,-0x8]
L_9302dc:
	st_s r14,[sp,0x4]
L_9302de:
	mov_s r14,blink
L_9302e0:
	mov r13,r1
L_9302e4:
	mov r6,0x38000200
L_9302ec:
	mov r32,r6
L_9302f0:
	st.ab r6,[r25,0x4]
L_9302f4:
	bclr r25,r25,0xa
L_9302f8:
	or r13,r13,0x3f000000
L_930300:
	mov r32,r13
L_930304:
	st.ab r13,[r25,0x4]
L_930308:
	bclr r25,r25,0xa
L_93030c:
	mov r4,0x3e000000
L_930314:
	mov r32,r4
L_930318:
	st.ab r4,[r25,0x4]
L_93031c:
	bclr r25,r25,0xa
L_930320:
	mov r5,0x37000020
L_930328:
	mov r32,r5
L_93032c:
	st.ab r5,[r25,0x4]
L_930330:
	bclr r25,r25,0xa
L_930334:
	mov_s r3,0x8022c8
L_93033a:
	ld_s r1,[r3,0xc]
L_93033c:
	ld.as r2,[gp,0x5e]
L_930340:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_930342:
	st_s r1,[r3,0xc]
L_930344:
	ld r0,[0x802940]
L_93034c:
	and r2,r2,0xfcffffff
L_930354:
	asl_s r0,r0,0x18
L_930356:
	or_s r0,r0,r2
L_930358:
	st.as r0,[gp,0x5e]
L_93035c:
	st r0,[0x889488]
L_930364:
	mov_s blink,r14
L_930366:
	ld_s r14,[sp,0x4]
L_930368:
	j.d [blink]
L_93036c:
	ld.ab r13,[sp,0x8]
