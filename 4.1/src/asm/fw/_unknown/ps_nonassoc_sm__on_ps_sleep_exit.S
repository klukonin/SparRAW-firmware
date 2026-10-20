/* ps_nonassoc_sm__on_ps_sleep_exit @ 0x8dd3bc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: u_schd__schedule
 */
	.section .text.ps_nonassoc_sm__on_ps_sleep_exit,"ax",@progbits
	.global ps_nonassoc_sm__on_ps_sleep_exit
ps_nonassoc_sm__on_ps_sleep_exit:
L_8dd3bc:
	push_s blink
L_8dd3be:
	mov_s r1,r0
L_8dd3c0:
	mov_s r0,0x1d368
L_8dd3c6:
	ld.as r4,[gp,-0x13]
L_8dd3ca:
	mov_s r2,0x0
L_8dd3cc:
	mov_s r3,0x1
L_8dd3ce:
	mov_s r5,r2
L_8dd3d0:
	bl.d L_8dc92c
L_8dd3d4:
	mov_s r6,r2
L_8dd3d6:
	st.as r0,[gp,-0x15]
L_8dd3da:
	pop_s blink
