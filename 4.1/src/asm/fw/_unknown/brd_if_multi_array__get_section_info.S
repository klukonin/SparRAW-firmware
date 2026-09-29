/* brd_if_multi_array__get_section_info @ 0x8ca834, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_section_info: Access to non-initialized Board File Interface
 *   brd_if_multi_array::get_section_info: Bad arguments p_section_info_out=0x%X, section_type=%d, sections_count=%d
 *   brd_if_multi_array::get_section_info(): Section type %d not found in the board file
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, brd_if__clear_section_info, brd_if_multi_array__find_section, fw_log__emit0, fw_log__emit1, fw_log__emit3, stub_ret_8e70d8
 */
	.section .text.brd_if_multi_array__get_section_info,"ax",@progbits
	.global brd_if_multi_array__get_section_info
brd_if_multi_array__get_section_info:
L_8ca834:
	push_s blink
L_8ca836:
	bl L_8c02c0
L_8ca83a:
	mov_s r13,r0
L_8ca83c:
	ld_s r0,[r0,0xc]
L_8ca83e:
	mov_s r15,r1
L_8ca840:
	mov_s r14,r2
L_8ca842:
	brne_s r0,0,L_8ca856
L_8ca844:
	mov_s r2,0x1009794
L_8ca84a:
	mov_s r0,0x0
L_8ca84c:
	bl.d L_8edfb0
L_8ca850:
	mov_s r1,r0
L_8ca852:
	mov_s r13,0x0
L_8ca854:
	b_s L_8ca8a4
	.global L_8ca856
L_8ca856:
	breq_s r14,0,L_8ca85c
L_8ca858:
	brlo r15,0xa,L_8ca876
	.global L_8ca85c
L_8ca85c:
	mov_s r2,0x10097ec
L_8ca862:
	mov_s r13,0x0
L_8ca864:
	mov_s r0,r13
L_8ca866:
	mov_s r1,r13
L_8ca868:
	mov_s r3,r14
L_8ca86a:
	mov_s r4,r15
L_8ca86c:
	bl.d L_8ee034
L_8ca870:
	mov r5,0xa
L_8ca874:
	b_s L_8ca8a4
	.global L_8ca876
L_8ca876:
	bl.d L_8c5a20
L_8ca87a:
	mov_s r0,r14
L_8ca87c:
	mov_s r0,r13
L_8ca87e:
	mov_s r1,r15
L_8ca880:
	bl.d L_8c8dc8
L_8ca884:
	mov_s r2,r14
L_8ca886:
	brne_s r0,0,L_8ca89c
L_8ca888:
	mov_s r2,0x100985c
L_8ca88e:
	mov_s r13,0x0
L_8ca890:
	mov_s r0,r13
L_8ca892:
	mov_s r1,r13
L_8ca894:
	bl.d L_8edfcc
L_8ca898:
	mov_s r3,r15
L_8ca89a:
	b_s L_8ca8a4
	.global L_8ca89c
L_8ca89c:
	bl.d L_8e70d8
L_8ca8a0:
	mov_s r0,r14
L_8ca8a2:
	mov_s r13,0x1
	.global L_8ca8a4
L_8ca8a4:
	b.d L_8c032c
L_8ca8a8:
	mov_s r0,r13
L_8ca8aa:
	nop_s
