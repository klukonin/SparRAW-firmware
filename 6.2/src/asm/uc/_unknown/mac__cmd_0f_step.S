/* mac__cmd_0f_step @ 0x92e438, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti__prepare_sweep_set
 * Зовёт сам: aw__set_new_tbtt
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__cmd_0f_step
mac__cmd_0f_step:
	.global L_92e438
L_92e438:
	st.a r13,[sp,-0x8]
L_92e43c:
	st_s r14,[sp,0x4]
L_92e43e:
	mov_s r14,blink
L_92e440:
	bl.d L_93520c
L_92e444:
	mov r13,r0
L_92e448:
	mov_s r0,0x0
L_92e44a:
	st.as r0,[r13,0x50]
L_92e44e:
	mov_s blink,r14
L_92e450:
	ld_s r14,[sp,0x4]
L_92e452:
	j_s.d [blink]
L_92e454:
	ld.ab r13,[sp,0x8]
