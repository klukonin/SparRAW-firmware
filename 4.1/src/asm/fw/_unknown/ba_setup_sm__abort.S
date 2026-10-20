/* ba_setup_sm__abort @ 0x8efc34, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, ba_setup_sm__close_all_timers, basic_sm__inject_event
 */
	.section .text.ba_setup_sm__abort,"ax",@progbits
	.global ba_setup_sm__abort
ba_setup_sm__abort:
	.byte 0x0f
	.byte 0xe8
	.global sub_8efc36
sub_8efc36:
L_8efc36:
	nop_s
L_8efc38:
	push_s blink
L_8efc3a:
	push_s r13
L_8efc3c:
	mov_s r13,r0
L_8efc3e:
	ld_s r0,[r0,0x44]
L_8efc40:
	mov_s r1,0xb
L_8efc42:
	mov_s r2,0x0
L_8efc44:
	mov_s r3,r2
L_8efc46:
	bl.d L_8d6a1c
L_8efc4a:
	mov_s r4,r2
L_8efc4c:
	bl.d L_8ea430
L_8efc50:
	mov_s r0,r13
L_8efc52:
	.byte 0xed,0x06
