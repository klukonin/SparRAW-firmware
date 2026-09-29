/* find_sm__start_listen @ 0x8f9670, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__activate_conn, mid__link_acquisition_action
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, lm_if__set_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_sm__start_listen
find_sm__start_listen:
	.global L_8f9670
L_8f9670:
	push_s blink
L_8f9672:
	bl L_8c01e4
L_8f9676:
	mov_s r13,r0
L_8f9678:
	mov_s r14,r1
L_8f967a:
	add_s r0,r0,0x70
L_8f967c:
	bl.d L_8e63a4
L_8f9680:
	extb_s r1,r1
L_8f9682:
	ld_s r0,[r13,0x24]
L_8f9684:
	mov_s r3,0x0
L_8f9686:
	brne r0,0x1,L_8f9692
L_8f968a:
	ld_s r0,[r13,0x28]
L_8f968c:
	cmp_s r0,0x0
L_8f968e:
	mov.eq r3,0x1
	.global L_8f9692
L_8f9692:
	extb_s r3,r3
L_8f9694:
	mov_s r0,r13
L_8f9696:
	add r0,r0,0x124
L_8f969a:
	mov_s r1,0x0
L_8f969c:
	mov_s r2,r14
L_8f969e:
	bl.d L_8d9b6c
L_8f96a2:
	mov_s r4,r1
L_8f96a4:
	b L_8c0254
