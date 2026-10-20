/* uc_bi_counter_in_window @ 0x932508, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__bi2_event_step
 */
	.section .text.uc_bi_counter_in_window,"ax",@progbits
	.global uc_bi_counter_in_window
uc_bi_counter_in_window:
	.global L_932508
L_932508:
	push_s r13
L_93250a:
	ld.as r2,[gp,-0x11]
L_93250e:
	mov_s r13,blink
L_932510:
	and r2,r2,0xffff0fff
L_932518:
	bset r0,r2,0xe
L_93251c:
	st.as r0,[gp,-0x11]
L_932520:
	or r2,r2,0x1d004000
L_932528:
	mov r32,r2
L_93252c:
	st.ab r2,[r25,0x4]
L_932530:
	bclr r25,r25,0xa
L_932534:
	nop_s
L_932536:
	nop_s
L_932538:
	nop_s
L_93253a:
	bmsk r1,r40,0x19
L_93253e:
	ld r3,[0x801434]
L_932546:
	st.as r1,[gp,-0x14]
L_93254a:
	sub_s r3,r3,0xf
L_93254c:
	brlo.d r3,r1,L_93255c
L_932550:
	mov r0,0x0
L_932554:
	brhs r1,0x9c4,L_932560
	.global L_93255c
L_93255c:
	mov r0,0x1
	.global L_932560
L_932560:
	extb_s r0,r0
L_932562:
	mov_s blink,r13
L_932564:
	j.d [blink]
L_932568:
	pop_s r13
L_93256a:
	nop_s
