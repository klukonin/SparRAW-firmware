/* bf_sm__assert_and_clear @ 0x922700, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   beamforming_sm.c
 * Зовут его: bf_sm__substate_advance
 * Зовёт сам: bf_sm__clear_pending, uc_sysassert
 */
	.section .text.bf_sm__assert_and_clear,"ax",@progbits
	.global bf_sm__assert_and_clear
bf_sm__assert_and_clear:
L_922700:
	mov_s r0,blink
L_922702:
	mov_s r2,0x1000754
L_922708:
	mov_s r1,0x14
L_92270a:
	bl.d L_925548
L_92270e:
	mov r3,0x1c5
	.global L_922712
L_922712:
	bl.d L_92208c
L_922716:
	mov_s r0,r14
