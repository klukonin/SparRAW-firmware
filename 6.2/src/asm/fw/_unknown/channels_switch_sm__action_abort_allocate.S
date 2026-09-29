/* channels_switch_sm__action_abort_allocate @ 0x8c2018, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_abort_allocate() while allocating radio!!!
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_abort_allocate
channels_switch_sm__action_abort_allocate:
	.global L_8c2018
L_8c2018:
	push_s blink
L_8c201a:
	push_s r13
L_8c201c:
	mov_s r13,r0
L_8c201e:
	mov_s r1,0x10174dc
L_8c2024:
	bl.d L_8dcba8
L_8c2028:
	mov_s r0,0x29
L_8c202a:
	mov_s r0,r13
L_8c202c:
	mov_s r1,0x6
L_8c202e:
	mov_s r2,0x0
L_8c2030:
	mov_s r3,r2
L_8c2032:
	bl.d L_8d9b6c
L_8c2036:
	mov_s r4,r2
L_8c2038:
	b L_8c025c
