/* brd_if_multi_array__check_physical_section_validity @ 0x8c5614, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::check_physical_section_validity: Unknown section_type=%d,sections_count=%d
 *   brd_if_multi_array::find_section: Bad validation pattern, actual_pattern=0x%X, vp1_allowed=0x%X, vp2_allowed=0x%X
 *   brd_if_multi_array::check_physical_section_validity: Length of section (section_type=%d) exceeds brd file boundary
 *   brd_if_multi_array::check_physical_section_validity: buffer_size=%d, secton_offset_bytes=%d, section_size_bytes=%d
 *   brd_if_multi_array::check_physical_section_validity: actual_vp=%d, vps_allowed.vp1=%d, vps_allowed.vp2=%d
 *   brd_if_multi_array.cpp
 *   brd_if_multi_array::find_section: Corrupted physical section header
 *   brd_if_multi_array::find_section: Physical section type=%d doesn't match virtual section type=%d
 * Зовут его: brd_if_multi_array__find_section
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, brd_if__check_section_header, brd_if__section_matches_bank, brd_if_multi_array__physical_section_header_u__print2log, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.brd_if_multi_array__check_physical_section_validity,"ax",@progbits
	.global brd_if_multi_array__check_physical_section_validity
brd_if_multi_array__check_physical_section_validity:
	.global L_8c5614
L_8c5614:
	push_s blink
L_8c5616:
	bl L_8c02b0
L_8c561a:
	mov_s r14,r0
L_8c561c:
	mov_s r17,r1
L_8c561e:
	mov_s r18,r2
L_8c5620:
	mov_s r19,r3
L_8c5622:
	brlo.d r1,0xa,L_8c5640
L_8c5626:
	mov_s r13,r4
L_8c5628:
	mov_s r2,0x100943c
L_8c562e:
	mov_s r0,0x0
L_8c5630:
	mov_s r1,r0
L_8c5632:
	mov_s r3,r17
L_8c5634:
	bl.d L_8edff8
L_8c5638:
	mov r4,0xa
L_8c563c:
	mov_s r0,0x0
L_8c563e:
	b_s L_8c573a
	.global L_8c5640
L_8c5640:
	ld_s r0,[r14,0x4]
L_8c5642:
	ld r4,[r13]
L_8c5646:
	add_s r0,r0,0x8
L_8c5648:
	add r16,r0,r18
L_8c564c:
	ld r15,[r16]
L_8c5650:
	mov_s r0,0x0
L_8c5652:
	breq r15,r4,L_8c565c
L_8c5656:
	ld_s r1,[r13,0x4]
L_8c5658:
	brne r15,r1,L_8c565e
	.global L_8c565c
L_8c565c:
	mov_s r0,0x1
	.global L_8c565e
L_8c565e:
	extb.f 0x0,r0
L_8c5662:
	bne_s L_8c567c
L_8c5664:
	mov_s r2,0x100949c
L_8c566a:
	ld r5,[r13, 0x4]
L_8c566e:
	mov_s r0,0x0
L_8c5670:
	mov_s r1,r0
L_8c5672:
	bl.d L_8ee034
L_8c5676:
	mov_s r3,r15
L_8c5678:
	mov_s r0,0x0
L_8c567a:
	b_s L_8c573a
	.global L_8c567c
L_8c567c:
	ld_s r0,[r14,0x8]
L_8c567e:
	add r1,r19,r18
L_8c5682:
	sub_s r0,r0,0x8
L_8c5684:
	brhs r0,r1,L_8c56ea
L_8c5688:
	mov_s r2,0x1009510
L_8c568e:
	mov_s r0,0x0
L_8c5690:
	mov_s r1,r0
L_8c5692:
	bl.d L_8edfcc
L_8c5696:
	mov_s r3,r17
L_8c5698:
	ld_s r3,[r14,0x8]
L_8c569a:
	mov_s r2,0x1009584
L_8c56a0:
	sub_s r3,r3,0x8
L_8c56a2:
	mov_s r0,0x0
L_8c56a4:
	mov_s r1,r0
L_8c56a6:
	mov r4,r18
L_8c56aa:
	bl.d L_8ee034
L_8c56ae:
	mov r5,r19
L_8c56b2:
	mov_s r0,0x0
L_8c56b4:
	ld r4,[r13]
L_8c56b8:
	mov_s r2,0x10095f8
L_8c56be:
	ld r5,[r13, 0x4]
L_8c56c2:
	mov_s r1,r0
L_8c56c4:
	bl.d L_8ee034
L_8c56c8:
	mov_s r3,r15
L_8c56ca:
	add r0,r16,0x8
L_8c56ce:
	bl.d L_8dcc98
L_8c56d2:
	mov_s r1,0x0
L_8c56d4:
	mov_s r0,blink
L_8c56d6:
	mov_s r2,0x1009220
L_8c56dc:
	mov_s r1,0x1366
L_8c56e2:
	bl.d L_8c82c0
L_8c56e6:
	mov r3,0x140
	.global L_8c56ea
L_8c56ea:
	add r13,r16,0x8
L_8c56ee:
	mov_s r0,r14
L_8c56f0:
	bl.d L_8e7198
L_8c56f4:
	mov_s r1,r13
L_8c56f6:
	brne_s r0,0,L_8c570a
L_8c56f8:
	mov_s r2,0x1009664
L_8c56fe:
	mov_s r0,0x0
L_8c5700:
	bl.d L_8edfb0
L_8c5704:
	mov_s r1,0x0
L_8c5706:
	mov_s r0,0x0
L_8c5708:
	b_s L_8c573a
	.global L_8c570a
L_8c570a:
	ld_s r2,[r13]
L_8c570c:
	mov_s r0,r14
L_8c570e:
	lsr_s r2,r2,0x14
L_8c5710:
	mov_s r1,r17
L_8c5712:
	bl.d L_8c575c
L_8c5716:
	bmsk_s r2,r2,0x3
L_8c5718:
	brne_s r0,0,L_8c5738
L_8c571a:
	ld_s r3,[r13]
L_8c571c:
	mov_s r2,0x10096a8
L_8c5722:
	lsr_s r3,r3,0x14
L_8c5724:
	mov_s r13,0x0
L_8c5726:
	mov_s r0,r13
L_8c5728:
	mov_s r1,r13
L_8c572a:
	bmsk_s r3,r3,0x3
L_8c572c:
	bl.d L_8edff8
L_8c5730:
	mov r4,r17
L_8c5734:
	mov_s r0,r13
L_8c5736:
	b_s L_8c573a
	.global L_8c5738
L_8c5738:
	mov_s r0,0x1
	.global L_8c573a
L_8c573a:
	b L_8c030c
L_8c573e:
	nop_s
