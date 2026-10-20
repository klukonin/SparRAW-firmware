/* brp__write_slot_txcfg @ 0x937404, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure
 */
	.section .text.brp__write_slot_txcfg,"ax",@progbits
	.global brp__write_slot_txcfg
brp__write_slot_txcfg:
	.global L_937404
L_937404:
	push_s r13
L_937406:
	mov_s r3,0x8010e8
L_93740c:
	ld_s r13,[r3,0x24]
L_93740e:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_937410:
	add3_s r0,r0,r0
L_937412:
	add_s r0,r0,0x801190
L_937418:
	ld.as r2,[gp,-0x4]
L_93741c:
	bset_s r2,r2,0x5
L_93741e:
	breq_s r13,0,L_93742e
L_937420:
	ldb r13,[r3, 0x28]
L_937424:
	asl r1,r13,0x8
L_937428:
	or_s r1,r1,r2
L_93742a:
	st_s r1,[r0,0x4]
L_93742c:
	b_s L_93743c
	.global L_93742e
L_93742e:
	asl r13,r1,0x8
L_937432:
	or_s r13,r13,r2
L_937434:
	st_s r13,[r0,0x4]
L_937436:
	extb_s r13,r1
L_937438:
	stb r1,[r3, 0x28]
	.global L_93743c
L_93743c:
	mov_s r0,0x800fb0
L_937442:
	stb_s r13,[r0,0x1]
L_937444:
	j_s.d [blink]
L_937446:
	pop_s r13
