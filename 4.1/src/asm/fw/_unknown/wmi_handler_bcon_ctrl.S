/* wmi_handler_bcon_ctrl @ 0x8e7924, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_pcp_start_cmd_handler: bi %d, max assoc sta %d, sec_en %d
 *   [NNL] is_go = %d
 *   PCP Start mid=%d BI %x (network_type %x)
 *   BCON CMD: PCP Stop mid=%d
 * Зовут его: host_if__wmi_cmd_dispatch, wmi_handler_cfg_rx_chain, wmi_handler_pcp_start
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bcon_ctrl__prepare_mid, fw_log__emit1, fw_log__emit3, l2_mgr__pcp_start, l2_mgr__pcp_stop, lmac_if_send_cmd_0x1b, tail_lmac_if_send_cmd_0x04
 * Глобалы (через gp): 0x8002c0, 0x8003d8
 */
	.section .text.wmi_handler_bcon_ctrl,"ax",@progbits
	.global wmi_handler_bcon_ctrl
wmi_handler_bcon_ctrl:
	.global L_8e7924
L_8e7924:
	push_s blink
L_8e7926:
	bl L_8c02c0
L_8e792a:
	ldw_s r3,[r0]
L_8e792c:
	mov_s r13,r0
L_8e792e:
	brlt.d r3,0x1,L_8e79c2
L_8e7932:
	mov_s r14,r1
L_8e7934:
	ldb_s r0,[r13,0xf]
L_8e7936:
	mov_s r15,0x1
L_8e7938:
	cmp_s r0,0x0
L_8e793a:
	ldb_s r0,[r13,0xd]
L_8e793c:
	sub_s.ne r15,r15,r15
L_8e793e:
	brlt r0,0x2,L_8e794a
L_8e7942:
	brge r0,0x9,L_8e794a
L_8e7946:
	st.as r0,[gp,0x9a]
	.global L_8e794a
L_8e794a:
	mov_s r2,0x1009eec
L_8e7950:
	ld.as r4,[gp,0x9a]
L_8e7954:
	mov_s r0,0x0
L_8e7956:
	mov_s r1,0x2
L_8e7958:
	bl.d L_8ee034
L_8e795c:
	mov_s r5,r15
L_8e795e:
	mov_s r2,0x1009f2c
L_8e7964:
	mov_s r0,0x0
L_8e7966:
	mov_s r1,0x2
L_8e7968:
	bl.d L_8edfcc
L_8e796c:
	ldb_s r3,[r13,0x11]
L_8e796e:
	ldw r4,[r13]
L_8e7972:
	mov_s r2,0x1009f40
L_8e7978:
	st.as r4,[gp,0x54]
L_8e797c:
	ldb r5,[r13, 0xc]
L_8e7980:
	mov_s r0,0x0
L_8e7982:
	mov_s r1,0x2
L_8e7984:
	bl.d L_8ee034
L_8e7988:
	mov_s r3,r14
L_8e798a:
	ldb_s r0,[r13,0xe]
L_8e798c:
	mov_s r2,0x1
L_8e798e:
	cmp_s r0,0x0
L_8e7990:
	sub_s.ne r2,r2,r2
L_8e7992:
	mov_s r0,0x8033dc
L_8e7998:
	st_s r15,[r0,0x6c]
L_8e799a:
	st_s r2,[r0,0x70]
L_8e799c:
	mov_s r0,r14
L_8e799e:
	bl.d L_8f02d4
L_8e79a2:
	mov_s r1,r15
L_8e79a4:
	ldb_s r1,[r13,0xc]
L_8e79a6:
	mov_s r0,r14
L_8e79a8:
	ldb_s r2,[r13,0x10]
L_8e79aa:
	bl.d L_8eeec0
L_8e79ae:
	ldb_s r3,[r13,0x11]
L_8e79b0:
	mov_s r0,0x0
L_8e79b2:
	mov_s r1,0x1
L_8e79b4:
	bl.d L_8e0718
L_8e79b8:
	mov_s r2,r14
L_8e79ba:
	bl.d L_8d8498
L_8e79be:
	mov_s r0,0x1
L_8e79c0:
	b_s L_8e79d8
	.global L_8e79c2
L_8e79c2:
	mov_s r2,0x1009f6c
L_8e79c8:
	mov_s r0,0x0
L_8e79ca:
	mov_s r1,0x2
L_8e79cc:
	bl.d L_8edfcc
L_8e79d0:
	mov_s r3,r14
L_8e79d2:
	bl.d L_8eef70
L_8e79d6:
	mov_s r0,r14
	.global L_8e79d8
L_8e79d8:
	b L_8c032c
