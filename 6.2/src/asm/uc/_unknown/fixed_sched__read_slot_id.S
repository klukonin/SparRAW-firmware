/* fixed_sched__read_slot_id @ 0x928824, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, qh__build_descriptor_b, uc_evt__send_2e
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fixed_sched__read_slot_id
fixed_sched__read_slot_id:
	.global L_928824
L_928824:
	push_s blink
L_928826:
	bl L_920234
L_92882a:
	add r14,r0,0x20
L_92882e:
	ldb_s r0,[r14,0xa]
L_928830:
	mov_s r13,0xff
L_928832:
	breq r0,r13,L_928850
L_928836:
	ldb_s r2,[r14,0xb]
L_928838:
	ldb_s r1,[r14,0x9]
L_92883a:
	bclr r1,r1,r2
L_92883e:
	bl.d L_92d400
L_928842:
	stb_s r1,[r14,0x9]
L_928844:
	mov_s r2,r0
L_928846:
	ldb_s r0,[r14,0xa]
L_928848:
	bl.d L_9278fc
L_92884c:
	mov_s r1,0x0
L_92884e:
	stb_s r13,[r14,0xa]
	.global L_928850
L_928850:
	b L_9202a4
