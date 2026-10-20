/* l2mgr__send_vring_cfg_done @ 0x8f8e98, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_VRING_CFG_DONE_EVENTID for devid %d.
 * Зовут его: STREAM_MGR__2, STREAM_MGR__ADD, stream_mgr__add_bcast_vring, wmi_vring_cfg
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_vring_cfg_done
l2mgr__send_vring_cfg_done:
	.global L_8f8e98
L_8f8e98:
	push_s blink
L_8f8e9a:
	bl L_8c01d8
L_8f8e9e:
	mov_s r14,r0
L_8f8ea0:
	mov_s r15,r1
L_8f8ea2:
	mov_s r16,r2
L_8f8ea4:
	bl.d L_8c32d8
L_8f8ea8:
	mov_s r17,r3
L_8f8eaa:
	mov_s r13,r0
L_8f8eac:
	st_s r15,[r0,0x4]
L_8f8eae:
	stb_s r14,[r0]
L_8f8eb0:
	stb r16,[r0, 0x1]
L_8f8eb4:
	mov_s r1,0x100d954
L_8f8eba:
	mov_s r0,0x2b
L_8f8ebc:
	bl.d L_8dcc10
L_8f8ec0:
	mov_s r2,r17
L_8f8ec2:
	mov_s r0,r13
L_8f8ec4:
	mov_s r1,0x1821
L_8f8eca:
	mov_s r2,0x8
L_8f8ecc:
	mov_s r3,r17
L_8f8ece:
	mov r4,0x0
L_8f8ed2:
	mov r5,r4
L_8f8ed6:
	bl.d L_8e5474
L_8f8eda:
	mov r6,r4
L_8f8ede:
	b L_8c023c
L_8f8ee2:
	nop_s
