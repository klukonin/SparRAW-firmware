/* uc_sleep_until_event @ 0x93676c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__send_and_await_rx_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_sleep_until_event
uc_sleep_until_event:
	.global L_93676c
L_93676c:
	st.a r13,[sp,-0x8]
L_936770:
	st_s r14,[sp,0x4]
L_936772:
	tst r42,r0
L_936776:
	mov_s r14,blink
L_936778:
	bne.d L_9367d8
L_93677c:
	mov_s r13,r0
L_93677e:
	breq_s r1,0,L_9367a8
L_936780:
	or r1,r1,0x23010000
L_936788:
	mov r32,r1
L_93678c:
	st.ab r1,[r25,0x4]
L_936790:
	bclr r25,r25,0xa
L_936794:
	mov_s r2,0x2000200
L_93679a:
	mov_s r32,r2
L_93679c:
	st.ab r2,[r25,0x4]
L_9367a0:
	bclr r25,r25,0xa
L_9367a4:
	bset r13,r13,0x9
	.global L_9367a8
L_9367a8:
	st r13,[0x886d3c]
L_9367b0:
	mov_s r2,0x21000002
L_9367b6:
	mov_s r32,r2
L_9367b8:
	st.ab r2,[r25,0x4]
L_9367bc:
	bclr r25,r25,0xa
L_9367c0:
	st.as r13,[gp,-0x19]
L_9367c4:
	st.as ilink2,[gp,-0x28]
L_9367c8:
	nop_s
L_9367ca:
	sleep 0x0
L_9367ce:
	mov_s r2,0x0
L_9367d0:
	st r2,[0x886d3c]
	.global L_9367d8
L_9367d8:
	mov_s blink,r14
L_9367da:
	ld_s r14,[sp,0x4]
L_9367dc:
	j.d [blink]
L_9367e0:
	ld.ab r13,[sp,0x8]
