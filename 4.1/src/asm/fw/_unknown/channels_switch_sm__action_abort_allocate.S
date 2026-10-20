/* channels_switch_sm__action_abort_allocate @ 0x8e8ed8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_abort_allocate() while allocating radio!!!
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__action_abort_allocate,"ax",@progbits
	.global channels_switch_sm__action_abort_allocate
channels_switch_sm__action_abort_allocate:
L_8e8ed8:
	push_s blink
L_8e8eda:
	push_s r13
L_8e8edc:
	mov_s r13,r0
L_8e8ede:
	mov_s r2,0x10144a8
L_8e8ee4:
	mov_s r0,0x9
L_8e8ee6:
	bl.d L_8edfb0
L_8e8eea:
	mov_s r1,0x2
L_8e8eec:
	mov_s r0,r13
L_8e8eee:
	mov_s r1,0x6
L_8e8ef0:
	mov_s r2,0x0
L_8e8ef2:
	mov_s r3,r2
L_8e8ef4:
	bl.d L_8d6a1c
L_8e8ef8:
	mov_s r4,r2
L_8e8efa:
	b L_8c033c
L_8e8efe:
	nop_s
