/* radio_mgr__inject_evt3 @ 0x8dd0a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__enqueue_request
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.radio_mgr__inject_evt3,"ax",@progbits
	.global radio_mgr__inject_evt3
radio_mgr__inject_evt3:
	.global L_8dd0a4
L_8dd0a4:
	add_s r0,r0,0x28
L_8dd0a6:
	mov_s r1,0x3
L_8dd0a8:
	mov_s r2,0x0
L_8dd0aa:
	mov_s r3,r2
L_8dd0ac:
	b.d L_8d6a1c
L_8dd0b0:
	mov_s r4,r2
L_8dd0b2:
	nop_s
