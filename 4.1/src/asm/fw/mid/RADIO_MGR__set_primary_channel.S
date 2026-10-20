/* RADIO_MGR__set_primary_channel @ 0x8e1ed8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::set_primary_channel (channelID = %d)
 * Зовут его: discovery__tsf_wa, l2_mgr__connect, l2_mgr__pcp_start_flow, wmi_handler_cfg_rx_chain
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1
 */
	.section .text.RADIO_MGR__set_primary_channel,"ax",@progbits
	.global RADIO_MGR__set_primary_channel
RADIO_MGR__set_primary_channel:
	.global L_8e1ed8
L_8e1ed8:
	sub_s sp,sp,0x8
L_8e1eda:
	push_s blink
L_8e1edc:
	bl L_8c02b0
L_8e1ee0:
	mov_s r16,r1
L_8e1ee2:
	mov_s r14,r2
L_8e1ee4:
	mov_s r15,r0
L_8e1ee6:
	mov_s r19,r3
L_8e1ee8:
	mov r18,r4
L_8e1eec:
	mov r17,r5
L_8e1ef0:
	mov_s r2,0x1015b78
L_8e1ef6:
	mov_s r0,0x8
L_8e1ef8:
	mov_s r1,0x2
L_8e1efa:
	bl.d L_8edfcc
L_8e1efe:
	mov_s r3,r15
L_8e1f00:
	ld_s r0,[gp,-0x30]
L_8e1f02:
	mov_s r2,r15
L_8e1f04:
	ld_s r1,[r0]
L_8e1f06:
	mov_s r3,r16
L_8e1f08:
	ld_s r13,[r1,0x4]
L_8e1f0a:
	mov_s r1,0x1
L_8e1f0c:
	mov_s r4,r14
L_8e1f0e:
	mov r5,r19
L_8e1f12:
	mov r6,r18
L_8e1f16:
	jl_s.d [r13]
L_8e1f18:
	mov r7,r17
L_8e1f1c:
	mov_s r12,0xc
L_8e1f1e:
	b L_8c030e
L_8e1f22:
	nop_s
