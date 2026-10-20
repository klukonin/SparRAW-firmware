/* brd_if__parse_chunk_header @ 0x8c7444, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_chunk_in_address_data_pairs_format, brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, brd_if__bounds_check
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if__parse_chunk_header
brd_if__parse_chunk_header:
	.global L_8c7444
L_8c7444:
	push_s blink
L_8c7446:
	bl.d L_8c01e0
L_8c744a:
	mov_s r10,r0
L_8c744c:
	mov_s r9,r1
L_8c744e:
	mov_s r13,r2
L_8c7450:
	add r15,r5,0x4
L_8c7454:
	ldw_s r1,[r15]
L_8c7456:
	mov r7,r4
L_8c745a:
	mov_s r8,r3
L_8c745c:
	brlt.d r1,0x2,L_8c74a4
L_8c7460:
	ld r6,[r5]
L_8c7464:
	asl_s r0,r1,0x3
L_8c7466:
	ld r2,[r6]
L_8c746a:
	add1_s r0,r0,r0
L_8c746c:
	sub_s r0,r0,0x14
L_8c746e:
	brlo.d r13,r2,L_8c74ae
L_8c7472:
	ld r0,[r0,r6]
L_8c7476:
	brlo r0,r13,L_8c74ae
L_8c747a:
	brlt.d r1,0x1,L_8c74ae
L_8c747e:
	mov_s r14,0x0
	.global L_8c7480
L_8c7480:
	mov_s r0,r10
L_8c7482:
	mov_s r1,r9
L_8c7484:
	mov_s r2,r13
L_8c7486:
	mov_s r3,r8
L_8c7488:
	mov r4,r7
L_8c748c:
	bl.d L_8e2188
L_8c7490:
	mov r5,r6
L_8c7494:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8c7496:
	ldw_s r0,[r15]
L_8c7498:
	extw_s r14,r14
L_8c749a:
	brlt.d r14,r0,L_8c7480
L_8c749e:
	add r6,r6,0x18
L_8c74a2:
	b_s L_8c74ae
	.global L_8c74a4
L_8c74a4:
	mov_s r1,r9
L_8c74a6:
	bl.d L_8e2188
L_8c74aa:
	mov r5,r6
	.global L_8c74ae
L_8c74ae:
	b L_8c024c
L_8c74b2:
	nop_s
