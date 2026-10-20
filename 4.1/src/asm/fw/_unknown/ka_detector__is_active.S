/* ka_detector__is_active @ 0x8d72b0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_detector__configure, ka_detector__get_state, ka_detector__rearm, ka_necessity_detector__start_monitoring
 */
	.section .text.ka_detector__is_active,"ax",@progbits
	.global ka_detector__is_active
ka_detector__is_active:
	.global L_8d72b0
L_8d72b0:
	ldb r2,[r0, 0x30]
L_8d72b4:
	cmp r2,0xff
L_8d72b8:
	mov_s r1,0x0
L_8d72ba:
	beq_s L_8d72c0
L_8d72bc:
	ld_s r0,[r0,0x34]
L_8d72be:
	brne_s r0,0,L_8d72c4
	.global L_8d72c0
L_8d72c0:
	mov_s r0,r1
L_8d72c2:
	b_s L_8d72c6
	.global L_8d72c4
L_8d72c4:
	mov_s r0,0x1
	.global L_8d72c6
L_8d72c6:
	j_s.d [blink]
L_8d72c8:
	extb_s r0,r0
L_8d72ca:
	nop_s
