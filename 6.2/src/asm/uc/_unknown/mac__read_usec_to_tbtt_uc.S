/* mac__read_usec_to_tbtt_uc @ 0x937550, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__run_tx_slot_twice, fsched__time_left_class
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__read_usec_to_tbtt_uc
mac__read_usec_to_tbtt_uc:
	.global L_937550
L_937550:
	mov_s r2,0x887000
L_937556:
	breq_s r0,0,L_937560
	.global L_937558
L_937558:
	ld.as r1,[r2,-0x53]
L_93755c:
	bbit0 r1,0x1f,L_937558
	.global L_937560
L_937560:
	ld.as r0,[r2,-0x50]
L_937564:
	j.d [blink]
L_937568:
	bmsk_s r0,r0,0x19
L_93756a:
	nop_s
