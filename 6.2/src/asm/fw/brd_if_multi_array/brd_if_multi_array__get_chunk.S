/* brd_if_multi_array__get_chunk @ 0x8ca760, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk: chunk overflows its block boundaries, chunk_idx=%d,full_chunk_size_bytes=%d,cur_chunk_size_bytes=%d
 *   brd_if_multi_array::get_chunk: chunk overflows its block boundaries, chunks_end_bytes=%d, block_size_bytes=%d
 * Зовут его: brd_if_multi_array__get_chunk_in_address_data_pairs_format, brd_if_multi_array__get_chunk_in_data_only_format
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, brd_if__block_info, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_chunk
brd_if_multi_array__get_chunk:
	.global L_8ca760
L_8ca760:
	push_s blink
L_8ca762:
	bl L_8c01d4
L_8ca766:
	mov_s r16,r0
L_8ca768:
	mov_s r14,r1
L_8ca76a:
	mov r18,r5
L_8ca76e:
	cmp r4,0x0
L_8ca772:
	mov_s r0,0x1
L_8ca774:
	sub_s.ne r0,r0,r0
L_8ca776:
	mov_s r1,0x4
L_8ca778:
	add2_s r1,r1,r0
L_8ca77a:
	mulu64 r1,r3
L_8ca77e:
	mov_s r0,mlo
L_8ca780:
	mov_s r5,r0
L_8ca782:
	mulu64 r0,r2
L_8ca786:
	ld_s r0,[r14,0x10]
L_8ca788:
	mov_s r15,mlo
L_8ca78a:
	add r17,r0,r15
L_8ca78e:
	mulu64 r3,r2
L_8ca792:
	ld_s r13,[r14,0xc]
L_8ca794:
	mov_s r0,mlo
L_8ca796:
	cmp_s r0,r13
L_8ca798:
	sub.cs r13,r13,r0
L_8ca79c:
	mov.cc r13,0x0
L_8ca7a0:
	cmp_s r3,r13
L_8ca7a2:
	mov.cs r13,r3
L_8ca7a6:
	mulu64 r13,r1
L_8ca7aa:
	ld_s r0,[r14,0x14]
L_8ca7ac:
	add_s r15,r15,mlo
L_8ca7ae:
	brhs.d r0,r15,L_8ca7e8
L_8ca7b2:
	mov r4,mlo
L_8ca7b6:
	mov_s r1,0x100af94
L_8ca7bc:
	mov_s r0,0x0
L_8ca7be:
	bl.d L_8dcd00
L_8ca7c2:
	mov_s r3,r5
L_8ca7c4:
	mov_s r1,0x100b018
L_8ca7ca:
	mov_s r0,0x0
L_8ca7cc:
	mov_s r2,r15
L_8ca7ce:
	bl.d L_8dcc80
L_8ca7d2:
	ld_s r3,[r14,0x14]
L_8ca7d4:
	mov_s r0,r14
L_8ca7d6:
	bl.d L_8e0fa0
L_8ca7da:
	mov_s r1,0x0
L_8ca7dc:
	mov_s r0,blink
L_8ca7de:
	mov_s r1,0x1354
L_8ca7e4:
	bl L_8c9b28
	.global L_8ca7e8
L_8ca7e8:
	st r13,[r18]
L_8ca7ec:
	ld r0,[r16, 0x48]
L_8ca7f0:
	add_s r0,r0,0x8
L_8ca7f2:
	b.d L_8c0234
L_8ca7f6:
	add_s r0,r0,r17
