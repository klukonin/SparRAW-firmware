/* ba_setup_sm__action_8f7fdc @ 0x8f7fdc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, ba_setup_sm__close_all_timers, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__action_8f7fdc
ba_setup_sm__action_8f7fdc:
	.global L_8f7fdc
L_8f7fdc:
	push_s blink
L_8f7fde:
	push_s r13
L_8f7fe0:
	mov_s r13,r0
L_8f7fe2:
	ld_s r0,[r0,0x20]
L_8f7fe4:
	mov_s r1,0xb
L_8f7fe6:
	mov_s r2,0x0
L_8f7fe8:
	mov_s r3,r2
L_8f7fea:
	bl.d L_8d9b6c
L_8f7fee:
	mov_s r4,r2
L_8f7ff0:
	bl.d L_8f1b84
L_8f7ff4:
	mov_s r0,r13
L_8f7ff6:
	b L_8c025c
L_8f7ffa:
	nop_s
