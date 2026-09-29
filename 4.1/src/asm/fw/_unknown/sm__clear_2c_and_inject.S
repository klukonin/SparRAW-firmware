/* sm__clear_2c_and_inject @ 0x8d6abc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.sm__clear_2c_and_inject,"ax",@progbits
	.global sm__clear_2c_and_inject
sm__clear_2c_and_inject:
L_8d6abc:
	mov_s r2,0x0
L_8d6abe:
	st_s r2,[r0,0x2c]
L_8d6ac0:
	mov_s r1,0x1
L_8d6ac2:
	mov_s r3,r2
L_8d6ac4:
	b.d L_8d6a1c
