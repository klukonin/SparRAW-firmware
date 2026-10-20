/* mid_list__by_mid_fw @ 0x8cc3dc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__send_packet, bcon_ctrl__prepare_mid_fw, channel_estimation_cmd_start, conn__alloc_and_link, conn_main_sm__action_step, disconnect_by_peer, find_mng__add_bcon, fixed_sched__start, ftm_main_sm__action_link_acquisition, handle_packet_splitmac
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_list__by_mid_fw
mid_list__by_mid_fw:
	.global L_8cc3dc
L_8cc3dc:
	push_s blink
L_8cc3de:
	bl L_8c01e4
L_8cc3e2:
	sub_s sp,sp,0x4
L_8cc3e4:
	mov_s r14,r0
L_8cc3e6:
	mov_s r13,sp
L_8cc3e8:
	mov_s r1,0x804e70
L_8cc3ee:
	bl.d L_8e5df4
L_8cc3f2:
	mov_s r0,r13
L_8cc3f4:
	b_s L_8cc402
	.global L_8cc3f6
L_8cc3f6:
	bl.d L_8df438
L_8cc3fa:
	mov_s r0,r13
L_8cc3fc:
	ldb_s r1,[r0,0x10]
L_8cc3fe:
	breq r14,r1,L_8cc40c
	.global L_8cc402
L_8cc402:
	bl.d L_8cdcb8
L_8cc406:
	mov_s r0,r13
L_8cc408:
	brne_s r0,0,L_8cc3f6
L_8cc40a:
	mov_s r0,0x0
	.global L_8cc40c
L_8cc40c:
	b.d L_8c0254
L_8cc410:
	add_s sp,sp,0x4
L_8cc412:
	nop_s
