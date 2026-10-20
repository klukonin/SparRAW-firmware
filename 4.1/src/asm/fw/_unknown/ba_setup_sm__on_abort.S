/* ba_setup_sm__on_abort @ 0x8e93f4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, ba_setup_sm__close_all_timers, basic_sm__inject_event
 */
	.section .text.ba_setup_sm__on_abort,"ax",@progbits
	.global ba_setup_sm__on_abort
ba_setup_sm__on_abort:
L_8e93f4:
	push_s blink
L_8e93f6:
	push_s r13
L_8e93f8:
	bl.d L_8ea430
L_8e93fc:
	mov_s r13,r0
L_8e93fe:
	ld_s r0,[r13,0x44]
L_8e9400:
	mov_s r1,0x8
L_8e9402:
	mov_s r2,0x1
L_8e9404:
	mov_s r3,0x0
L_8e9406:
	bl.d L_8d6a1c
L_8e940a:
	mov_s r4,r3
L_8e940c:
	b L_8c033c
