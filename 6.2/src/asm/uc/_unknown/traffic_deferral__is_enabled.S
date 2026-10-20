/* traffic_deferral__is_enabled @ 0x935654, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global traffic_deferral__is_enabled
traffic_deferral__is_enabled:
	.global L_935654
L_935654:
	ldb r2,[0x802194]
L_93565c:
	mov r4,r0
L_935660:
	breq.d r2,0x0,L_935670
L_935664:
	mov_s r0,0x0
L_935666:
	ld.as r3,[r4,0x4d]
L_93566a:
	cmp_s r3,0x0
L_93566c:
	jne [blink]
	.global L_935670
L_935670:
	mov_s r0,0x1
L_935672:
	st.as r0,[r4,0x51]
L_935676:
	add r4,r4,0x148
L_93567a:
	j_s.d [blink]
L_93567c:
	stb r1,[r4]
