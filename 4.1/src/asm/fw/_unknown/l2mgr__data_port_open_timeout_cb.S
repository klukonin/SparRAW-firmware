/* l2mgr__data_port_open_timeout_cb @ 0x8eaa3c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   data_port_open_timeout_cb
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.l2mgr__data_port_open_timeout_cb,"ax",@progbits
	.global l2mgr__data_port_open_timeout_cb
l2mgr__data_port_open_timeout_cb:
L_8eaa3c:
	push_s blink
L_8eaa3e:
	push_s r13
L_8eaa40:
	mov_s r13,r0
L_8eaa42:
	mov_s r2,0x100f240
L_8eaa48:
	mov_s r0,0xa
L_8eaa4a:
	bl.d L_8edfb0
L_8eaa4e:
	mov_s r1,0x1
L_8eaa50:
	mov_s r2,0x0
L_8eaa52:
	st_s r2,[r13,0x38]
L_8eaa54:
	mov_s r0,r13
L_8eaa56:
	mov_s r1,0x5
L_8eaa58:
	mov_s r3,r2
L_8eaa5a:
	bl.d L_8d6a1c
L_8eaa5e:
	mov_s r4,r2
L_8eaa60:
	b L_8c033c
