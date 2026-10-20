/* llist__pop_front @ 0x8e2674, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets, channels_switch_sm__action_pop_ch_and_tune, conn_mgr__allocate_cid_db_element, find_main_sm__stop, fwq_tx__handle_completion, fwq_tx__queue_step, radio_req__addr_of, rm__llist_pop_front_thunk, rx_api__drain_list, scan_mngr__clean_all_lists
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global llist__pop_front
llist__pop_front:
	.global L_8e2674
L_8e2674:
	push_s r13
L_8e2676:
	ld_s r2,[r0]
L_8e2678:
	mov_s r1,r0
L_8e267a:
	cmp_s r2,0x0
L_8e267c:
	mov_s r0,0x1
L_8e267e:
	sub_s.ne r0,r0,r0
L_8e2680:
	extb.f 0x0,r0
L_8e2684:
	mov_s r0,0x0
L_8e2686:
	bne_s L_8e26a0
L_8e2688:
	ld_s r0,[r1,0x4]
L_8e268a:
	ld_s r3,[r1,0x8]
L_8e268c:
	mov_s r13,0x0
L_8e268e:
	brne r0,r3,L_8e2694
L_8e2692:
	st_s r13,[r1,0x8]
	.global L_8e2694
L_8e2694:
	ld_s r3,[r0]
L_8e2696:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8e2698:
	st_s r3,[r1,0x4]
L_8e269a:
	st_s r2,[r1]
L_8e269c:
	st_s r13,[r0]
L_8e269e:
	st_s r13,[r0,0x4]
	.global L_8e26a0
L_8e26a0:
	j_s.d [blink]
L_8e26a2:
	pop_s r13
