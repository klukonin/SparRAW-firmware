/* ftm_main_sm__action_radio_tunned @ 0x8f088c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] ftm_main_sm::action_radio_tunned()
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__action_radio_tunned
ftm_main_sm__action_radio_tunned:
	.global L_8f088c
L_8f088c:
	push_s blink
L_8f088e:
	bl L_8c01e4
L_8f0892:
	mov_s r13,r0
L_8f0894:
	mov_s r1,0x1019f24
L_8f089a:
	bl.d L_8dcba8
L_8f089e:
	mov_s r0,0x20
L_8f08a0:
	ld_s r0,[r13,0x14]
L_8f08a2:
	mov_s r14,0x0
L_8f08a4:
	breq_s r0,0,L_8f08ac
L_8f08a6:
	bl L_8c8de0
L_8f08aa:
	st_s r14,[r13,0x14]
	.global L_8f08ac
L_8f08ac:
	mov_s r0,r13
L_8f08ae:
	mov_s r1,0x5
L_8f08b0:
	mov_s r2,0x0
L_8f08b2:
	mov_s r3,r2
L_8f08b4:
	bl.d L_8d9b6c
L_8f08b8:
	mov_s r4,r2
L_8f08ba:
	b L_8c0254
L_8f08be:
	nop_s
