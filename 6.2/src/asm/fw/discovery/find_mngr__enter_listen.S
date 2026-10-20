/* find_mngr__enter_listen @ 0x8f5f14, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   listen()
 * Зовут его: l2_mgr__wmi_cmd_handler_start_listen
 * Зовёт сам: __ld_r13_to_r13_ret, find_mng__listen, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__enter_listen
find_mngr__enter_listen:
	.global L_8f5f14
L_8f5f14:
	push_s blink
L_8f5f16:
	push_s r13
L_8f5f18:
	mov_s r13,r0
L_8f5f1a:
	mov_s r1,0x1016fd4
L_8f5f20:
	bl.d L_8dcba8
L_8f5f24:
	mov_s r0,0x2c
L_8f5f26:
	ld_s r0,[r13,0x8]
L_8f5f28:
	ld_s r0,[r0,0x78]
L_8f5f2a:
	brne_s r0,0,L_8f5f40
	.global L_8f5f2c
L_8f5f2c:
	ld_s r0,[r13,0x4]
L_8f5f2e:
	ld_s r0,[r0,0x4c]
L_8f5f30:
	brne r0,0x1,L_8f5f4e
	.global L_8f5f34
L_8f5f34:
	bl.d L_8dafa8
L_8f5f38:
	add r0,r13,0xc
L_8f5f3c:
	b L_8c025c
	.global L_8f5f40
L_8f5f40:
	mov_s r0,blink
L_8f5f42:
	mov_s r1,0x1237
L_8f5f48:
	bl L_8c9b28
L_8f5f4c:
	b_s L_8f5f2c
	.global L_8f5f4e
L_8f5f4e:
	mov_s r0,blink
L_8f5f50:
	mov_s r1,0x1238
L_8f5f56:
	bl L_8c9b28
L_8f5f5a:
	b_s L_8f5f34
