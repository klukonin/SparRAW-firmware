/* peer__lookup_if_fixed_sched @ 0x926890, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwif_write_qh
 * Зовёт сам: __ld_r13_to_r13_ret, fixed_sched__is_engaged, peer__lookup_or_ff
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global peer__lookup_if_fixed_sched
peer__lookup_if_fixed_sched:
	.global L_926890
L_926890:
	push_s blink
L_926892:
	push_s r13
L_926894:
	mov_s r13,r0
L_926896:
	ld_s r0,[gp,-0x34]
L_926898:
	breq_s r0,0,L_9268aa
L_92689a:
	ld_s r0,[gp,-0xc0]
L_92689c:
	breq r13,r0,L_9268aa
L_9268a0:
	brhs r13,0x18,L_9268aa
L_9268a4:
	bl L_92bda4
L_9268a8:
	brne_s r0,0,L_9268ae
	.global L_9268aa
L_9268aa:
	mov_s r0,0x0
L_9268ac:
	b_s L_9268ba
	.global L_9268ae
L_9268ae:
	mov_s r0,0x801be8
L_9268b4:
	bl.d L_92be64
L_9268b8:
	mov_s r1,r13
	.global L_9268ba
L_9268ba:
	b L_9202ac
L_9268be:
	nop_s
