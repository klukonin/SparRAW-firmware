/* stream_mgr__add_bcast_vring @ 0x8c2720, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_bcast_vring_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, hwd_dma__macq_reg_addr, l2mgr__send_vring_cfg_done, vring__active_ring_table, vring_schd__alloc_pring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__add_bcast_vring
stream_mgr__add_bcast_vring:
	.global L_8c2720
L_8c2720:
	push_s blink
L_8c2722:
	bl L_8c01dc
L_8c2726:
	mov_s r13,r0
L_8c2728:
	ldb_s r14,[r0,0x7]
L_8c272a:
	mov_s r15,0x847f34
L_8c2730:
	add2_s r15,r15,r14
L_8c2732:
	ld_s r0,[r15,0x4c]
L_8c2734:
	mov_s r16,r1
L_8c2736:
	brne_s r0,0,L_8c2768
	.global L_8c2738
L_8c2738:
	bl.d L_8cd080
L_8c273c:
	st_s r13,[r15,0x4c]
L_8c273e:
	ld_s r1,[r0]
L_8c2740:
	mov_s r2,r13
L_8c2742:
	ld_s r15,[r1,0xc]
L_8c2744:
	mov_s r1,r16
L_8c2746:
	mov_s r3,0x0
L_8c2748:
	jl_s.d [r15]
L_8c274a:
	mov_s r4,r3
L_8c274c:
	bl.d L_8c2428
L_8c2750:
	mov_s r0,r14
L_8c2752:
	bl.d L_8d083c
L_8c2756:
	mov_s r0,r14
L_8c2758:
	mov_s r1,r0
L_8c275a:
	mov_s r0,r14
L_8c275c:
	mov_s r2,0x0
L_8c275e:
	bl.d L_8f8e98
L_8c2762:
	ld_s r3,[r13,0x8]
L_8c2764:
	b L_8c0244
	.global L_8c2768
L_8c2768:
	mov_s r0,blink
L_8c276a:
	mov_s r1,0x1287
L_8c2770:
	bl L_8c9b28
L_8c2774:
	b_s L_8c2738
L_8c2776:
	nop_s
