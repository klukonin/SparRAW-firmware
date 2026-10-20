/* maintain_sm__on_rs_results @ 0x8cb5b4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, process_expected_bf_results, schedule_long_term_trigger
 */
	.section .text.maintain_sm__on_rs_results,"ax",@progbits
	.global maintain_sm__on_rs_results
maintain_sm__on_rs_results:
L_8cb5b4:
	push_s blink
L_8cb5b6:
	bl L_8c02c0
L_8cb5ba:
	mov_s r13,r0
L_8cb5bc:
	ld_s r0,[r1,0x8]
L_8cb5be:
	add r15,r13,0x20
L_8cb5c2:
	add3 r14,r13,0x10
L_8cb5c6:
	brne_s r0,0,L_8cb5ea
L_8cb5c8:
	ldb_s r1,[r1,0xd]
L_8cb5ca:
	stb_s r1,[r15,0x1d]
L_8cb5cc:
	bl.d L_8dd084
L_8cb5d0:
	mov_s r0,r13
L_8cb5d2:
	ldb_s r1,[r15,0x1d]
L_8cb5d4:
	mov_s r2,0x0
L_8cb5d6:
	ld_s r0,[r14,0x34]
L_8cb5d8:
	st_s r2,[r14,0x40]
L_8cb5da:
	cmp_s r0,r1
L_8cb5dc:
	mov.ls r0,r1
L_8cb5e0:
	st_s r0,[r14,0x34]
L_8cb5e2:
	bl.d L_8dfa80
L_8cb5e6:
	mov_s r0,r13
L_8cb5e8:
	b_s L_8cb5fa
	.global L_8cb5ea
L_8cb5ea:
	mov_s r0,0x1
L_8cb5ec:
	stb_s r0,[r15,0x1d]
L_8cb5ee:
	ld_s r0,[r14,0x3c]
L_8cb5f0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb5f2:
	st_s r0,[r14,0x3c]
L_8cb5f4:
	ld_s r0,[r14,0x40]
L_8cb5f6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cb5f8:
	st_s r0,[r14,0x40]
	.global L_8cb5fa
L_8cb5fa:
	b L_8c032c
L_8cb5fe:
	nop_s
