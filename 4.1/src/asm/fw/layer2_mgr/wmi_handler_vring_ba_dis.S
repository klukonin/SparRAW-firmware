/* wmi_handler_vring_ba_dis @ 0x8f2b48, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   layer2_mgr.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, stream_mgr__ba_disable
 */
	.section .text.wmi_handler_vring_ba_dis,"ax",@progbits
	.global wmi_handler_vring_ba_dis
wmi_handler_vring_ba_dis:
	.global L_8f2b48
L_8f2b48:
	push_s blink
L_8f2b4a:
	push_s r13
L_8f2b4c:
	ldb_s r13,[r0]
L_8f2b4e:
	brhs r13,0xa,L_8f2b5c
	.global L_8f2b52
L_8f2b52:
	bl.d L_8c3838
L_8f2b56:
	mov_s r0,r13
L_8f2b58:
	b L_8c033c
	.global L_8f2b5c
L_8f2b5c:
	mov_s r0,blink
L_8f2b5e:
	mov_s r2,0x100c474
L_8f2b64:
	mov_s r1,0x11de
L_8f2b6a:
	bl.d L_8c82c0
L_8f2b6e:
	mov r3,0x2c2
L_8f2b72:
	b_s L_8f2b52
