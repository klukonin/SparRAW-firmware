/* find_main_sm__stop_searching @ 0x8f9b84, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::stop_searching()
 *   scan_mngr::stop_sm_event_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, find_main_sm__stop, find_mngr__del_discovery_bcon, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_main_sm__stop_searching
find_main_sm__stop_searching:
	.global L_8f9b84
L_8f9b84:
	push_s blink
L_8f9b86:
	push_s r13
L_8f9b88:
	mov_s r13,r0
L_8f9b8a:
	mov_s r1,0x1017c1c
L_8f9b90:
	bl.d L_8dcba8
L_8f9b94:
	mov_s r0,0x2c
L_8f9b96:
	bl.d L_8c8d6c
L_8f9b9a:
	ld_s r0,[r13,0x10]
L_8f9b9c:
	bl.d L_8f9ac8
L_8f9ba0:
	mov_s r0,r13
L_8f9ba2:
	b L_8c025c
L_8f9ba6:
	nop_s
L_8f9ba8:
	push_s blink
L_8f9baa:
	push_s r13
L_8f9bac:
	mov_s r13,r0
L_8f9bae:
	mov_s r1,0x101664c
L_8f9bb4:
	bl.d L_8dcba8
L_8f9bb8:
	mov_s r0,0x29
L_8f9bba:
	ld r0,[r13, 0x80]
L_8f9bbe:
	mov_s r1,0x5
L_8f9bc0:
	mov_s r2,0x0
L_8f9bc2:
	mov_s r3,r2
L_8f9bc4:
	bl.d L_8d9b6c
L_8f9bc8:
	mov_s r4,r2
L_8f9bca:
	b L_8c025c
L_8f9bce:
	nop_s
