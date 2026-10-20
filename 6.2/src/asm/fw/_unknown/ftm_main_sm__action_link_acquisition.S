/* ftm_main_sm__action_link_acquisition @ 0x8f0780, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] ftm_main_sm::action_link_acquisition()
 *   [TOF] link_acquisition failed - connection not allocated
 *   [TOF] link_acquisition succeeded
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, find_main_sm__bcon_args, fw_log_emit0, fw_sysassert_fatal, mid_list__by_mid_fw, u_schd__schedule
 * Глобалы (через gp): 0x80035c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__action_link_acquisition
ftm_main_sm__action_link_acquisition:
	.global L_8f0780
L_8f0780:
	push_s blink
L_8f0782:
	bl L_8c01e4
L_8f0786:
	mov_s r13,r0
L_8f0788:
	mov_s r1,0x1019f50
L_8f078e:
	bl.d L_8dcba8
L_8f0792:
	mov_s r0,0x20
L_8f0794:
	mov_s r0,0x331c4
L_8f079a:
	ld.as r4,[gp,0x76]
L_8f079e:
	mov_s r1,r13
L_8f07a0:
	mov_s r2,0x0
L_8f07a2:
	mov_s r3,0x1
L_8f07a4:
	mov_s r5,r2
L_8f07a6:
	bl.d L_8e0c0c
L_8f07aa:
	mov_s r6,r2
L_8f07ac:
	st_s r0,[r13,0x10]
L_8f07ae:
	bl.d L_8cc3dc
L_8f07b2:
	mov_s r0,0x0
L_8f07b4:
	mov.f r14,r0
L_8f07b8:
	beq_s L_8f07ec
	.global L_8f07ba
L_8f07ba:
	mov_s r0,r14
L_8f07bc:
	ld_s r1,[r13,0x1c]
L_8f07be:
	mov_s r2,0x0
L_8f07c0:
	mov r4,0xffff
L_8f07c8:
	bl.d L_8da8fc
L_8f07cc:
	mov_s r3,r2
L_8f07ce:
	brne_s r0,0,L_8f07fa
L_8f07d0:
	mov_s r1,0x1019f80
L_8f07d6:
	bl.d L_8dcba8
L_8f07da:
	mov_s r0,0x20
L_8f07dc:
	mov_s r0,r13
L_8f07de:
	mov_s r1,0x6
L_8f07e0:
	mov_s r2,0x0
L_8f07e2:
	mov_s r3,r2
L_8f07e4:
	bl.d L_8d9b6c
L_8f07e8:
	mov_s r4,r2
L_8f07ea:
	b_s L_8f0806
	.global L_8f07ec
L_8f07ec:
	mov_s r0,blink
L_8f07ee:
	mov_s r1,0x16be
L_8f07f4:
	bl L_8c9b28
L_8f07f8:
	b_s L_8f07ba
	.global L_8f07fa
L_8f07fa:
	mov_s r1,0x1019fbc
L_8f0800:
	bl.d L_8dcba8
L_8f0804:
	mov_s r0,0x20
	.global L_8f0806
L_8f0806:
	b L_8c0254
L_8f080a:
	nop_s
