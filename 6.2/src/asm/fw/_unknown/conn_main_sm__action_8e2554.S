/* conn_main_sm__action_8e2554 @ 0x8e2554, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__action_8e2554
conn_main_sm__action_8e2554:
	.global L_8e2554
L_8e2554:
	mov_s r1,0x1
L_8e2556:
	j_s.d [blink]
L_8e2558:
	st_s r1,[r0,0x34]
L_8e255a:
	nop_s
