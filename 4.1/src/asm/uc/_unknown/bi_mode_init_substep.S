/* bi_mode_init_substep @ 0x9314b8, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: __ld_r13_ret_uc, bi_mode__unmask_all_events, uc_irq_set_level
 */
	.section .text.bi_mode_init_substep,"ax",@progbits
	.global bi_mode_init_substep
bi_mode_init_substep:
	.global L_9314b8
L_9314b8:
	push_s blink
L_9314ba:
	bl.d L_9315c0
L_9314be:
	push_s r13
L_9314c0:
	mov_s r1,0x0
L_9314c2:
	mov_s r0,0x886d00
L_9314c8:
	st_s r1,[r0,0x28]
L_9314ca:
	mov_s r0,0xc
L_9314cc:
	st.as r0,[gp,-0x12]
L_9314d0:
	mov_s r0,0x2700000c
L_9314d6:
	mov_s r32,r0
L_9314d8:
	st.ab r0,[r25,0x4]
L_9314dc:
	bclr r25,r25,0xa
L_9314e0:
	mov_s r0,0x2ffffff
L_9314e6:
	mov_s r32,r0
L_9314e8:
	st.ab r0,[r25,0x4]
L_9314ec:
	bclr r25,r25,0xa
L_9314f0:
	mov_s r0,0x49ffffff
L_9314f6:
	mov_s r32,r0
L_9314f8:
	st.ab r0,[r25,0x4]
L_9314fc:
	bclr r25,r25,0xa
L_931500:
	mov_s r0,0x0
L_931502:
	mov_s r13,0x886d00
L_931508:
	st_s r0,[r13,0x3c]
L_93150a:
	mov_s r0,0xa
L_93150c:
	bl.d L_9219b4
L_931510:
	mov_s r1,0x1
L_931512:
	mov r0,-0x1
L_931516:
	st_s r0,[r13,0x40]
L_931518:
	ld_s r0,[gp,-0x44]
L_93151a:
	bic r0,r0,0xf0
L_93151e:
	bset r1,r0,0x5
L_931522:
	or r0,r0,0x1d000020
L_93152a:
	st.as r1,[gp,-0x11]
L_93152e:
	mov_s r32,r0
L_931530:
	st.ab r0,[r25,0x4]
L_931534:
	bclr r25,r25,0xa
L_931538:
	nop_s
L_93153a:
	nop_s
L_93153c:
	nop_s
L_93153e:
	mov_s r0,0x21000009
L_931544:
	mov_s r32,r0
L_931546:
	st.ab r0,[r25,0x4]
L_93154a:
	bclr r25,r25,0xa
L_93154e:
	mov_s r0,0x1ffffff
L_931554:
	mov_s r32,r0
L_931556:
	st.ab r0,[r25,0x4]
L_93155a:
	bclr r25,r25,0xa
L_93155e:
	mov_s r13,0x887000
L_931564:
	st.as 0x8010,[r13,-0xaf]
L_93156c:
	mov_s r0,0x0
L_93156e:
	st r0,[r13, -0x44]
L_931572:
	mov_s r0,0xe
L_931574:
	bl.d L_9219b4
L_931578:
	mov_s r1,0x1
L_93157a:
	mov r0,-0x1
L_93157e:
	st r0,[r13, -0x40]
L_931582:
	ld_s r0,[gp,-0x44]
L_931584:
	and r0,r0,0xff0fffff
L_93158c:
	bset r1,r0,0x15
L_931590:
	or r0,r0,0x1d200000
L_931598:
	st.as r1,[gp,-0x11]
L_93159c:
	mov_s r32,r0
L_93159e:
	st.ab r0,[r25,0x4]
L_9315a2:
	bclr r25,r25,0xa
L_9315a6:
	nop_s
L_9315a8:
	nop_s
L_9315aa:
	nop_s
L_9315ac:
	mov_s r0,0x48ffffff
L_9315b2:
	mov_s r32,r0
L_9315b4:
	st.ab r0,[r25,0x4]
L_9315b8:
	bclr r25,r25,0xa
L_9315bc:
	b L_92028c
