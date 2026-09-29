/* STREAM_MGR @ 0x8de468, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: REMOVE STREAM [%d] belongs to CID %d.
 *   STREAM_MGR: no streams to remove for CID %d.
 * Зовут его: l2mgr__disconnect_flow
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, stream__inject_evt1, ul_stream__ba_sm_evt
 */
	.section .text.STREAM_MGR,"ax",@progbits
	.global STREAM_MGR
STREAM_MGR:
	.global L_8de468
L_8de468:
	push_s blink
L_8de46a:
	bl L_8c02bc
L_8de46e:
	mov_s r13,r0
L_8de470:
	mov_s r0,0x0
L_8de472:
	b_s L_8de476
	.global L_8de474
L_8de474:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8de476
L_8de476:
	brhs r0,0xa,L_8de4ce
L_8de47a:
	mov_s r3,0x8485dc
L_8de480:
	sub3 r3,r3,0x100
L_8de484:
	add2_s r3,r3,r0
L_8de486:
	ld r14,[r3,0x818]
L_8de48e:
	breq_s r14,0,L_8de474
L_8de490:
	ld_s r3,[r14]
L_8de492:
	brne r13,r3,L_8de474
L_8de496:
	add3 r0,r14,0x10
L_8de49a:
	st_s r1,[r0,0x4c]
L_8de49c:
	st_s r2,[r0,0x50]
L_8de49e:
	mov_s r1,0x1
L_8de4a0:
	mov_s r16,r1
L_8de4a2:
	st_s r1,[r0,0x44]
L_8de4a4:
	mov_s r15,0x0
L_8de4a6:
	st_s r15,[r0,0x40]
L_8de4a8:
	ldb r4,[r3, 0x8]
L_8de4ac:
	mov_s r2,0x100e940
L_8de4b2:
	mov_s r0,0xb
L_8de4b4:
	mov_s r1,0x2
L_8de4b6:
	bl.d L_8edff8
L_8de4ba:
	ldb_s r3,[r14,0x7]
L_8de4bc:
	mov_s r0,r14
L_8de4be:
	mov_s r1,0x6
L_8de4c0:
	mov_s r2,0x24
L_8de4c2:
	mov_s r3,r15
L_8de4c4:
	bl.d L_8d6afc
L_8de4c8:
	mov_s r4,r15
L_8de4ca:
	mov_s r0,r16
L_8de4cc:
	b_s L_8de4d0
	.global L_8de4ce
L_8de4ce:
	mov_s r0,0x0
	.global L_8de4d0
L_8de4d0:
	brne_s r0,0,L_8de4e8
L_8de4d2:
	mov_s r2,0x100e974
L_8de4d8:
	mov_s r0,0xb
L_8de4da:
	mov_s r1,0x2
L_8de4dc:
	bl.d L_8edfcc
L_8de4e0:
	ldb_s r3,[r13,0x8]
L_8de4e2:
	bl.d L_8e3250
L_8de4e6:
	mov_s r0,r13
	.global L_8de4e8
L_8de4e8:
	b L_8c0324
