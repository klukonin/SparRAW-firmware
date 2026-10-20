/* mac__reset_event_engines @ 0x92b514, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x07_handler
 */
	.section .text.mac__reset_event_engines,"ax",@progbits
	.global mac__reset_event_engines
mac__reset_event_engines:
	.global L_92b514
L_92b514:
	push_s blink
L_92b516:
	mov r1,-0x1
L_92b51a:
	mov_s r0,0x886d80
L_92b520:
	st_s r1,[r0,0xc]
L_92b522:
	mov lp_count,0x6
L_92b526:
	mov_s r1,0x0
L_92b528:
	lp L_92b53a
L_92b52c:
	mov_s r2,0x886d90
L_92b532:
	mov_s r0,0x0
L_92b534:
	add2_s r2,r2,r1
L_92b536:
	st_s r0,[r2]
L_92b538:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_92b53a
L_92b53a:
	mov_s r0,0x10f000f0
L_92b540:
	mov_s r32,r0
L_92b542:
	st.ab r0,[r25,0x4]
L_92b546:
	bclr r25,r25,0xa
L_92b54a:
	mov_s r0,0x70
L_92b54c:
	st.as r0,[gp,-0x1d]
L_92b550:
	ld_s r0,[gp,-0x44]
L_92b552:
	and r0,r0,0xfffff0ff
L_92b55a:
	st.as r0,[gp,-0x11]
L_92b55e:
	or r0,r0,0x1d000000
L_92b566:
	mov_s r32,r0
L_92b568:
	st.ab r0,[r25,0x4]
L_92b56c:
	bclr r25,r25,0xa
L_92b570:
	nop_s
L_92b572:
	nop_s
L_92b574:
	nop_s
L_92b576:
	mov_s r0,0x1a000002
L_92b57c:
	mov_s r32,r0
L_92b57e:
	st.ab r0,[r25,0x4]
L_92b582:
	bclr r25,r25,0xa
L_92b586:
	pop_s blink
L_92b588:
	j_s [blink]
L_92b58a:
	nop_s
