/* l2mgr__start_discovery @ 0x8f3354, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_discovery_start
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r13_ret, mid_list__by_mid, start_find_session
 */
	.section .text.l2mgr__start_discovery,"ax",@progbits
	.global l2mgr__start_discovery
l2mgr__start_discovery:
	.global L_8f3354
L_8f3354:
	push_s blink
L_8f3356:
	push_s r13
L_8f3358:
	mov_s r13,r0
L_8f335a:
	mov_s r0,0xf
L_8f335c:
	bl.d L_8e3a08
L_8f3360:
	mov_s r1,0x0
L_8f3362:
	bl.d L_8ca1b0
L_8f3366:
	mov_s r0,r13
L_8f3368:
	bl.d L_8f12f8
L_8f336c:
	add r0,r0,0x234
L_8f3370:
	b L_8c033c
