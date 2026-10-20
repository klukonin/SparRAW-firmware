/* llist__pop_front @ 0x8de2d4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets, channels_switch_sm__action_pop_ch_and_tune, find_main_sm__stop, find_sm__start_search, fwq_tx__send_next, llist_pair__insert_into_shorter, rx_api__drain_list, scan_mngr__abort_scan, scan_mngr__clean_all_lists, tail_llist__is_empty
 */
	.section .text.llist__pop_front,"ax",@progbits
	.global llist__pop_front
llist__pop_front:
	.global L_8de2d4
L_8de2d4:
	push_s r13
L_8de2d6:
	ld_s r2,[r0]
L_8de2d8:
	mov_s r1,r0
L_8de2da:
	cmp_s r2,0x0
L_8de2dc:
	mov_s r0,0x1
L_8de2de:
	sub_s.ne r0,r0,r0
L_8de2e0:
	extb.f 0x0,r0
L_8de2e4:
	mov_s r0,0x0
L_8de2e6:
	bne_s L_8de300
L_8de2e8:
	ld_s r0,[r1,0x4]
L_8de2ea:
	ld_s r3,[r1,0x8]
L_8de2ec:
	mov_s r13,0x0
L_8de2ee:
	brne r0,r3,L_8de2f4
L_8de2f2:
	st_s r13,[r1,0x8]
	.global L_8de2f4
L_8de2f4:
	ld_s r3,[r0]
L_8de2f6:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8de2f8:
	st_s r3,[r1,0x4]
L_8de2fa:
	st_s r2,[r1]
L_8de2fc:
	st_s r13,[r0]
L_8de2fe:
	st_s r13,[r0,0x4]
	.global L_8de300
L_8de300:
	j_s.d [blink]
L_8de302:
	pop_s r13
