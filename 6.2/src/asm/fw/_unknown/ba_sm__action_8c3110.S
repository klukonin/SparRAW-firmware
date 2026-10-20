/* ba_sm__action_8c3110 @ 0x8c3110, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8c3110
ba_sm__action_8c3110:
	.global L_8c3110
L_8c3110:
	add_s r0,r0,0x8
L_8c3112:
	cmp_s r1,0x1
L_8c3114:
	mov_s r1,0x4
L_8c3116:
	mov.ne r1,0x5
L_8c311a:
	mov_s r2,0x0
L_8c311c:
	mov_s r3,r2
L_8c311e:
	b.d L_8d9b6c
L_8c3122:
	mov_s r4,r2
