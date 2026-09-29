/* ba_sm__build_addba_params @ 0x8ea62c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__action_8c4394, sw_vring__ba_agreed
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, ba_sm__addba_at_08, ba_sm__addba_at_10, basic_sm__handle_event, qh__write_or_conn_alloc, sm_pring__all_wb_done_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__build_addba_params
ba_sm__build_addba_params:
	.global L_8ea62c
L_8ea62c:
	push_s blink
L_8ea62e:
	bl L_8c01d8
L_8ea632:
	sub_s sp,sp,0x70
L_8ea634:
	mov_s r14,r0
L_8ea636:
	mov_s r17,r2
L_8ea638:
	mov_s r16,r3
L_8ea63a:
	mov_s r15,r4
L_8ea63c:
	stb_s r1,[r0,0xb]
L_8ea63e:
	ldw_s r3,[r0,0xe]
L_8ea640:
	mov_s r13,sp
L_8ea642:
	ldb r4,[r0, 0xf]
L_8ea646:
	lsr_s r3,r3
L_8ea648:
	ldb_s r2,[r0,0xd]
L_8ea64a:
	mov_s r1,r13
L_8ea64c:
	bl.d L_8c7edc
L_8ea650:
	bmsk_s r3,r3,0x0
L_8ea652:
	mov_s r0,r14
L_8ea654:
	bl.d L_8c3180
L_8ea658:
	mov_s r1,r13
L_8ea65a:
	mov_s r0,r14
L_8ea65c:
	mov_s r1,r13
L_8ea65e:
	mov_s r2,r15
L_8ea660:
	mov_s r3,r17
L_8ea662:
	mov r4,r16
L_8ea666:
	mov r5,0x0
L_8ea66a:
	bl.d L_8c4540
L_8ea66e:
	mov r6,r5
L_8ea672:
	ldb_s r0,[r14,0xa]
L_8ea674:
	mov_s r1,0x16
L_8ea676:
	mov_s r2,r13
L_8ea678:
	bl.d L_8ea5b0
L_8ea67c:
	mov_s r3,r16
L_8ea67e:
	b.d L_8c023c
L_8ea682:
	add_s sp,sp,0x70
L_8ea684:
	mov_s r2,r1
L_8ea686:
	add_s r0,r0,0x28
L_8ea688:
	mov_s r1,0xb
L_8ea68a:
	mov_s r3,0x0
L_8ea68c:
	b.d L_8d9b6c
L_8ea690:
	mov_s r4,r3
L_8ea692:
	nop_s
