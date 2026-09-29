/* l2mgr__start_discovery @ 0x8fbd1c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__start_discovery_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, mid_list__by_mid_fw, start_find_session, sys_state__broadcast
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__start_discovery
l2mgr__start_discovery:
	.global L_8fbd1c
L_8fbd1c:
	push_s blink
L_8fbd1e:
	push_s r13
L_8fbd20:
	mov_s r13,r0
L_8fbd22:
	mov_s r0,0xf
L_8fbd24:
	bl.d L_8e8a14
L_8fbd28:
	mov_s r1,0x0
L_8fbd2a:
	bl.d L_8cc3dc
L_8fbd2e:
	mov_s r0,r13
L_8fbd30:
	bl.d L_8f9628
L_8fbd34:
	add r0,r0,0x234
L_8fbd38:
	b L_8c025c
