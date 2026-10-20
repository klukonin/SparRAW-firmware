/* bi_mode_init_substep @ 0x936398, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: __ld_r13_to_r13_ret, irq__init_event_masks, uc_irq_set_level
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_mode_init_substep
bi_mode_init_substep:
	.global L_936398
L_936398:
	push_s blink
L_93639a:
	bl.d L_9364a0
L_93639e:
	push_s r13
L_9363a0:
	mov_s r1,0x0
L_9363a2:
	mov_s r0,0x886d00
L_9363a8:
	st_s r1,[r0,0x28]
L_9363aa:
	mov_s r0,0xc
L_9363ac:
	st.as r0,[gp,-0x12]
L_9363b0:
	mov_s r0,0x2700000c
L_9363b6:
	mov_s r32,r0
L_9363b8:
	st.ab r0,[r25,0x4]
L_9363bc:
	bclr r25,r25,0xa
L_9363c0:
	mov_s r0,0x2ffffff
L_9363c6:
	mov_s r32,r0
L_9363c8:
	st.ab r0,[r25,0x4]
L_9363cc:
	bclr r25,r25,0xa
L_9363d0:
	mov_s r0,0x49ffffff
L_9363d6:
	mov_s r32,r0
L_9363d8:
	st.ab r0,[r25,0x4]
L_9363dc:
	bclr r25,r25,0xa
L_9363e0:
	mov_s r0,0x0
L_9363e2:
	mov_s r13,0x886d00
L_9363e8:
	st_s r0,[r13,0x3c]
L_9363ea:
	mov_s r0,0xa
L_9363ec:
	bl.d L_921018
L_9363f0:
	mov_s r1,0x1
L_9363f2:
	mov r0,-0x1
L_9363f6:
	st_s r0,[r13,0x40]
L_9363f8:
	ld_s r0,[gp,-0x44]
L_9363fa:
	bic r0,r0,0xf0
L_9363fe:
	bset r1,r0,0x5
L_936402:
	or r0,r0,0x1d000020
L_93640a:
	st.as r1,[gp,-0x11]
L_93640e:
	mov_s r32,r0
L_936410:
	st.ab r0,[r25,0x4]
L_936414:
	bclr r25,r25,0xa
L_936418:
	nop_s
L_93641a:
	nop_s
L_93641c:
	nop_s
L_93641e:
	mov_s r0,0x21000009
L_936424:
	mov_s r32,r0
L_936426:
	st.ab r0,[r25,0x4]
L_93642a:
	bclr r25,r25,0xa
L_93642e:
	mov_s r0,0x1ffffff
L_936434:
	mov_s r32,r0
L_936436:
	st.ab r0,[r25,0x4]
L_93643a:
	bclr r25,r25,0xa
L_93643e:
	mov_s r13,0x887000
L_936444:
	st.as 0x28010,[r13,-0xaf]
L_93644c:
	mov_s r0,0x0
L_93644e:
	st r0,[r13, -0x44]
L_936452:
	mov_s r0,0xe
L_936454:
	bl.d L_921018
L_936458:
	mov_s r1,0x1
L_93645a:
	mov r0,-0x1
L_93645e:
	st r0,[r13, -0x40]
L_936462:
	ld_s r0,[gp,-0x44]
L_936464:
	and r0,r0,0xff0fffff
L_93646c:
	bset r1,r0,0x15
L_936470:
	or r0,r0,0x1d200000
L_936478:
	st.as r1,[gp,-0x11]
L_93647c:
	mov_s r32,r0
L_93647e:
	st.ab r0,[r25,0x4]
L_936482:
	bclr r25,r25,0xa
L_936486:
	nop_s
L_936488:
	nop_s
L_93648a:
	nop_s
L_93648c:
	mov_s r0,0x48ffffff
L_936492:
	mov_s r32,r0
L_936494:
	st.ab r0,[r25,0x4]
L_936498:
	bclr r25,r25,0xa
L_93649c:
	b L_9202ac
