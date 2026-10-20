/* channels_switch_sm__dwell_timeout_cb @ 0x8eb86c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::dwell_timeout_cb() dwell timeout !!!
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__dwell_timeout_cb,"ax",@progbits
	.global channels_switch_sm__dwell_timeout_cb
channels_switch_sm__dwell_timeout_cb:
L_8eb86c:
	push_s blink
L_8eb86e:
	push_s r13
L_8eb870:
	mov_s r13,r0
L_8eb872:
	mov_s r2,0x10145c4
L_8eb878:
	mov_s r0,0x9
L_8eb87a:
	bl.d L_8edfb0
L_8eb87e:
	mov_s r1,0x2
L_8eb880:
	mov_s r0,r13
L_8eb882:
	mov_s r1,0x4
L_8eb884:
	mov_s r2,0x0
L_8eb886:
	mov_s r3,r2
L_8eb888:
	bl.d L_8d6a1c
L_8eb88c:
	mov_s r4,r2
L_8eb88e:
	.byte 0xb1,0x02
