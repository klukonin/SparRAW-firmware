/* mlme_sm__data_port_open_ev_handle @ 0x8f2070, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ctrl_assoc_res_timeout_cb
 * Зовут его: boot__init_named_object
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, mem_pool__free_thunk, memcpy_fw, mgmt_pkt__release, mlme_notify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__data_port_open_ev_handle
mlme_sm__data_port_open_ev_handle:
	.global L_8f2070
L_8f2070:
	add_s r1,r1,r2
L_8f2072:
	mov_s r0,r3
L_8f2074:
	b.d L_8c0380
L_8f2078:
	mov_s r2,r4
L_8f207a:
	nop_s
L_8f207c:
	push_s blink
L_8f207e:
	bl L_8c01e4
L_8f2082:
	mov_s r14,r0
L_8f2084:
	mov_s r1,0x10113b0
L_8f208a:
	bl.d L_8dcba8
L_8f208e:
	mov_s r0,0x1a
L_8f2090:
	ld_s r0,[r14,0x30]
L_8f2092:
	mov_s r13,0x0
L_8f2094:
	st_s r13,[r14,0x18]
L_8f2096:
	breq_s r0,0,L_8f20a4
L_8f2098:
	bl L_8cb180
L_8f209c:
	bl.d L_8cb15c
L_8f20a0:
	ld_s r0,[r14,0x30]
L_8f20a2:
	st_s r13,[r14,0x30]
	.global L_8f20a4
L_8f20a4:
	ld_s r1,[r14,0x20]
L_8f20a6:
	mov_s r0,r14
L_8f20a8:
	ldb_s r1,[r1,0x8]
L_8f20aa:
	mov_s r2,0x1
L_8f20ac:
	mov_s r3,0x5
L_8f20ae:
	bl.d L_8de394
L_8f20b2:
	mov r4,0x0
L_8f20b6:
	b L_8c0254
L_8f20ba:
	nop_s
