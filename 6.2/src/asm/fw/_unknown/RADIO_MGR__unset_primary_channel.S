/* RADIO_MGR__unset_primary_channel @ 0x8ea87c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::unset_primary_channel
 * Зовут его: discovery__tsf_wa, mlme_sm__disconnect_ev_handle, pcp_stop__flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global RADIO_MGR__unset_primary_channel
RADIO_MGR__unset_primary_channel:
	.global L_8ea87c
L_8ea87c:
	push_s blink
L_8ea87e:
	push_s r13
L_8ea880:
	sub_s sp,sp,0x8
L_8ea882:
	mov_s r1,0x1019044
L_8ea888:
	bl.d L_8dcba8
L_8ea88c:
	mov_s r0,0x28
L_8ea88e:
	ld_s r0,[gp,-0x40]
L_8ea890:
	mov_s r2,0xffff
L_8ea896:
	ld_s r1,[r0]
L_8ea898:
	ld_s r13,[r1,0x4]
L_8ea89a:
	mov_s r1,0x0
L_8ea89c:
	mov_s r3,r1
L_8ea89e:
	mov_s r4,r1
L_8ea8a0:
	mov_s r5,r1
L_8ea8a2:
	mov_s r6,r1
L_8ea8a4:
	jl_s.d [r13]
L_8ea8a6:
	mov_s r7,r1
L_8ea8a8:
	b.d L_8c025c
L_8ea8ac:
	add_s sp,sp,0x8
L_8ea8ae:
	nop_s
