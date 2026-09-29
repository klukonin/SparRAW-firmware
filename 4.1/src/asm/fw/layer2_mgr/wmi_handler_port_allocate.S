/* wmi_handler_port_allocate @ 0x8f2e50, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Error in MAC address !!!
 *   Cannot open default MID !!!
 *   <<---- [HOST EVENT] WMI_PORT_ALLOCATED_EVENTID for midid %d.
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, l2mgr__mac_started_log, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.wmi_handler_port_allocate,"ax",@progbits
	.global wmi_handler_port_allocate
wmi_handler_port_allocate:
	.global L_8f2e50
L_8f2e50:
	push_s blink
L_8f2e52:
	bl L_8c02c0
L_8f2e56:
	bl.d L_8c2b68
L_8f2e5a:
	mov_s r13,r0
L_8f2e5c:
	mov_s r14,r0
L_8f2e5e:
	ldb_s r0,[r13,0x7]
L_8f2e60:
	breq_s r0,0,L_8f2e90
L_8f2e62:
	ldb_s r1,[r13]
L_8f2e64:
	bxor r1,r1,0x0
L_8f2e68:
	mov_s r15,0x0
L_8f2e6a:
	bbit1 r1,0x0,L_8f2e7e
L_8f2e6e:
	mov_s r2,0x100d390
L_8f2e74:
	mov_s r0,0xb
L_8f2e76:
	bl.d L_8edfb0
L_8f2e7a:
	mov_s r1,r15
L_8f2e7c:
	b_s L_8f2e8c
	.global L_8f2e7e
L_8f2e7e:
	mov_s r1,r13
L_8f2e80:
	mov_s r2,r15
L_8f2e82:
	bl.d L_8f141c
L_8f2e86:
	mov_s r3,r15
L_8f2e88:
	breq r0,0x1,L_8f2ea0
	.global L_8f2e8c
L_8f2e8c:
	mov_s r15,0x1
L_8f2e8e:
	b_s L_8f2ea0
	.global L_8f2e90
L_8f2e90:
	mov_s r2,0x100d3ac
L_8f2e96:
	mov_s r0,0xb
L_8f2e98:
	mov_s r15,0x1
L_8f2e9a:
	bl.d L_8edfb0
L_8f2e9e:
	mov_s r1,r15
	.global L_8f2ea0
L_8f2ea0:
	stb_s r15,[r14]
L_8f2ea2:
	mov_s r2,0x100d3c8
L_8f2ea8:
	mov_s r0,0xb
L_8f2eaa:
	mov_s r1,0x2
L_8f2eac:
	bl.d L_8edfcc
L_8f2eb0:
	ldb_s r3,[r13,0x7]
L_8f2eb2:
	mov_s r0,r14
L_8f2eb4:
	mov_s r1,0x1911
L_8f2eba:
	mov_s r2,0x4
L_8f2ebc:
	ldb_s r3,[r13,0x7]
L_8f2ebe:
	mov r4,0x0
L_8f2ec2:
	bl.d L_8e0874
L_8f2ec6:
	mov r5,r4
L_8f2eca:
	b L_8c032c
L_8f2ece:
	nop_s
