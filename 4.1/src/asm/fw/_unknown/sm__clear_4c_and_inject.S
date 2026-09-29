/* sm__clear_4c_and_inject @ 0x8d6ac8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.sm__clear_4c_and_inject,"ax",@progbits
	.global sm__clear_4c_and_inject
sm__clear_4c_and_inject:
L_8d6ac8:
	mov_s r4,r2
	.global sub_8d6aca
sub_8d6aca:
L_8d6aca:
	nop_s
L_8d6acc:
	mov_s r2,0x0
L_8d6ace:
	st_s r2,[r0,0x4c]
L_8d6ad0:
	mov_s r1,0x2
L_8d6ad2:
	mov_s r3,r2
L_8d6ad4:
	b.d L_8d6a1c
