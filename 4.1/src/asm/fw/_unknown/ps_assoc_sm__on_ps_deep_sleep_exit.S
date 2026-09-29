/* ps_assoc_sm__on_ps_deep_sleep_exit @ 0x8dd398, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: u_schd__schedule
 */
	.section .text.ps_assoc_sm__on_ps_deep_sleep_exit,"ax",@progbits
	.global ps_assoc_sm__on_ps_deep_sleep_exit
ps_assoc_sm__on_ps_deep_sleep_exit:
L_8dd398:
	push_s blink
L_8dd39a:
	mov_s r1,r0
L_8dd39c:
	mov_s r0,0x1d330
L_8dd3a2:
	ld.as r4,[gp,-0x12]
L_8dd3a6:
	mov_s r2,0x0
L_8dd3a8:
	mov_s r3,0x1
L_8dd3aa:
	mov_s r5,r2
L_8dd3ac:
	bl.d L_8dc92c
L_8dd3b0:
	mov_s r6,r2
L_8dd3b2:
	st.as r0,[gp,-0x14]
L_8dd3b6:
	pop_s blink
