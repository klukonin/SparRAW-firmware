/* ba_setup_sm__action_8f0c54 @ 0x8f0c54, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, ba_setup_sm__close_all_timers, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__action_8f0c54
ba_setup_sm__action_8f0c54:
	.global L_8f0c54
L_8f0c54:
	push_s blink
L_8f0c56:
	push_s r13
L_8f0c58:
	bl.d L_8f1b84
L_8f0c5c:
	mov_s r13,r0
L_8f0c5e:
	ld_s r0,[r13,0x20]
L_8f0c60:
	mov_s r1,0x8
L_8f0c62:
	mov_s r2,0x1
L_8f0c64:
	mov_s r3,0x0
L_8f0c66:
	bl.d L_8d9b6c
L_8f0c6a:
	mov_s r4,r3
L_8f0c6c:
	b L_8c025c
