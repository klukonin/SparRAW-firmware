/* l2mgr__send_data_port_open_evt @ 0x8f8854, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DATA_PORT_OPEN_EVENTID for CID %d.
 * Зовут его: l2mgr__data_port_open_and_keys
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, host_if__send_pair, info_flow__run, low_sme__send_evt2sw, memset0_words, mid__state_is_2_or_3, mid_list__by_mid_fw, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_data_port_open_evt
l2mgr__send_data_port_open_evt:
	.global L_8f8854
L_8f8854:
	push_s blink
L_8f8856:
	bl L_8c01dc
L_8f885a:
	mov_s r13,r0
L_8f885c:
	bl.d L_8c32d8
L_8f8860:
	mov_s r16,r1
L_8f8862:
	mov_s r14,r0
L_8f8864:
	bl.d L_8c1cd8
L_8f8868:
	mov_s r1,0x4
L_8f886a:
	stb_s r13,[r14]
L_8f886c:
	mov_s r1,0x100d56c
L_8f8872:
	mov_s r0,0x2b
L_8f8874:
	bl.d L_8dcc10
L_8f8878:
	mov_s r2,r13
L_8f887a:
	mov_s r0,r14
L_8f887c:
	mov_s r1,0xc3
L_8f887e:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8f8880:
	mov_s r2,0x4
L_8f8882:
	mov_s r3,r16
L_8f8884:
	mov r4,0x0
L_8f8888:
	mov r5,r4
L_8f888c:
	bl.d L_8e5474
L_8f8890:
	mov r6,r4
L_8f8894:
	mov_s r0,0x6
L_8f8896:
	bl.d L_8e8a14
L_8f889a:
	mov_s r1,r13
L_8f889c:
	mov_s r1,0x803c00
L_8f88a2:
	ld_s r0,[r1,0xc]
L_8f88a4:
	brne_s r0,0,L_8f88aa
L_8f88a6:
	ld_s r0,[r1,0x10]
L_8f88a8:
	breq_s r0,0,L_8f88c2
	.global L_8f88aa
L_8f88aa:
	bl.d L_8cc3dc
L_8f88ae:
	mov_s r0,r16
L_8f88b0:
	breq_s r0,0,L_8f88c6
	.global L_8f88b2
L_8f88b2:
	bl.d L_8da488
L_8f88b6:
	mov_s r0,r16
L_8f88b8:
	cmp_s r0,0x0
L_8f88ba:
	bl.ne.d L_8d86f0
L_8f88be:
	mov.ne r0,r16
	.global L_8f88c2
L_8f88c2:
	b L_8c0244
	.global L_8f88c6
L_8f88c6:
	mov_s r0,blink
L_8f88c8:
	mov_s r1,0x16c8
L_8f88ce:
	bl L_8c9b28
L_8f88d2:
	b_s L_8f88b2
