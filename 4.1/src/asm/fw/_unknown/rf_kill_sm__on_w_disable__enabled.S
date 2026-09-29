/* rf_kill_sm__on_w_disable__enabled @ 0x8eafd0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: low_sme__handle_rf_kill, rf_kill__set_flag
 * Глобалы (через gp): 0x800226
 */
	.section .text.rf_kill_sm__on_w_disable__enabled,"ax",@progbits
	.global rf_kill_sm__on_w_disable__enabled
rf_kill_sm__on_w_disable__enabled:
L_8eafd0:
	push_s blink
L_8eafd2:
	mov_s r3,r1
L_8eafd4:
	mov_s r2,0x1
L_8eafd6:
	bl.d L_8f2948
L_8eafda:
	mov_s r0,r2
L_8eafdc:
	brne_s r3,0,L_8eafe2
L_8eafde:
	ldb_s r0,[gp,0xb6]
L_8eafe0:
	breq_s r0,0,L_8eafe6
	.global L_8eafe2
L_8eafe2:
	mov_s r0,r2
L_8eafe4:
	b_s L_8eafe8
	.global L_8eafe6
L_8eafe6:
	mov_s r0,0x0
	.global L_8eafe8
L_8eafe8:
	bl L_8cb4fc
L_8eafec:
	pop_s blink
L_8eafee:
	j_s [blink]
