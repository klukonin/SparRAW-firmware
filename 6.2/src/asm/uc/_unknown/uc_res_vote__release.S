/* uc_res_vote__release @ 0x92bb94, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__clear_pending, internal_tx__flow_sm6, internal_tx__update_state_locked, ps__release_awake_for_sta
 * Зовёт сам: __ld_r13_to_r13_ret, bi_tx__check_idle_and_start_uc, mac__publish_masks
 * Глобалы (через gp): 0x800550
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_res_vote__release
uc_res_vote__release:
	.global L_92bb94
L_92bb94:
	push_s blink
L_92bb96:
	push_s r13
L_92bb98:
	lr r13,[0xa]
L_92bb9c:
	bclr r1,r13,0x1
L_92bba0:
	flag r1
L_92bba4:
	ld.as r1,[gp,0xa]
L_92bba8:
	bclr.f r1,r1,r0
L_92bbac:
	st.as r1,[gp,0xa]
L_92bbb0:
	bne_s L_92bbc6
L_92bbb2:
	ld_s r0,[gp,-0x7c]
L_92bbb4:
	or r0,r0,0x70
L_92bbb8:
	bl.d L_93d0ac
L_92bbbc:
	st.as r0,[gp,-0x1f]
L_92bbc0:
	bl.d L_93696c
L_92bbc4:
	mov_s r0,0x2
	.global L_92bbc6
L_92bbc6:
	lr r0,[0xa]
L_92bbca:
	bic r13,r13,-0x3
L_92bbce:
	or_s r13,r13,r0
L_92bbd0:
	flag r13
L_92bbd4:
	b L_9202ac
