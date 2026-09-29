/* l2mgr__disconnect_sta @ 0x8eb494, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Disconnect not-exist STA
 *   layer2_mgr.cpp
 * Зовут его: l2mgr__data_port_open, l2mgr__install_key, wmi_handler_disconnect_sta
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_sysassert_fatal, get_g_8000ac_8e15e0, l2mgr__send_disconnect_evt, mid__disconnect_cmd, mid_list__by_mid, mid_list__find_by
 */
	.section .text.l2mgr__disconnect_sta,"ax",@progbits
	.global l2mgr__disconnect_sta
l2mgr__disconnect_sta:
	.global L_8eb494
L_8eb494:
	push_s blink
L_8eb496:
	bl L_8c02b4
L_8eb49a:
	mov_s r17,r0
L_8eb49c:
	mov_s r16,r1
L_8eb49e:
	mov_s r18,r2
L_8eb4a0:
	bl.d L_8e15e0
L_8eb4a4:
	mov_s r0,0x2
L_8eb4a6:
	bl.d L_8ca1b0
L_8eb4aa:
	mov_s r0,r17
L_8eb4ac:
	mov.f r13,r0
L_8eb4b0:
	beq_s L_8eb4dc
	.global L_8eb4b2
L_8eb4b2:
	mov_s r0,r13
L_8eb4b4:
	bl.d L_8c9e74
L_8eb4b8:
	mov_s r1,r16
L_8eb4ba:
	mov.f r1,r0
L_8eb4be:
	bne_s L_8eb4f4
L_8eb4c0:
	mov_s r2,0x100c698
L_8eb4c6:
	mov_s r0,0xb
L_8eb4c8:
	bl.d L_8edfb0
L_8eb4cc:
	mov_s r1,0x1
L_8eb4ce:
	mov_s r0,r16
L_8eb4d0:
	mov_s r1,0x1
L_8eb4d2:
	mov_s r2,0x2
L_8eb4d4:
	bl.d L_8f051c
L_8eb4d8:
	mov_s r3,r17
L_8eb4da:
	b_s L_8eb4fe
	.global L_8eb4dc
L_8eb4dc:
	mov_s r0,blink
L_8eb4de:
	mov_s r2,0x100c474
L_8eb4e4:
	mov_s r1,0x11e1
L_8eb4ea:
	bl.d L_8c82c0
L_8eb4ee:
	mov r3,0x546
L_8eb4f2:
	b_s L_8eb4b2
	.global L_8eb4f4
L_8eb4f4:
	mov_s r0,r13
L_8eb4f6:
	mov_s r2,0x2
L_8eb4f8:
	bl.d L_8c7c3c
L_8eb4fc:
	mov_s r3,r18
	.global L_8eb4fe
L_8eb4fe:
	b L_8c0314
L_8eb502:
	nop_s
