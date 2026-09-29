/* sm__clear_and_inject @ 0x8d6adc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.sm__clear_and_inject,"ax",@progbits
	.global sm__clear_and_inject
sm__clear_and_inject:
L_8d6adc:
	mov_s r2,0x0
L_8d6ade:
	st_s r2,[r0,0x30]
L_8d6ae0:
	mov_s r1,0x2
L_8d6ae2:
	mov_s r3,r2
L_8d6ae4:
	b.d L_8d6a1c
L_8d6ae8:
	mov_s r4,r2
L_8d6aea:
	nop_s
