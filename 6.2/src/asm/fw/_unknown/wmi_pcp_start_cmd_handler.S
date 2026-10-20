/* wmi_pcp_start_cmd_handler @ 0x8ec840, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_pcp_start_cmd_handler: bi %d, max assoc sta %d, sec_en %d
 *   [NNL] is_go = %d
 *   PCP Start mid=%d BI %x (network_type %x)
 *   wmi_pcp_start_cmd_handler: set abft_len = %d, (received bcon_cmd->abft_len %d)
 *   BCON CMD: PCP Stop mid=%d
 * Зовут его: wmi__host_cmd_dispatch, wmi_cfg_rx_chain, wmi_pcp_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bcon_ctrl__prepare_mid_fw, conn__alloc_and_link, fw_log_emit1, fw_log_emit2, fw_log_emit3, l2_mgr__pcp_start, l2_mgr__pcp_stop, lmac_if__send_cmd_04_thunk
 * Глобалы (через gp): 0x8002d4, 0x8003ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_pcp_start_cmd_handler
wmi_pcp_start_cmd_handler:
	.global L_8ec840
L_8ec840:
	push_s blink
L_8ec842:
	bl L_8c01e0
L_8ec846:
	mov_s r13,r0
L_8ec848:
	ldw_s r0,[r0]
L_8ec84a:
	brlt.d r0,0x1,L_8ec902
L_8ec84e:
	mov_s r14,r1
L_8ec850:
	ldb_s r0,[r13,0xf]
L_8ec852:
	mov_s r15,0x1
L_8ec854:
	cmp_s r0,0x0
L_8ec856:
	ldb_s r0,[r13,0xd]
L_8ec858:
	sub_s.ne r15,r15,r15
L_8ec85a:
	brlt r0,0x2,L_8ec866
L_8ec85e:
	brge r0,0x9,L_8ec866
L_8ec862:
	st.as r0,[gp,0x9a]
	.global L_8ec866
L_8ec866:
	ld.as r3,[gp,0x9a]
L_8ec86a:
	mov_s r0,0x8577a0
L_8ec870:
	stb_s r3,[r0,0x14]
L_8ec872:
	ldw_s r2,[r13]
L_8ec874:
	mov_s r1,0x100b448
L_8ec87a:
	mov_s r0,0x20
L_8ec87c:
	bl.d L_8dcd00
L_8ec880:
	mov_s r4,r15
L_8ec882:
	mov_s r1,0x100b488
L_8ec888:
	mov_s r0,0x20
L_8ec88a:
	bl.d L_8dcc10
L_8ec88e:
	ldb_s r2,[r13,0x11]
L_8ec890:
	ldw_s r3,[r13]
L_8ec892:
	mov_s r1,0x100b49c
L_8ec898:
	st.as r3,[gp,0x54]
L_8ec89c:
	ldb r4,[r13, 0xc]
L_8ec8a0:
	mov_s r0,0x20
L_8ec8a2:
	bl.d L_8dcd00
L_8ec8a6:
	mov_s r2,r14
L_8ec8a8:
	ldb_s r0,[r13,0xe]
L_8ec8aa:
	mov_s r2,0x1
L_8ec8ac:
	cmp_s r0,0x0
L_8ec8ae:
	sub_s.ne r2,r2,r2
L_8ec8b0:
	mov_s r0,0x803b80
L_8ec8b6:
	st_s r15,[r0,0x6c]
L_8ec8b8:
	st_s r2,[r0,0x70]
L_8ec8ba:
	mov_s r0,r14
L_8ec8bc:
	bl.d L_8f8624
L_8ec8c0:
	mov_s r1,r15
L_8ec8c2:
	ldb_s r3,[r13,0x12]
L_8ec8c4:
	brlt r3,0x1,L_8ec8cc
L_8ec8c8:
	brlt r3,0x9,L_8ec8d0
	.global L_8ec8cc
L_8ec8cc:
	mov_s r15,0x1
L_8ec8ce:
	b_s L_8ec8d4
	.global L_8ec8d0
L_8ec8d0:
	sub_s r15,r3,0x1
L_8ec8d2:
	extb_s r15,r15
	.global L_8ec8d4
L_8ec8d4:
	mov_s r1,0x100b4c8
L_8ec8da:
	mov_s r0,0x20
L_8ec8dc:
	bl.d L_8dcc80
L_8ec8e0:
	mov_s r2,r15
L_8ec8e2:
	ldb_s r1,[r13,0xc]
L_8ec8e4:
	mov_s r0,r14
L_8ec8e6:
	ldb_s r2,[r13,0x10]
L_8ec8e8:
	ldb_s r3,[r13,0x11]
L_8ec8ea:
	bl.d L_8f706c
L_8ec8ee:
	mov_s r4,r15
L_8ec8f0:
	mov_s r0,0x0
L_8ec8f2:
	mov_s r1,0x1
L_8ec8f4:
	bl.d L_8e5258
L_8ec8f8:
	mov_s r2,r14
L_8ec8fa:
	bl.d L_8db718
L_8ec8fe:
	mov_s r0,0x1
L_8ec900:
	b_s L_8ec916
	.global L_8ec902
L_8ec902:
	mov_s r1,0x100b518
L_8ec908:
	mov_s r0,0x20
L_8ec90a:
	bl.d L_8dcc10
L_8ec90e:
	mov_s r2,r14
L_8ec910:
	bl.d L_8f7160
L_8ec914:
	mov_s r0,r14
	.global L_8ec916
L_8ec916:
	b L_8c024c
L_8ec91a:
	nop_s
