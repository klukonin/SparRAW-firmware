/* find_mngr__enter_listen @ 0x8edbbc, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   listen()
 *   discovery.cpp
 * Зовут его: l2_mgr__wmi_cmd_handler_start_listen_8f3374
 * Зовёт сам: __ld_r13_ret, find_mng__listen, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.find_mngr__enter_listen,"ax",@progbits
	.global find_mngr__enter_listen
find_mngr__enter_listen:
	.global L_8edbbc
L_8edbbc:
	push_s blink
L_8edbbe:
	push_s r13
L_8edbc0:
	mov_s r13,r0
L_8edbc2:
	mov_s r2,0x1012824
L_8edbc8:
	mov_s r0,0xc
L_8edbca:
	bl.d L_8edfb0
L_8edbce:
	mov_s r1,0x2
L_8edbd0:
	ld_s r0,[r13,0x8]
L_8edbd2:
	ld_s r0,[r0,0x78]
L_8edbd4:
	brne_s r0,0,L_8edbea
	.global L_8edbd6
L_8edbd6:
	ld_s r0,[r13,0x4]
L_8edbd8:
	ld_s r0,[r0,0x4c]
L_8edbda:
	brne r0,0x1,L_8edc02
	.global L_8edbde
L_8edbde:
	bl.d L_8d7e50
L_8edbe2:
	add r0,r13,0xc
L_8edbe6:
	b L_8c033c
	.global L_8edbea
L_8edbea:
	mov_s r0,blink
L_8edbec:
	mov_s r2,0x1012024
L_8edbf2:
	mov_s r1,0x1237
L_8edbf8:
	bl.d L_8c82c0
L_8edbfc:
	mov r3,0x1f0
L_8edc00:
	b_s L_8edbd6
	.global L_8edc02
L_8edc02:
	mov_s r0,blink
L_8edc04:
	mov_s r2,0x1012024
L_8edc0a:
	mov_s r1,0x1238
L_8edc10:
	bl.d L_8c82c0
L_8edc14:
	mov r3,0x1f1
L_8edc18:
	b_s L_8edbde
L_8edc1a:
	nop_s
