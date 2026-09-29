/* RADIO_MGR__set_primary_channel @ 0x8e6cec, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::set_primary_channel (channelID = %d)
 * Зовут его: discovery__tsf_wa, l2_mgr__connect, l2_mgr__pcp_start_flow, wmi_cfg_rx_chain
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global RADIO_MGR__set_primary_channel
RADIO_MGR__set_primary_channel:
	.global L_8e6cec
L_8e6cec:
	sub_s sp,sp,0x8
L_8e6cee:
	push_s blink
L_8e6cf0:
	bl L_8c01d0
L_8e6cf4:
	mov_s r16,r1
L_8e6cf6:
	mov_s r14,r2
L_8e6cf8:
	mov_s r15,r0
L_8e6cfa:
	mov_s r19,r3
L_8e6cfc:
	mov r18,r4
L_8e6d00:
	mov r17,r5
L_8e6d04:
	mov_s r1,0x1019014
L_8e6d0a:
	mov_s r0,0x28
L_8e6d0c:
	bl.d L_8dcc10
L_8e6d10:
	mov_s r2,r15
L_8e6d12:
	ld_s r0,[gp,-0x40]
L_8e6d14:
	mov_s r2,r15
L_8e6d16:
	ld_s r1,[r0]
L_8e6d18:
	mov_s r3,r16
L_8e6d1a:
	ld_s r13,[r1,0x4]
L_8e6d1c:
	mov_s r1,0x1
L_8e6d1e:
	mov_s r4,r14
L_8e6d20:
	mov r5,r19
L_8e6d24:
	mov r6,r18
L_8e6d28:
	jl_s.d [r13]
L_8e6d2a:
	mov r7,r17
L_8e6d2e:
	mov_s r12,0xc
L_8e6d30:
	b L_8c022e
