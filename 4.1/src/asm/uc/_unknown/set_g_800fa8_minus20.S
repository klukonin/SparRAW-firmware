/* set_g_800fa8_minus20 @ 0x92b668, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__txss_by_slot, bf_substate__txss_step_by_slot
 */
	.section .text.set_g_800fa8_minus20,"ax",@progbits
	.global set_g_800fa8_minus20
set_g_800fa8_minus20:
	.global L_92b668
L_92b668:
	mov r1,-0x14
L_92b66c:
	mov_s r0,0x800fa0
L_92b672:
	j_s.d [blink]
L_92b674:
	st_s r1,[r0,0x8]
L_92b676:
	nop_s
