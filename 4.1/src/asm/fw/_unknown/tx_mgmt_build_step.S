/* tx_mgmt_build_step @ 0x8ec89c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mgmt_srvs__build_dmg_beacon
 * Зовёт сам: BUILDER_push_dmg_parameters, __ld_r17_to_r13_ret, __st_r17_to_r13, get_g_80040c, ie__push_awake_window, memset0_words, mgmt_tx__push_bi_control, mgmt_tx__push_clustering_control, mgmt_tx__set_frame_control, mid__get_awake_window
 * Глобалы (через gp): 0x8002c0
 */
	.section .text.tx_mgmt_build_step,"ax",@progbits
	.global tx_mgmt_build_step
tx_mgmt_build_step:
	.global L_8ec89c
L_8ec89c:
	push_s blink
L_8ec89e:
	bl L_8c02b8
L_8ec8a2:
	mov_s r14,r0
L_8ec8a4:
	mov_s r15,r1
L_8ec8a6:
	bl.d L_8e8974
L_8ec8aa:
	add3 r16,r1,0x9
L_8ec8ae:
	mov_s r13,r0
L_8ec8b0:
	add r0,r14,0xa
L_8ec8b4:
	bl.d L_8c1a78
L_8ec8b8:
	mov_s r1,0x8
L_8ec8ba:
	ld.as r1,[gp,0x54]
L_8ec8be:
	add_s r13,r13,0xd
L_8ec8c0:
	stb_s r1,[r14,0x15]
L_8ec8c2:
	lsr_s r1,r1,0x8
L_8ec8c4:
	stb_s r1,[r14,0x16]
L_8ec8c6:
	add r0,r14,0x17
L_8ec8ca:
	bl.d L_8e8960
L_8ec8ce:
	mov_s r1,r15
L_8ec8d0:
	add_s r13,r13,r0
L_8ec8d2:
	add r0,r14,0x1d
L_8ec8d6:
	bl.d L_8e89b8
L_8ec8da:
	mov_s r1,r15
L_8ec8dc:
	add_s r13,r13,r0
L_8ec8de:
	ldb_s r0,[r14,0x17]
L_8ec8e0:
	add r17,r14,r13
L_8ec8e4:
	bbit0 r0,0x0,L_8ec8f6
L_8ec8e8:
	mov_s r0,r17
L_8ec8ea:
	bl.d L_8e894c
L_8ec8ee:
	mov_s r1,r15
L_8ec8f0:
	add_s r13,r13,r0
L_8ec8f2:
	add r17,r14,r13
	.global L_8ec8f6
L_8ec8f6:
	bl.d L_8c3720
L_8ec8fa:
	mov_s r0,r16
L_8ec8fc:
	brne_s r0,0,L_8ec908
L_8ec8fe:
	mov_s r0,0x80345c
L_8ec904:
	ld_s r0,[r0,0xc]
L_8ec906:
	breq_s r0,0,L_8ec918
	.global L_8ec908
L_8ec908:
	bl.d L_8c989c
L_8ec90c:
	mov_s r0,r16
L_8ec90e:
	mov_s r1,r0
L_8ec910:
	bl.d L_8ef82c
L_8ec914:
	mov_s r0,r17
L_8ec916:
	add_s r13,r13,r0
	.global L_8ec918
L_8ec918:
	b.d L_8c031c
L_8ec91c:
	mov_s r0,r13
L_8ec91e:
	nop_s
