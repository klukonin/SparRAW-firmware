/* vring_schd__resume_vring @ 0x8de858, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schd::resume_vring. vr_index:%d.
 *   vring_schdlr.cpp
 * Зовут его: ba__report_and_resume, sw_vring__ba_agreed, vring__wait_macq_delete
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, hwd_dma__get_881c80, llist__remove, vring__disable_and_ack, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.vring_schd__resume_vring,"ax",@progbits
	.global vring_schd__resume_vring
vring_schd__resume_vring:
	.global L_8de858
L_8de858:
	push_s blink
L_8de85a:
	bl.d L_8c02bc
L_8de85e:
	mov_s r1,0x2
L_8de860:
	mov_s r16,r0
L_8de862:
	mov_s r0,0x0
L_8de864:
	push_s r0
L_8de866:
	mov_s r2,0x100a740
L_8de86c:
	mov_s r0,0x7
L_8de86e:
	bl.d L_8edfcc
L_8de872:
	mov_s r3,r16
L_8de874:
	mov_s r13,0x804580
L_8de87a:
	mov_s r3,sp
L_8de87c:
	mov_s r0,r13
L_8de87e:
	mov_s r1,r13
L_8de880:
	bl.d L_8e727c
L_8de884:
	mov_s r2,r16
L_8de886:
	brne_s r0,0,L_8de8a0
L_8de888:
	mov_s r0,blink
L_8de88a:
	mov_s r2,0x100a584
L_8de890:
	mov_s r1,0x12ba
L_8de896:
	bl.d L_8c82c0
L_8de89a:
	mov r3,0x1aa
L_8de89e:
	b_s L_8de8c8
	.global L_8de8a0
L_8de8a0:
	ld_s r0,[sp,0x0]
L_8de8a2:
	mov_s r1,0x1
L_8de8a4:
	st_s r1,[r0,0x20]
L_8de8a6:
	bl.d L_8cdae8
L_8de8aa:
	mov_s r0,r16
L_8de8ac:
	ld_s r1,[sp,0x0]
L_8de8ae:
	brne r0,0x1,L_8de8c2
L_8de8b2:
	bl.d L_8de4ec
L_8de8b6:
	mov_s r0,r13
L_8de8b8:
	mov_s r0,r13
L_8de8ba:
	bl.d L_8c1e44
L_8de8be:
	ld_s r1,[sp,0x0]
L_8de8c0:
	b_s L_8de8c8
	.global L_8de8c2
L_8de8c2:
	bl.d L_8d5244
L_8de8c6:
	mov_s r0,r1
	.global L_8de8c8
L_8de8c8:
	b.d L_8c0324
L_8de8cc:
	add_s sp,sp,0x4
L_8de8ce:
	nop_s
