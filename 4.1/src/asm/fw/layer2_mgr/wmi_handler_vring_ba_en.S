/* wmi_handler_vring_ba_en @ 0x8f2b74, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, vring_ba_en__race_check
 */
	.section .text.wmi_handler_vring_ba_en,"ax",@progbits
	.global wmi_handler_vring_ba_en
wmi_handler_vring_ba_en:
	.global L_8f2b74
L_8f2b74:
	push_s blink
L_8f2b76:
	bl L_8c02c4
L_8f2b7a:
	ldb_s r14,[r0]
L_8f2b7c:
	brhs.d r14,0xa,L_8f2b92
L_8f2b80:
	mov_s r13,r0
	.global L_8f2b82
L_8f2b82:
	ldb_s r1,[r13,0x1]
L_8f2b84:
	mov_s r0,r14
L_8f2b86:
	ldw_s r2,[r13,0x2]
L_8f2b88:
	bl.d L_8c3884
L_8f2b8c:
	ldb_s r3,[r13,0x4]
L_8f2b8e:
	b L_8c0334
	.global L_8f2b92
L_8f2b92:
	mov_s r0,blink
L_8f2b94:
	mov_s r2,0x100c474
L_8f2b9a:
	mov_s r1,0x11dd
L_8f2ba0:
	bl.d L_8c82c0
L_8f2ba4:
	mov r3,0x2b9
L_8f2ba8:
	b_s L_8f2b82
L_8f2baa:
	nop_s
